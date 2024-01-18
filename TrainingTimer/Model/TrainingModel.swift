//
//  TrainingMenuCreationViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/10.
//

import SwiftUI
import SwiftData

@Observable
class TrainingModel {
    @ObservationIgnored
    private let databaseManager: DatabaseManager

    var trainingMenus: [TrainingMenu] = []
    
    init(databaseManager: DatabaseManager = DatabaseManager.shared) {
        self.databaseManager = databaseManager
        trainingMenus = databaseManager.fetchTrainingMenu().sorted(by: { $0.index < $1.index })
    }

    func appendTrainingMenu(_ trainingMenu: TrainingMenu) {
        databaseManager.addTrainingMenu(trainingMenu: trainingMenu)
    }

    func removeItem(index: Int) {
        databaseManager.removeTrainingMenu(trainingMenus[index])
    }

    func updateTrainingMenu(_ trainingMenu: TrainingMenu) {
        databaseManager.updateTrainingMenu(trainingMenu)
    }
}
