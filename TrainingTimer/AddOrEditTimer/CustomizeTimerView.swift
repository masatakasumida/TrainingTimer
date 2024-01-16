//
//  EditTimerView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct CustomizeTimerView: View {

    @Binding var trainingMenus: [TrainingMenu]
    @StateObject private var viewModel: CustomizeTimerViewModel

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
        self._viewModel = StateObject(wrappedValue: CustomizeTimerViewModel(trainingMenus: trainingMenus))
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(trainingMenus.indices, id: \.self) { index in
                        AddOrEditCustomCell(trainingMenu: trainingMenus[index], onEdit: {
                            // 編集ボタンのタップ時の処理
                            print("\(trainingMenus[index].name) の編集ボタンがタップされました")
                        }, onDelete: {
                            // 削除ボタンのタップ時の処理
                            print("\(trainingMenus[index].name) の削除ボタンがタップされました")
                            viewModel.deleteTrainingMenu(at: index)
                        }, onTap: {
                            print("\(trainingMenus[index].name) のセルがタップされました")
                        })
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.whiteColor)
                    }
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
                .background(Color.whiteColor)
                .navigationTitle("トレーニングメニュー")
                .navigationBarTitleDisplayMode(.inline)
                .alert("削除の確認", isPresented: $viewModel.isDeleteShowAlert) {
                    Button("削除", role: .destructive) {
                        viewModel.confirmDelete()
                    }
                } message: {
                    Text(viewModel.deleteIndex.map { index in
                        guard trainingMenus.indices.contains(index) else {
                            return "削除するアイテムが見つかりませんでした。"
                        }
                        return "\(trainingMenus[index].name) を削除してもよろしいですか？"
                    } ?? "削除するアイテムが選択されていません。")
                }

                NavigationLink(destination: TrainingMenuCreationView(trainingMenus: $trainingMenus)) {
                    Text("トレーニングを追加")
                        .font(.notoSans(style: .bold, size: 20))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.startButtonColor)
                        .foregroundColor(.whiteColor)
                        .cornerRadius(10)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 70)
                .buttonStyle(CustomButtonStyle())
            }
        }
        .tint(.whiteColor)
    }
}

//#Preview {
//    CustomizeTimerView(trainingMenus: <#Binding<[TrainingMenu]>#>)
//}
