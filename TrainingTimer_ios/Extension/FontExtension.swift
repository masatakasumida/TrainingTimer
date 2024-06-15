//
//  FontExtension.swift
//  TrainingTimer_ios
//
//  Created by 住田雅隆 on 2023/12/09.
//

import SwiftUI
import UIKit

extension Font {

    enum BorderStyle: String {
        case black = "NotoSansJP-Black"
        case bold = "NotoSansJP-Bold"
        case extraBold = "NotoSansJP-ExtraBold"
        case extraLight = "NotoSansJP-ExtraLight"
        case light = "NotoSansJP-Light"
        case medium = "NotoSansJP-Medium"
        case regular = "NotoSansJP-Regular"
        case semiBold = "NotoSansJP-SemiBold"
        case thin = "NotoSansJP-Thin"
        case variableFont_wght = "NotoSansJP-VariableFont_wght"
    }

    static func notoSans(style: BorderStyle, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}

extension UIFont {

    enum BorderStyle: String {
        case black = "NotoSansJP-Black"
        case bold = "NotoSansJP-Bold"
        case extraBold = "NotoSansJP-ExtraBold"
        case extraLight = "NotoSansJP-ExtraLight"
        case light = "NotoSansJP-Light"
        case medium = "NotoSansJP-Medium"
        case regular = "NotoSansJP-Regular"
        case semiBold = "NotoSansJP-SemiBold"
        case thin = "NotoSansJP-Thin"
        case variableFont_wght = "NotoSansJP-VariableFont_wght"
    }

    static func notoSans(style: BorderStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
