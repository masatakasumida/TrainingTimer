//
//  TrainingMenuCreationViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/10.
//

import SwiftUI
import SwiftData

@Observable
class TrainingMenuCreationViewModel {
    @ObservationIgnored
    private let databaseManager: DatabaseManager

    var trainingMenus: [TrainingMenu] = []

    init(databaseManager: DatabaseManager = DatabaseManager.shared) {
        self.databaseManager = databaseManager
        trainingMenus = databaseManager.fetchTrainingMenu()
    }

    func appendTrainingMenu(_ trainingMenu: TrainingMenu) {
        databaseManager.addTrainingMenu(trainingMenu: trainingMenu)
    }

    func removeItem(_ trainingMenu: TrainingMenu, index: Int) {
        databaseManager.removeTrainingMenu(trainingMenu)
    }
}
