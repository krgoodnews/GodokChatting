//
//  UIFontExtension.swift
//  GodokChatting
//
//  Created by 여정승 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

extension UIFont {

    enum customFontType: String, CustomStringConvertible {
        case bold = "12LotteMartHappyBold"
        case medium = "12LotteMartHappyMedium"
        case light = "12LotteMartHLight"

        var description: String {
            return self.rawValue
        }

        fileprivate var defualtType: UIFont.Weight {
            switch self {
            case .bold: return .bold
            case .medium: return .medium
            case .light: return .light
            }
        }
    }

    static func customFont(ofSize: CGFloat, weight: customFontType) -> UIFont {
        guard let customFont = UIFont(name: "\(weight)", size: ofSize) else {
            return .systemFont(ofSize: ofSize, weight: weight.defualtType)
        }
        return customFont
    }
}
