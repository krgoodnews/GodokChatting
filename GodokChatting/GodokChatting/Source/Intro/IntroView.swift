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
import RxSwift
import RxCocoa

extension Reactive where Base: IntroView {
    var btnTapped: Observable<Void> {
        return base.colorChanged.rx.tap.asObservable()
    }
}

class IntroView: BaseView {

    public let introTitle: UILabel = UILabel(frame: .zero).then {
        $0.text = "Intro"
        $0.textColor = .black
    }

    public lazy var colorChanged: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("배경 색 변경", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    override func setup() {
        super.setup()

        addSubviews(introTitle,
                    colorChanged)
    }

    override func setupUI() {
        super.setupUI()

        introTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        colorChanged.snp.makeConstraints {
            $0.top.equalTo(introTitle.snp.bottom).offset(20)
            $0.centerX.equalTo(introTitle.snp.centerX).offset(0)
        }
    }

    override func bind() {
        super.bind()
    }
}
