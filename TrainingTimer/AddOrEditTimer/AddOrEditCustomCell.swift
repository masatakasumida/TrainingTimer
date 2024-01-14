//
//  AddOrEditCustomCell.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/05.
//

import SwiftUI

struct AddOrEditCustomCell: View {
    var trainingMenu: TrainingMenu
    var onEdit: () -> Void = {}
    var onDelete: () -> Void = {}
    var onTap: () -> Void = {}

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(trainingMenu.name)
                    .font(.notoSans(style: .semiBold, size: 17))
                Text("\(trainingMenu.trainingTime)秒 × \(trainingMenu.repetitions)回 × \(trainingMenu.sets)セット")
                    .font(.notoSans(style: .regular, size: 15))
            }
            Spacer()
            HStack(spacing: 8) {
                Text("削除")
                    .foregroundColor(.red)
                    .font(.notoSans(style: .bold, size: 14))
                    .frame(width: 56, height: 32)
                    .background(.white)
                    .cornerRadius(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(.red, lineWidth: 2)
                    )
                    .onTapGesture {
                        onEdit()
                    }
                Text("編集")
                    .foregroundColor(.blue)
                    .font(.notoSans(style: .bold, size: 14))
                    .frame(width: 56, height: 32)
                    .background(.white)
                    .cornerRadius(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(.blue, lineWidth: 2)
                    )
                    .onTapGesture {
                        onDelete()
                    }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(4)
        .shadow(radius: 2)
        .onTapGesture {
            onTap()
        }
    }
}

//#Preview {
//    CustomizeTimerView()
//}
