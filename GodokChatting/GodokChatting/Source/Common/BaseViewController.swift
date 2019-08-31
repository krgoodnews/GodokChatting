//
//  BaseViewController.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    // setup UI
    public func setup() {
      self.navigationController?.navigationBar.isTranslucent = false
      self.navigationController?.view.backgroundColor = .white
      self.navigationController?.navigationBar.tintColor = .darkGray
      self.navigationController?.navigationBar.shadowImage = UIImage()
  }

    // setup bind
    public func bind() { }
}
