//
// Created by 국윤수 on 31/08/2019.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class ZzalCell: BaseCollectionCell {

  static func size() -> CGSize {
    let cellWidth = (UIScreen.main.bounds.width - 2) / 3
    return CGSize(width: cellWidth, height: cellWidth)
  }

  // MARK: - View

  let imageView = UIImageView().then {
    $0.clipsToBounds = true
    $0.contentMode = .scaleAspectFill
  }

  override func setupView() {
    super.setupView()
    addSubviews(imageView)

    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
