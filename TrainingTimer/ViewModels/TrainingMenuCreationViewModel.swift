//
//  TrainingMenuCreationViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/14.
//

import SwiftUI

class TrainingMenuCreationViewModel: ObservableObject {

    @Binding var trainingMenus: [TrainingMenu]
    @State private var model = TrainingModel()

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
                return "準備時間"
            case .training:
                return "トレーニング時間"
            case .rest:
                return "休憩時間"
            case .repetitions:
                return "トレーニング回数"
            case .setCount:
                return "セット数"
            case .restBetweenSets:
                return "セット間の休憩時間"
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
    let restSeconds = Array(0...500)
    let repetitionsCounts = Array(1...30)
    let setCounts = Array(1...30)
    let restBetweenSetsSeconds = Array(1...500)

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
    }

    func unitForPickerSection(_ section: PickerSection) -> String {
        switch section {
        case .prepare, .training, .rest, .restBetweenSets:
            return "秒"
        case .setCount:
            return "セット"
        case .repetitions:
            return "回"
        }
    }

    func saveTrainingMenu() {
        let trainingMenu = TrainingMenu(name: textValue, trainingTime: selectedTrainingSecond, restDuration: selectedRestSecond, repetitions: selectedRepetitionsCount, sets: selectedSetCount, restBetweenSets: selectedRestBetweenSetCount, readyTime: selectedPrepareSecond, createdAt: Date(), index: trainingMenus.count, isSelected: false)
        model.appendTrainingMenu(trainingMenu)
        trainingMenus.append(trainingMenu)
    }
}

