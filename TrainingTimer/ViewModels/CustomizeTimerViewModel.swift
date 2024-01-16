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
    var deleteIndex: Int?

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
    }
    func deleteTrainingMenu(at index: Int) {
           deleteIndex = index
           isDeleteShowAlert = true
       }
    func confirmDelete() {
          guard let index = deleteIndex,
                let deleteMenuIndex = trainingMenus.firstIndex(where: { $0.index == index }) else {
              isDeleteShowAlert = false
              return
          }
        trainingMenus.remove(at: deleteMenuIndex)
        model.removeItem(index: deleteMenuIndex)
        isDeleteShowAlert = false
    }
}
