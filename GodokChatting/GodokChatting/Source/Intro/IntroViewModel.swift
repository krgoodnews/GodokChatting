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
        public let btnTapped = PublishRelay<Void>()
    }

    struct Output {
        public let changed: Observable<UIColor>
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = {
        let btnObservable = input.btnTapped
            .map { _ -> UIColor in
                return .red
        }
        return Output(changed: btnObservable)
    }()

}
