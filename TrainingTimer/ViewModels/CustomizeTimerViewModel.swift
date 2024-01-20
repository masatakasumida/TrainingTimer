//
//  CustomizeTimerViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/14.
//

import SwiftUI

class CustomizeTimerViewModel: ObservableObject {
    var model = TrainingModel.shared
    @Published var isDeleteShowAlert = false
    @Published var isSetShowAlert = false

    var selectedIndex: Int?

    func deleteTrainingMenu(at index: Int) {
        selectedIndex = index
        isDeleteShowAlert = true
    }
    func confirmDelete() {
        guard let index = selectedIndex,
              let deleteMenuIndex = model.trainingMenus.firstIndex(where: { $0.index == index }) else {
            isDeleteShowAlert = false
            return
        }
        model.removeItem(index: deleteMenuIndex)
        isDeleteShowAlert = false
    }

    func setTrainingMenu(at index: Int) {
        selectedIndex = index
        isSetShowAlert = true
    }

    func confirmSet() {
        guard let index = selectedIndex,
              let setMenuIndex = model.trainingMenus.firstIndex(where: { $0.index == index }) else {
            isSetShowAlert = false
            return
        }
        // 現在選択されているメニューを探し、isSelectedをfalseに設定
        if let currentlySelectedIndex = model.trainingMenus.firstIndex(where: { $0.isSelected }) {
            model.trainingMenus[currentlySelectedIndex].isSelected = false
            model.updateTrainingMenu(model.trainingMenus[currentlySelectedIndex])
        }
        model.trainingMenus[setMenuIndex].isSelected = true
        model.updateTrainingMenu(model.trainingMenus[setMenuIndex])
        isSetShowAlert = false
    }

    func moveTrainingMenu(from source: IndexSet, to destination: Int) {
        model.trainingMenus.move(fromOffsets: source, toOffset: destination)
        updateIndexes()
    }

    private func updateIndexes() {
        for (index, _) in model.trainingMenus.enumerated() {
            model.trainingMenus[index].index = index
            model.updateTrainingMenu(model.trainingMenus[index])
        }
    }
}
