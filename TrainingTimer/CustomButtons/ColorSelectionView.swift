//
//  ColorSelectionButton.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/02/04.
//

import SwiftUI

struct ColorSelectionView: View {
    let color: Color
    var isSelected: Bool
    let action: () -> Void

    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .overlay(
                    Group {
                        if isSelected {
                            Image("CheckMark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        }
                    },
                    alignment: .center
                )
                .animation(.easeIn(duration: 0.1), value: isSelected)
                .onTapGesture {
                    self.action()
                }
        }
        .frame(height: (UIScreen.main.bounds.width / 2) - 8)
    }
}
