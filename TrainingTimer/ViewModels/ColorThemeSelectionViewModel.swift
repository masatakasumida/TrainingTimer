//
//  ColorThemeSelectionView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/02/06.
//


import SwiftUI

class ColorThemeSelectionViewModel: ObservableObject {

    func updateThemeColor(to theme: ColorTheme) {
        ColorModel.shared.updateThemeColor(to: theme)
    }
}
