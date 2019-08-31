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

    lazy var introImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "introImg"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var subTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = const.introAttributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var startBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(const.startBtnAttributedString, for: .normal)
        btn.layer.cornerRadius = 11
        btn.backgroundColor = .black
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowOpacity = 1.0
        btn.layer.masksToBounds = false
        btn.layer.shadowRadius = 4
        return btn
    }()

    private struct Const {
        let introAttributedString: NSAttributedString = .init("짤방 수집소 짤내투어에서\n테마별로 원하는 짤방을 찾아보세요",
                                                              font: .customFont(ofSize: 12,
                                                                                weight: .bold),
                                                              color: .black)
        let startBtnAttributedString: NSAttributedString = .init("Start!",
                                                                 font: .customFont(ofSize: 18,
                                                                                   weight: .bold),
                                                                 color: .white)
    }

    private let const = Const()

    override func setup() {
        super.setup()

        addSubviews(introImg,
                    subTitle,
                    startBtn)
    }

    override func setupUI() {
        super.setupUI()

        introImg.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-145.5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(108)
            $0.width.equalTo(172)
        }

        subTitle.snp.makeConstraints {
            $0.top.equalTo(introImg.snp.bottom).offset(18)
            $0.centerX.equalTo(introImg.snp.centerX)
        }

        startBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-57)
            $0.height.equalTo(48)
            $0.left.equalToSuperview().offset(45)
            $0.right.equalToSuperview().offset(-45)
        }
    }

    override func bind() {
        super.bind()
    }
}
