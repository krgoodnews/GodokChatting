//
//  IntroViewController.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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

        // btn bind 처리
        introView.rx.btnTapped
            .map { _ in return }
            .bind(to: viewModel.input.btnTapped )
            .disposed(by: bag)

        // output 처리
        viewModel.output.changed
            .asObservable()
            .distinctUntilChanged() // 값이 변경 될 때만 호출
            .subscribe(onNext: { [weak self] (chagedColor) in // 구독
                guard let self = self else { return }
                self.introView.backgroundColor = chagedColor
            }).disposed(by: bag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
