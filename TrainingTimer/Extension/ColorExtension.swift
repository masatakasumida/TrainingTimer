//
//  ColorExtension.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/22.
//

import SwiftUI

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
}
