//
//  MyMessageCell.swift
//  GodokChatting
//
//  Created by 국윤수 on 30/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

class MyMessageCell: BaseTableViewCell {
  let photoImgView = UIImageView().then {
    $0.layer.cornerRadius = 16
    $0.backgroundColor = .cyan
  }

  let uploadTimeLabel = UILabel().then {
    $0.font = UIFont.preferredFont(forTextStyle: .caption1)
    $0.textColor = .lightGray
    $0.text = "99:99"
  }

  override func setupView() {
    super.setupView()

    addSubviews(photoImgView, uploadTimeLabel)

    photoImgView.snp.makeConstraints {
      $0.top.right.bottom.equalTo(readableContentGuide)
      $0.height.equalTo(150)
    }

    uploadTimeLabel.snp.makeConstraints {
      $0.left.equalTo(readableContentGuide).offset(64)
      $0.right.equalTo(photoImgView.snp.left).offset(-4)
      $0.bottom.equalTo(photoImgView)
    }
  }
}
