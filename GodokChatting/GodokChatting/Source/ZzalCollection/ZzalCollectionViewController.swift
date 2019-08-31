//
//  ZzalCollectionViewController.swift
//  GodokChatting
//
//  Created by 국윤수 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import SwiftlyIndicator
import Then
import Kingfisher

private let zzalCellID = "zzalCellID"

final class ZzalCollectionViewController: BaseViewController {

    private var viewModel: ZzalCollectionViewModel!
    private let bag = DisposeBag()

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .gray
    $0.delegate = self
    $0.dataSource = self
    $0.register(ZzalCell.self, forCellWithReuseIdentifier: zzalCellID)
    let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.minimumInteritemSpacing = 0
    layout?.minimumLineSpacing = 1
  }

    convenience init( _ viewModel: ZzalCollectionViewModel) {
        self.init()
        self.viewModel = viewModel
        self.title = viewModel.categoryType.title
    }

  override func setup() {
    super.setup()
    view.addSubviews(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addPhoto"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didTapAddPhoto))
  }

    override func bind() {
        super.bind()

        viewModel.output
            .moveDetailPageObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (vc) in
                guard let self = self else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: bag)


        viewModel.output
            .apiState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .request:
                    self.view.startWaiting()
                case .complete:
                    self.view.stopWaiting()
                    self.collectionView.reloadData()
                case .error(let error):
                    print()
                }
            }).disposed(by: bag)

        viewModel.input.request.accept(())
    }

  @objc private func didTapAddPhoto() {
    view.startWaiting()
    let imagePickerController = UIImagePickerController().then {
      $0.delegate = self
      $0.modalTransitionStyle = .crossDissolve
    }
    present(imagePickerController, animated: true) {
      self.view.stopWaiting()
    }
  }
}

extension ZzalCollectionViewController: UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.model?.imageUrls?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zzalCellID, for: indexPath) as! ZzalCell

    cell.imageView.kf.setImage(with: URL(string: viewModel.model!.imageUrls![indexPath.row]))

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return ZzalCell.size()
  }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.selectedImg.accept(indexPath.item)
    }
}

extension ZzalCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let image = (info[.originalImage] as? UIImage)
    viewModel.uploadImage(image)
    dismiss(animated: true)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
