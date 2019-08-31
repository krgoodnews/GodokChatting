//
//  ReceivedMessageCell.swift
//  GodokChatting
//
//  Created by 국윤수 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class ReceivedMessageCell: BaseTableViewCell {

  let userImgView = UIImageView().then {
    $0.layer.cornerRadius = 8
    $0.backgroundColor = .cyan
  }

  let nicknameLabel = UILabel().then {
    $0.font = UIFont.preferredFont(forTextStyle: .caption1)
    $0.textColor = .lightGray
    $0.text = "닉네임"
  }

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

    addSubviews(userImgView, nicknameLabel, photoImgView, uploadTimeLabel)

    userImgView.snp.makeConstraints {
      $0.top.left.equalTo(readableContentGuide)
      $0.size.equalTo(44)
    }

    nicknameLabel.snp.makeConstraints {
      $0.top.equalTo(userImgView)
      $0.left.equalTo(userImgView.snp.right).offset(4)
      $0.right.equalTo(readableContentGuide)
    }

    photoImgView.snp.makeConstraints {
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
      $0.left.equalTo(nicknameLabel)
      $0.bottom.equalTo(readableContentGuide)
      $0.height.equalTo(150)
    }

    uploadTimeLabel.snp.makeConstraints {
      $0.left.equalTo(photoImgView.snp.right).offset(4)
      $0.right.equalTo(readableContentGuide).offset(-64)
      $0.bottom.equalTo(photoImgView)
    }
  }
}
