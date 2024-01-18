//
//  CustomizeTimerViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/14.
//

import SwiftUI

class CustomizeTimerViewModel: ObservableObject {
    @Binding var trainingMenus: [TrainingMenu]
    @State private var model = TrainingModel()
    @Published var isDeleteShowAlert = false
    @Published var isSetShowAlert = false

    var selectedIndex: Int?

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
    }
    func deleteTrainingMenu(at index: Int) {
           selectedIndex = index
           isDeleteShowAlert = true
       }
    func confirmDelete() {
          guard let index = selectedIndex,
                let deleteMenuIndex = trainingMenus.firstIndex(where: { $0.index == index }) else {
              isDeleteShowAlert = false
              return
          }
        trainingMenus.remove(at: deleteMenuIndex)
        model.removeItem(index: deleteMenuIndex)
        isDeleteShowAlert = false
    }

    func setTrainingMenu(at index: Int) {
        selectedIndex = index
        isSetShowAlert = true
    }

    func confirmSet() {
        guard let index = selectedIndex,
              let setMenuIndex = trainingMenus.firstIndex(where: { $0.index == index }) else {
            isSetShowAlert = false
            return
        }
        // 現在選択されているメニューを探し、isSelectedをfalseに設定
          if let currentlySelectedIndex = trainingMenus.firstIndex(where: { $0.isSelected }) {
              trainingMenus[currentlySelectedIndex].isSelected = false
              model.updateTrainingMenu(trainingMenus[currentlySelectedIndex])
          }
        trainingMenus[setMenuIndex].isSelected = true
        model.updateTrainingMenu(trainingMenus[setMenuIndex])
        isSetShowAlert = false
    }
}
