//
//  EditTimerView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct CustomizeTimerView: View {
    @State private var textValue: String = ""
    let sampleMenu = TrainingMenu(name: "ランニング", trainingTime: 60, restDuration: 30, repetitions: 3, sets: 2, restBetweenSets: 60, readyTime: 10, createdAt: Date(), index: 0, isSelected: true)
    var body: some View {
        NavigationView {
            VStack {
            List {
                // 最初のカスタムセル
                AddOrEditCustomCell(trainingMenu: sampleMenu, onEdit: {
                    // 編集ボタンのタップ時の処理
                    print("最初のセルの編集ボタンがタップされました")
                }, onDelete: {
                    // 削除ボタンのタップ時の処理
                    print("最初のセルの削除ボタンがタップされました")
                }, onTap: {
                    print("最初のセルのがタップされました")
                })
                .listRowSeparator(.hidden)
                .listRowBackground(Color.whiteColor)
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
