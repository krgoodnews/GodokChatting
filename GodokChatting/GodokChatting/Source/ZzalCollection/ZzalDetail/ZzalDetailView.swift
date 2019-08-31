//
//  ZzalDetailView.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

class ZzalDetailView: BaseView {

    let imageView = UIImageView().then {
        $0.backgroundColor = .groupTableViewBackground
        $0.contentMode = .scaleAspectFit
    }

    override func setup() {
        super.setup()

        addSubviews(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setupUI() {
        super.setupUI()
    }
}
