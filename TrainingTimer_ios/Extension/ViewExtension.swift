//
//  ViewExtension.swift
//  TrainingTimer_ios
//
//  Created by 住田雅隆 on 2023/12/31.
//

import SwiftUI

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        ModifiedContent(content: self, modifier: Hidden(hidden: isHidden))
    }
}

struct Hidden: ViewModifier {

    let hidden: Bool

    func body(content: Content) -> some View {
        if !hidden {
            content
        }
    }
}
