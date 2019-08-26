//
//  ReativeViewModelable.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

protocol ReactiveViewModelType {
    associatedtype InputType
    associatedtype OutputType

    var input: InputType { get set }
    var output: OutputType { get }
}
