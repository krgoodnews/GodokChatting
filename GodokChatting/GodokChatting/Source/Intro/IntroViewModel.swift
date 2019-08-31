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

    }

    struct Output {

    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()

    private let bag = DisposeBag()

    override init() {
        super.init()
    }

}
