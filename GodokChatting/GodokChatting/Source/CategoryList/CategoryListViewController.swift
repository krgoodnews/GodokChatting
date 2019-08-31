//
// Created by 국윤수 on 31/08/2019.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

private let categoryCellID = "categoryCellID"

final class CategoryListViewController: BaseViewController {

  let viewModel = CategoryListViewModel()

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .white
    $0.delegate = self
    $0.dataSource = self
    $0.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellID)
    let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.sectionInset = UIEdgeInsets(top: 16, left: 22, bottom: 32, right: 22)
  }

  override func setup() {
    super.setup()
    view.addSubviews(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCell
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let zzalCollectionVC = ZzalCollectionViewController()
    navigationController?.pushViewController(zzalCollectionVC, animated: true)
//    viewModel.didSelectCategory(at: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CategoryCell.size()
  }
}
