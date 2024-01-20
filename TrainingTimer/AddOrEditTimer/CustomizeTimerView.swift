//
//  EditTimerView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct CustomizeTimerView: View {

    @StateObject private var viewModel = CustomizeTimerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.model.trainingMenus, id: \.id) { trainingMenu in
                        AddOrEditCustomCell(trainingMenu: trainingMenu, onEdit: {
                            // 編集ボタンのタップ時の処理
                            print("\(trainingMenu.name) の編集ボタンがタップされました")
                        }, onDelete: {
                            // 削除ボタンのタップ時の処理
                            print("\(trainingMenu.name) の削除ボタンがタップされました")
                            viewModel.deleteTrainingMenu(at: trainingMenu.index)
                        }, onTap: {
                            print("\(trainingMenu.name) のセルがタップされました")
                            viewModel.setTrainingMenu(at: trainingMenu.index)
                        })
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.whiteColor)
                    }
                    .onMove(perform: move)
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
                    Text(viewModel.selectedIndex.map { index in
                        guard viewModel.model.trainingMenus.indices.contains(index) else {
                            return "削除するアイテムが見つかりませんでした。"
                        }
                        return "\(viewModel.model.trainingMenus[index].name) を削除してもよろしいですか？"
                    } ?? "削除するアイテムが選択されていません。")
                }
                .alert("トレーニングのセット", isPresented: $viewModel.isSetShowAlert) {
                    Button("セット") {
                        viewModel.confirmSet()
                    }
                    Button("キャンセル", role: .cancel) {}
                } message: {
                    Text(viewModel.selectedIndex.map { index in
                        guard viewModel.model.trainingMenus.indices.contains(index) else {
                            return "セットするメニューが見つかりませんでした。"
                        }
                        return "\(viewModel.model.trainingMenus[index].name) をセットしますか？"
                    } ?? "トレーニングメニューが選択されていません。")
                }

                NavigationLink(destination: TrainingMenuCreationView()) {
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
    private func move(from source: IndexSet, to destination: Int) {
        viewModel.moveTrainingMenu(from: source, to: destination)
    }
}

#Preview {
    CustomizeTimerView()
}
