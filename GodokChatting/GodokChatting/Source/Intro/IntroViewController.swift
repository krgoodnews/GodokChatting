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

      introView.startBtn.rx
        .tap
        .map { _ in return }
        .bind(to: viewModel.input.didTapStart)
      .disposed(by: bag)

      viewModel.output.didTapObservarble
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] (navi) in
          guard let self = self else { return }
          self.showAnimation(navi: navi)

        }).disposed(by: bag)

  }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension IntroViewController {
  func showAnimation(navi: UINavigationController) {
    guard let window = UIApplication.shared.keyWindow else { return }
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
      window.rootViewController = navi
    }, completion: nil)

  }
}
