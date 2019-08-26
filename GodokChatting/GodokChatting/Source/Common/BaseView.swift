//
//  BaseView.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupUI()
        bind()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupUI()
        bind()
    }

    public func setup() {
        backgroundColor = .white
    }
    public func setupUI() { }
    public func bind() { }
}
