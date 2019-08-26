//
//  UIColorExtension.swift
//  DailyScrap
//
//  Created by Jung seoung Yeo on 29/07/2019.
//  Copyright © 2019 Linsaeng. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
