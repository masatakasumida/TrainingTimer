//
//  TrainingMenuCreationView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/07.
//

import SwiftUI

struct TrainingMenuCreationView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var trainingMenus: [TrainingMenu]

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

    @State private var textValue: String = ""
    @State private var selectedPrepareSecond = 5
    @State private var selectedTrainingSecond = 10
    @State private var selectedRestSecond = 5
    @State private var selectedRepetitionsCount = 3
    @State private var selectedSetCount = 5
    @State private var selectedRestBetweenSetCount = 10

    let prepareSeconds = Array(1...15)
    let trainingSeconds = Array(1...500)
    let restSeconds = Array(0...500)
    let repetitionsCounts = Array(1...30)
    let setCounts = Array(1...30)
    let restBetweenSetsSeconds = Array(1...500)

    private func unitForPickerSection(_ section: PickerSection) -> String {
        switch section {
        case .prepare, .training, .rest, .restBetweenSets:
            return "秒"
        case .setCount:
            return "セット"
        case .repetitions:
            return "回"
        }
    }

    var body: some View {
        VStack {
            List {
                Section(header: Text("タイトル")) {
                    TextField("トレーニング名", text: $textValue)
                        .submitLabel(.done)
                }
                pickerSection(title: PickerSection.prepare,
                              value: $selectedPrepareSecond,
                              range: prepareSeconds)

                Section(header: Text("トレーニング")) {
                    pickerSection(title: PickerSection.training,
                                  value: $selectedTrainingSecond,
                                  range: trainingSeconds)
                    pickerSection(title: PickerSection.rest,
                                  value: $selectedRestSecond,
                                  range: restSeconds)
                    pickerSection(title: PickerSection.repetitions,
                                  value: $selectedRepetitionsCount,
                                  range: repetitionsCounts)
                }
                Section(header: Text("セット")) {
                    pickerSection(title: PickerSection.setCount,
                                  value: $selectedSetCount,
                                  range: setCounts)
                    pickerSection(title: PickerSection.restBetweenSets,
                                  value: $selectedRestBetweenSetCount,
                                  range: setCounts)
                }
            }

            .listStyle(.insetGrouped)
            .navigationTitle("新規作成")

            Button(action: {
                let trainingMenu = TrainingMenu(name: textValue, trainingTime: selectedTrainingSecond, restDuration: selectedRestSecond, repetitions: selectedRepetitionsCount, sets: selectedSetCount, restBetweenSets: selectedRestBetweenSetCount, readyTime: selectedPrepareSecond, createdAt: Date(), index: trainingMenus.count, isSelected: false)
                trainingMenus.append(trainingMenu)
                dismiss()
            }) {
                Text("保存")
                    .font(.notoSans(style: .bold, size:20))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.startButtonColor)
                    .foregroundColor(.whiteColor)
                    .cornerRadius(10)

            }
            .buttonStyle(CustomButtonStyle())
            .padding(.bottom, 70)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea(.keyboard, edges: .all)
    }

    @ViewBuilder
    private func pickerSection(title: PickerSection,
                               value: Binding<Int>,
                               range: [Int]) -> some View {

        Picker(title.displayTitle, selection: value) {
            ForEach(range, id: \.self) { count in
                let displayText = "\(count) \(unitForPickerSection(title))"

                Text(displayText).tag(count)
            }
        }
        .pickerStyle(.menu)
        .tint(.textColor)
    }
}

//#Preview {
//    @Binding var trainingMenus: [TrainingMenu]
//    TrainingMenuCreationView(trainingMenus: trainingMenus)
//}
