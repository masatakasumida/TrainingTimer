//
//  TrainingMenuCreationViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/14.
//

import SwiftUI

class TrainingMenuCreationViewModel: ObservableObject {
    let model = TrainingModel.shared
    var editingTrainingMenu: TrainingMenu?

    init(editingTrainingMenu: TrainingMenu? = nil) {
        self.editingTrainingMenu = editingTrainingMenu
        if let editingMenu = editingTrainingMenu {
            textValue = editingMenu.name
            selectedPrepareSecond = editingMenu.prepareTime
            selectedTrainingSecond = editingMenu.trainingTime
            selectedRestSecond = editingMenu.restTime
            selectedRepetitionsCount = editingMenu.repetitions
            selectedSetCount = editingMenu.sets
            selectedRestBetweenSetCount = editingMenu.restBetweenSets
        }
    }

    enum PickerSection: String, CaseIterable {
        case prepare
        case training
        case rest
        case repetitions
        case setCount
        case restBetweenSets

        var displayTitle: String {
            switch self {
            case .prepare:
                return String(localized: "準備時間")
            case .training:
                return String(localized: "トレーニング時間")
            case .rest:
                return String(localized: "休憩時間")
            case .repetitions:
                return String(localized: "トレーニング回数")
            case .setCount:
                return String(localized: "セット数")
            case .restBetweenSets:
                return String(localized: "セット間の休憩時間")
            }
        }
    }

    @Published var textValue: String = ""
    @Published var selectedPrepareSecond = 5
    @Published var selectedTrainingSecond = 10
    @Published var selectedRestSecond = 5
    @Published var selectedRepetitionsCount = 3
    @Published var selectedSetCount = 5
    @Published var selectedRestBetweenSetCount = 10

    let prepareSeconds = Array(1...15)
    let trainingSeconds = Array(1...500)
    let restSeconds = Array(1...500)
    let repetitionsCounts = Array(1...30)
    let setCounts = Array(1...30)
    let restBetweenSetsSeconds = Array(1...500)

    func unitForPickerSection(_ section: PickerSection) -> String {
        switch section {
        case .prepare, .training, .rest, .restBetweenSets:
            return String(localized: "秒")
        case .setCount:
            return String(localized: "セット")
        case .repetitions:
            return String(localized: "回")
        }
    }

    func saveTrainingMenu() {
        if let editingMenu = editingTrainingMenu {
            editingMenu.name = textValue
            editingMenu.prepareTime = selectedPrepareSecond
            editingMenu.trainingTime = selectedTrainingSecond
            editingMenu.restTime = selectedRestSecond
            editingMenu.repetitions = selectedRepetitionsCount
            editingMenu.sets = selectedSetCount
            editingMenu.restBetweenSets = selectedRestBetweenSetCount
            model.updateTrainingMenu(editingMenu)
        } else {
            let newMenu = TrainingMenu(name: textValue, trainingTime: selectedTrainingSecond, restDuration: selectedRestSecond, repetitions: selectedRepetitionsCount, sets: selectedSetCount, restBetweenSets: selectedRestBetweenSetCount, readyTime: selectedPrepareSecond, createdAt: Date(), index: model.trainingMenus.count, isSelected: false)
            model.appendTrainingMenu(newMenu)
        }
    }
}


