//
// Created by 국윤수 on 31/08/2019.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

private let categoryCellID = "categoryCellID"

final class CategoryListViewController: BaseViewController {

  let viewModel = CategoryListViewModel()
    private let bag = DisposeBag()

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .white
    $0.delegate = self
    $0.dataSource = self
    $0.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellID)
    $0.register(CategroyListEmotional.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategroyListEmotional.reigsterID)
    $0.register(CategoryListPerson.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryListPerson.reigsterID)
    let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.sectionInset = UIEdgeInsets(top: 16, left: 22, bottom: 32, right: 22)
  }

  override func setup() {
    super.setup()

    navigationItem.titleView = UIImageView(image: UIImage(named: "titleImage")).then {
      $0.contentMode = .scaleAspectFill
    }
    view.addSubviews(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

    override func bind() {
        super.bind()

        viewModel.output.moveChatRoom
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (vc) in
                guard let self = self else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: bag)
    }
}

extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = CategoryListViewModel.SectionType.init(rawValue: section) else {
        return 0
    }
    return section.itmes.count
  }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch viewModel.header(indexPath.section) {
        case .emotional:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategroyListEmotional.reigsterID, for: indexPath) as? CategroyListEmotional else {
                return UICollectionReusableView()
            }
            return header
        case .person:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryListPerson.reigsterID, for: indexPath) as? CategoryListPerson else {
                return UICollectionReusableView()
            }
            return header
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let section = CategoryListViewModel.SectionType.init(rawValue: indexPath.section) else {
        return UICollectionViewCell()
    }

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCell

    cell.bind(type: section.itmes[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.input.didSelectedItem.accept((indexPath.section, indexPath.row))
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CategoryCell.size()
  }
}
