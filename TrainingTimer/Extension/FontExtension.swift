//
//  FontExtension.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/09.
//

import SwiftUI
import UIKit

extension Font {

    enum BorderStyle: String {
        case Black = "NotoSansJP-Black"
        case Bold = "NotoSansJP-Bold"
        case ExtraBold = "NotoSansJP-ExtraBold"
        case ExtraLight = "NotoSansJP-ExtraLight"
        case Light = "NotoSansJP-Light"
        case Medium = "NotoSansJP-Medium"
        case Regular = "NotoSansJP-Regular"
        case SemiBold = "NotoSansJP-SemiBold"
        case Thin = "NotoSansJP-Thin"
        case VariableFont_wght = "NotoSansJP-VariableFont_wght"
    }

    static func notoSans(style: BorderStyle, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}

extension UIFont {

    enum BorderStyle: String {
        case Black = "NotoSansJP-Black"
        case Bold = "NotoSansJP-Bold"
        case ExtraBold = "NotoSansJP-ExtraBold"
        case ExtraLight = "NotoSansJP-ExtraLight"
        case Light = "NotoSansJP-Light"
        case Medium = "NotoSansJP-Medium"
        case Regular = "NotoSansJP-Regular"
        case SemiBold = "NotoSansJP-SemiBold"
        case Thin = "NotoSansJP-Thin"
        case VariableFont_wght = "NotoSansJP-VariableFont_wght"
    }

    static func notoSans(style: BorderStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
