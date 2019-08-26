//
//  IntroView.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit
import Then
import SnapKit

class IntroView: BaseView {

    public let introTitle: UILabel = UILabel(frame: .zero).then {
        $0.text = "Intro"
        $0.textColor = .black
    }

    override func setup() {
        super.setup()

        addSubviews(introTitle)
    }

    override func setupUI() {
        super.setupUI()

        introTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func bind() {
        super.bind()
    }
}
