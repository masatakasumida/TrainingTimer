//
//  ColorModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/02/06.
//

import SwiftUI
import UIKit

@Observable
class ColorModel {
    static let shared = ColorModel()
    // UserDefaultsに保存されるrawValue
    @ObservationIgnored
    @AppStorage("themeColor") private var themeColorRaw: Int = ColorTheme.blue.rawValue
    // アプリで使用するためのColorTheme
    var themeColor: ColorTheme = .blue

    init() {
        themeColor = ColorTheme(rawValue: themeColorRaw) ?? .blue
    }

    func updateThemeColor(to theme: ColorTheme) {
        self.themeColor = theme
        self.themeColorRaw = theme.rawValue
    }
}

enum ColorTheme: Int, CaseIterable {
    case red = 0xFF0000
    case yellow = 0xFFFF00
    case green = 0x00FF00
    case blue = 0x0000FF
    case purple = 0x800080
    case gray = 0x808080

    var color: Color {
        switch self {
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        case .gray:
            return .gray
        }
    }

    var toolBarColor: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .yellow:
            return UIColor.yellow
        case .green:
            return UIColor.green
        case .blue:
            return UIColor.blue
        case .purple:
            return UIColor.purple
        case .gray:
            return UIColor.gray
        }
    }

    var textColor: Color {
        switch self {
        case .red: return .white
        case .yellow: return .textColor
        case .green: return .textColor
        case .blue: return .textColor
        case .purple: return .textColor
        case .gray: return .textColor
        }
    }

    var backgroundColor: Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .gray: return .gray
        }
    }
}
