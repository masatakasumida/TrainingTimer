//
//  ColorThemeSelectionView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/02/04.
//


import SwiftUI

struct ColorThemeSelectionView: View {

    @StateObject private var viewModel = ColorThemeSelectionViewModel()

    let colors: [(color: Color, hex: Int)] = [
        (.red, ColorTheme.red.rawValue),
        (.yellow, ColorTheme.yellow.rawValue),
        (.green, ColorTheme.green.rawValue),
        (.blue, ColorTheme.blue.rawValue),
        (.purple, ColorTheme.purple.rawValue),
        (.gray, ColorTheme.gray.rawValue)
    ]

    // 2列のグリッドレイアウトを作成
    var gridLayout: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: gridLayout, spacing: 0) {
                    ForEach(colors, id: \.hex) { colorInfo in
                        ColorSelectionView(color: colorInfo.color, isSelected: ColorModel.shared.themeColor.rawValue == colorInfo.hex) {

                            if let selectedTheme = ColorTheme(rawValue: colorInfo.hex) {
                                viewModel.updateThemeColor(to: selectedTheme)
                            }
                        }
                    }
                }
                .padding([.horizontal, .top], 16)
                .toolbarBackground(ColorModel.shared.themeColor.backgroundColor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .tint(.whiteColor)
            }
        }
    }
}
