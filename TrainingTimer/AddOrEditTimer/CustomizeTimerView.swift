//
//  EditTimerView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct CustomizeTimerView: View {
    @State private var textValue: String = ""
    @State private var viewModel = TrainingViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.trainingMenus.indices, id: \.self) { index in
                        AddOrEditCustomCell(trainingMenu: viewModel.trainingMenus[index], onEdit: {
                            // 編集ボタンのタップ時の処理
                            print("\(viewModel.trainingMenus[index].name) の編集ボタンがタップされました")
                        }, onDelete: {
                            // 削除ボタンのタップ時の処理
                            print("\(viewModel.trainingMenus[index].name) の削除ボタンがタップされました")
                        }, onTap: {
                            print("\(viewModel.trainingMenus[index].name) のセルがタップされました")
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
}

#Preview {
    CustomizeTimerView()
}
