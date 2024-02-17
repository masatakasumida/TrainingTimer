//
//  ColorExtension.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/22.
//

import SwiftUI
import UIKit

extension Color {
    static func hex(_ hex: Int, alpha: CGFloat = 1.0) -> Color {
        let r = Double((hex >> 16) & 0xff) / 255.0
        let g = Double((hex >> 8) & 0xff) / 255.0
        let b = Double(hex & 0xff) / 255.0
        return Color(.sRGB, red: r, green: g, blue: b, opacity: Double(alpha))
    }

    static func | (lightMode: Color, darkMode: Color) -> Color {
        return Color(UIColor { traitCollection -> UIColor in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor(lightMode)
            } else {
                return UIColor(darkMode)
            }
        })
    }

    static let textColor = hex(0x6D6D6D) | hex(0xFFFFFF)
    static let labelColor = hex(0x000000) | .whiteColor
    static let whiteColor = hex(0xFDFCFF)
    static let backgroundColor = hex(0xFDFCFF) | hex(0x2c3c56)
    static let tableViewBackgroundColor = hex(0xF2F2F7) | hex(0x2c3c56)
    static let toolBarColor = hex(0x4499E1) | hex(0x19283D)
    static let startButtonColor = hex(0x4499E1)
    static let prepareProgressBackgroundColor = hex(0xEDE5FF)
    static let trainingProgressBackgroundColor = hex(0x3394E0)
    static let restProgressBackgroundColor = hex(0xB5E0D0)
    static let progressColor = hex(0x808080) | hex(0xB3B3B3)
    static let controlPanelColor = hex(0x3394E0) | hex(0x03A2F2)
    static let controlPanelBackgroundColor = hex(0xEAF4FF)
    static let tabBarUnselectedColor = hex(0xB2D7FD)
    static let restBetweenSetsProgressBackgroundColor = hex(0xE4606D)
    static let deleteButtonTitleColor = hex(0xD42A2A)
    static let editButtonTitleColor = hex(0x0097FC)
    static let customCellBackgroundColor = hex(0xFFFFFF) | hex(0x19283D)
}

extension UIColor {
    static func hex(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((hex >> 16) & 0xff) / 255.0
        let g = CGFloat((hex >> 8) & 0xff) / 255.0
        let b = CGFloat(hex & 0xff) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { traitCollection -> UIColor in
            if traitCollection.userInterfaceStyle == .light {
                return lightMode
            } else {
                return darkMode
            }
        }
    }

    static let textColor = hex(0x6D6D6D)
    static let whiteColor = hex(0xFDFCFF)
    static let backgroundColor = hex(0xFDFCFF) | hex(0x2c3c56)
    static let toolBarColor = hex(0x4499E1) | hex(0x19283D)
    static let startButtonColor = hex(0x4499E1)
    static let progressColor = hex(0x3394E0)
    static let controlPanelColor = hex(0x3394E0)
    static let controlPanelBackgroundColor = hex(0xEAF4FF)
    static let tabBarUnselectedColor = hex(0xB2D7FD) | hex(0xFFFFFF)
    static let tabBarSelectedColor = hex(0xFFFFFF) | hex(0x03A2F2)
}
