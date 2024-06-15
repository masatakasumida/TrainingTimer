//
//  CustomButton.swift
//  TrainingTimer_ios
//
//  Created by 住田雅隆 on 2023/12/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: configuration.isPressed ? 0.05 : 0.1), value: configuration.isPressed)
    }
}


