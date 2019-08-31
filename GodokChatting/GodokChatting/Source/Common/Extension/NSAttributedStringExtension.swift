//
//  NSAttributedString.swift
//  GodokChatting
//
//  Created by 여정승 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

extension NSAttributedString {
    convenience init(_ string: String, font: UIFont, color: UIColor) {
        self.init(string: string, attributes: [NSAttributedString.Key.font: font,
                                                NSAttributedString.Key.foregroundColor: color])
    }
}
