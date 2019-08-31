//
// Created by 국윤수 on 31/08/2019.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class CategoryCell: BaseCollectionCell {

  static func size() -> CGSize {
    let width = (UIScreen.main.bounds.width - 72) / 3
    let height = width + 32

    return CGSize(width: width, height: height)
  }

  let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = CategoryCell.size().width / 2
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.init(r: 151, g: 151, b: 151).cgColor
    $0.clipsToBounds = true
  }

  let titleLabel = UILabel().then {
    $0.font = UIFont.preferredFont(forTextStyle: .caption1)
    $0.text = "카테고리"
    $0.textAlignment = .center
  }

  override func setupView() {
    super.setupView()

    addSubviews(imageView, titleLabel)

    imageView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.height.equalTo(imageView.snp.width)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(6)
      $0.left.right.equalToSuperview()
    }
  }

    public func bind(type: CategoryListViewModel.ItemTypes) {
        titleLabel.text = type.title
        imageView.image = type.image
    }
}
