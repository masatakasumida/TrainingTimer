//
//  CustomizeTimerViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/14.
//

import SwiftUI

class CustomizeTimerViewModel: ObservableObject {
    @Binding var trainingMenus: [TrainingMenu]

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
    }
}
