//
//  Bindable.swift
//  GodokChatting
//
//  Created by 국윤수 on 27/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation

class Bindable<T> {

  var value: T? {
    didSet {
      observer?(value)
    }
  }

  var observer: ((T?) -> ())?

  func bind(observer: @escaping (T?) -> ()) {
    self.observer = observer
  }

}
