//
//  ZzalDetailViewModel.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation

class ZzalDetailViewModel: ReactiveViewModelType {


    typealias InputType = Input
    typealias OutputType = Output

    struct Input {
    }

    struct Output {
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()

  public let imageURL: String?

  init(_ imageURL: String?) {
    self.imageURL = imageURL
  }
}
