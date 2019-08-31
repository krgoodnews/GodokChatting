//
//  ZzalCollectionViewController.swift
//  GodokChatting
//
//  Created by 국윤수 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

private let zzalCellID = "zzalCellID"

final class ZzalCollectionViewController: BaseViewController {

  let viewModel = ZzalCollectionViewModel()

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .gray
    $0.delegate = self
    $0.dataSource = self
    $0.register(ZzalCell.self, forCellWithReuseIdentifier: zzalCellID)
    let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.minimumInteritemSpacing = 0
    layout?.minimumLineSpacing = 1
  }

  override func setup() {
    super.setup()
    view.addSubviews(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addPhoto"), style: .plain, target: self, action: #selector(didTapAddPhoto))
  }

  @objc private func didTapAddPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
  }
}

extension ZzalCollectionViewController: UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zzalCellID, for: indexPath) as! ZzalCell
    cell.backgroundColor = .yellow
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return ZzalCell.size()
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
