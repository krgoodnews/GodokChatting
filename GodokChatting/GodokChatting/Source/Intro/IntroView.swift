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

    let gradientLayer = CAGradientLayer()

    override func setup() {
        super.setup()

        gradientLayer.frame = self.bounds

        let color1 = UIColor.yellow.cgColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0).cgColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white: 0.0, alpha: 0.7).cgColor
        gradientLayer.colors = [color1, color2, color3, color4]

        gradientLayer.locations = [0.0, 0.25, 0.75, 1.0]

        self.layer.addSublayer(gradientLayer)
    }

    override func setupUI() {
        super.setupUI()
    }

    override func bind() {
        super.bind()
    }
}
