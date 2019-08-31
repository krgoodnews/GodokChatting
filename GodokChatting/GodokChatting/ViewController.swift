//
//  ViewController.swift
//  GodokChatting
//
//  Created by 국윤수 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func setup() {
        super.setup()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController = IntroViewController()
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
}

private extension ViewController {
    func moveIntro() -> IntroViewController {
        return IntroViewController.instance()
    }
}
