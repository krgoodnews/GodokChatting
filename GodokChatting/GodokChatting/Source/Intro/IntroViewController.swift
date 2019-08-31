//
//  IntroViewController.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SwiftlyIndicator

class IntroViewController: BaseViewController {

    static func instance() -> IntroViewController {
        return IntroViewController(nibName: nil, bundle: nil)
    }

    private let viewModel = IntroViewModel()
    private let bag = DisposeBag()

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

        viewModel.output.introState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .requesting:
                    self.view.startWaiting()
                case .complete:
                    self.view.stopWaiting()
                case .error(let error):
                    self.view.stopWaiting()

                    UIAlertController.alert(message: "\(error?.localizedDescription ?? "장애!")",
                        cancelString: "확인")
                    .show(self)
                }
            }).disposed(by: bag)

        // bind가 끝나고 request 요청
        viewModel.input.request.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
