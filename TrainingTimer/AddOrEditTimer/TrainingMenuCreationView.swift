//
//  TrainingMenuCreationView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/07.
//

import SwiftUI

struct TrainingMenuCreationView: View {

    @State private var viewModel = TrainingViewModel()

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
    @State private var isPreparePickerVisible = false
    @State private var isTrainingPickerVisible = false
    @State private var isRestPickerVisible = false
    @State private var isRepetitionsPickerVisible = false
    @State private var isSetCountPickerVisible = false
    @State private var isRestBetweenSetPickerVisible = false

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
                }
                Section(header: Text("準備")) {
                    pickerSection(title: PickerSection.prepare,
                                  value: $selectedPrepareSecond,
                                  range: prepareSeconds,
                                  pickerVisible: $isPreparePickerVisible)
                }

                Section(header: Text("トレーニング")) {
                    pickerSection(title: PickerSection.training,
                                  value: $selectedTrainingSecond,
                                  range: trainingSeconds,
                                  pickerVisible: $isTrainingPickerVisible)
                    pickerSection(title: PickerSection.rest,
                                  value: $selectedRestSecond,
                                  range: restSeconds,
                                  pickerVisible: $isRestPickerVisible)
                    pickerSection(title: PickerSection.repetitions,
                                  value: $selectedRepetitionsCount,
                                  range: repetitionsCounts,
                                  pickerVisible: $isRepetitionsPickerVisible)
                }
                Section(header: Text("セット")) {
                    pickerSection(title: PickerSection.setCount,
                                  value: $selectedSetCount,
                                  range: setCounts,
                                  pickerVisible: $isSetCountPickerVisible)
                    pickerSection(title: PickerSection.restBetweenSets,
                                  value: $selectedRestBetweenSetCount,
                                  range: setCounts,
                                  pickerVisible: $isRestBetweenSetPickerVisible)
                }
            }

            .listStyle(.insetGrouped)
            .navigationTitle("新規作成")

            Button(action: {
                let trainingMenu = TrainingMenu(name: textValue, trainingTime: selectedTrainingSecond, restDuration: selectedRestSecond, repetitions: selectedRepetitionsCount, sets: selectedSetCount, restBetweenSets: selectedRestBetweenSetCount, readyTime: selectedPrepareSecond, createdAt: Date(), index: viewModel.trainingMenus.count, isSelected: false)
                viewModel.appendTrainingMenu(trainingMenu)

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
                               range: [Int],
                               pickerVisible: Binding<Bool>) -> some View {
        HStack {
            Text(title.displayTitle)
            Spacer()
            let displayText = "\(value.wrappedValue) \(unitForPickerSection(title))"
            Text(displayText)
                .foregroundColor(.gray)
        }
        // Viewのタップ領域を指定
        .contentShape(Rectangle())
        .onTapGesture {
            pickerVisible.wrappedValue.toggle()
        }

        if pickerVisible.wrappedValue {
            Picker(title.displayTitle, selection: value) {
                ForEach(range, id: \.self) { count in
                    let displayText = "\(count) \(unitForPickerSection(title))"
                    Text(displayText).tag(count)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 120)

            Text("決定")
                .listRowSeparator(.hidden)
                .font(.notoSans(style: .bold, size: 16))
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.controlPanelColor)
                .foregroundColor(.whiteColor)
                .cornerRadius(7)
                .onTapGesture {
                    pickerVisible.wrappedValue = false
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
        }
    }
}

#Preview {
    TrainingMenuCreationView()
}
