//
//  TrainingMenuCreationView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/07.
//

import SwiftUI

struct TrainingMenuCreationView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: TrainingMenuCreationViewModel

    init(editingTrainingMenu: TrainingMenu? = nil) {
        _viewModel = StateObject(wrappedValue: TrainingMenuCreationViewModel(editingTrainingMenu: editingTrainingMenu))
    }

    var body: some View {
        VStack {
            List {
                Section(header: Text("タイトル").font(.notoSans(style: .semiBold, size: 12))) {
                    TextField("トレーニング名", text: $viewModel.textValue)
                        .font(.notoSans(style: .regular, size: 16))
                }
                Section(header: Text("準備時間").font(.notoSans(style: .semiBold, size: 12))) {
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.prepare,
                                  value: $viewModel.selectedPrepareSecond,
                                  range: viewModel.prepareSeconds)
                }

                Section(header: Text("トレーニング").font(.notoSans(style: .semiBold, size: 12))) {
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.training,
                                  value: $viewModel.selectedTrainingSecond,
                                  range: viewModel.trainingSeconds)
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.rest,
                                  value: $viewModel.selectedRestSecond,
                                  range: viewModel.restSeconds)
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.repetitions,
                                  value: $viewModel.selectedRepetitionsCount,
                                  range: viewModel.repetitionsCounts)
                }
                Section(header: Text("セット").font(.notoSans(style: .semiBold, size: 12))) {
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.setCount,
                                  value: $viewModel.selectedSetCount,
                                  range: viewModel.setCounts)
                    pickerSection(title: TrainingMenuCreationViewModel.PickerSection.restBetweenSets,
                                  value: $viewModel.selectedRestBetweenSetCount,
                                  range: viewModel.restBetweenSetsSeconds)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(viewModel.editingTrainingMenu == nil ? "新規作成" : "編集")

            Button(action: {
                viewModel.saveTrainingMenu()
                dismiss()
            }) {
                Text(viewModel.editingTrainingMenu == nil ? "保存" : "更新")
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
    private func pickerSection(title: TrainingMenuCreationViewModel.PickerSection,
                               value: Binding<Int>,
                               range: [Int]) -> some View {

        Picker(title.displayTitle, selection: value) {
            ForEach(range, id: \.self) { count in
                let displayText = "\(count) \(viewModel.unitForPickerSection(title))"
                Text(displayText).tag(count)
                    .font(.notoSans(style: .regular, size: 16))
            }
        }
        // 本当はmenuにしたいが、rangeの設定が大きくなると、画面遷移時にかなりもたつく
        .pickerStyle(.navigationLink)
        .font(.notoSans(style: .regular, size: 16))
        .tint(.textColor)
    }
}

#Preview {
    TrainingMenuCreationView()
}
