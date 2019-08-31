//
//  IntroViewModel.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import RxSwift
import RxCocoa

class IntroViewModel: NSObject, ReactiveViewModelType {

    typealias InputType = Input
    typealias OutputType = Output

    struct Input {
      let didTapStart = PublishRelay<Void>()
    }

    struct Output {
      let didTapObservarble = PublishRelay<UINavigationController>()
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()

    private let bag = DisposeBag()

    override init() {
        super.init()

      input.didTapStart
        .subscribe(onNext: { [weak self] (_) in
          guard let self = self else { return }
          let rootVC = UINavigationController(rootViewController: CategoryListViewController())

          self.output.didTapObservarble.accept(rootVC)
        }).disposed(by: bag)
    }

}
