//
//  UIViewExtension.swift
//  GodokChatting
//
//  Created by 여정승 on 26/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
