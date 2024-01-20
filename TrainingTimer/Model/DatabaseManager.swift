//
//  DatabaseManager.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/09.
//

import SwiftUI
import SwiftData

class DatabaseManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    @MainActor
    static let shared = DatabaseManager()
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: TrainingMenu.self)
        self.modelContext = modelContainer.mainContext
    }

    func addTrainingMenu(trainingMenu: TrainingMenu) {
        modelContext.insert(trainingMenu)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchTrainingMenu() -> [TrainingMenu] {
        do {
            return try modelContext.fetch(FetchDescriptor<TrainingMenu>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeTrainingMenu(_ trainingMenu: TrainingMenu) {
        modelContext.delete(trainingMenu)
    }

    func updateTrainingMenu(_ trainingMenu: TrainingMenu) {
        do {
            if modelContext.hasChanges {
                try modelContext.save()
            }
        } catch {
            fatalError("更新に失敗: \(error.localizedDescription)")
        }
    }
}
