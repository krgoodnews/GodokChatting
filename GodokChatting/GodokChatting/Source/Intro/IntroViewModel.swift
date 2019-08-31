//
//  IntroViewModel.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import RxSwift
import RxCocoa

enum IntorAPIState {
    case requesting
    case complete
    case error(Error?)
}

class IntroViewModel: NSObject, ReactiveViewModelType {

    typealias InputType = Input
    typealias OutputType = Output

    struct Input {
        public let request = PublishRelay<Void>()
    }

    struct Output {
        public let introState = BehaviorRelay<IntorAPIState>(value: .requesting)
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()

    private let bag = DisposeBag()

    override init() {
        super.init()

        let defaultRequest = input.request
            .flatMap { IntroNetworker.request().asObservable() }

        let imageReuqest = input.request
            .flatMap { IntroNetworker.imageExRequest(image: UIImage(), name: "imageEx", imageType: .png) }

        Observable.zip(defaultRequest, imageReuqest)
            .subscribe(onNext: { [weak self] (dateJson, imageJson) in
                // dateJson -> default request의 response
                // imageJson -> image request의 response
                // 두 api의 response가 올때까지 대기함
                guard let self = self else { return }
                self.output.introState.accept(.complete)
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                self.output.introState.accept(.error(error))
            }).disposed(by: bag)
    }

}
