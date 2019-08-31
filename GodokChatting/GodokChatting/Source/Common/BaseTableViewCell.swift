//
//  BaseTableViewCell.swift
//  GodokChatting
//
//  Created by 국윤수 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView() {
    self.backgroundColor = .white
    selectionStyle = .none
  }
}

