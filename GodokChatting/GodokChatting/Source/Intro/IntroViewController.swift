//
//  IntroViewController.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {

    static func instance() -> IntroViewController {
        return IntroViewController(nibName: nil, bundle: nil)
    }

    private let viewModel = IntroViewModel()

    lazy var introView: IntroView = {
        let introView = IntroView(frame: view.bounds)
        return introView
    }()

    override func setup() {
        super.setup()
        view = introView
    }

    override func bind() {
        super.bind()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
