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
                    .foregroundStyle(Color.textColor)
                Text("\(trainingMenu.trainingTime)秒 × \(trainingMenu.repetitions)回 × \(trainingMenu.sets)セット")
                    .font(.notoSans(style: .regular, size: 15))
                    .foregroundStyle(Color.textColor)
            }
            Spacer()
            HStack(spacing: 8) {
                Text("削除")
                    .foregroundColor(.deleteButtonTitleColor)
                    .font(.notoSans(style: .bold, size: 14))
                    .frame(width: 56, height: 32)
                    .background(.white)
                    .cornerRadius(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.deleteButtonTitleColor, lineWidth: 2)
                    )
                    .onTapGesture {
                        onDelete()
                    }
                Text("編集")
                    .foregroundColor(.editButtonTitleColor)
                    .font(.notoSans(style: .bold, size: 14))
                    .frame(width: 56, height: 32)
                    .background(.white)
                    .cornerRadius(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.editButtonTitleColor, lineWidth: 2)
                    )
                    .onTapGesture {
                        onEdit()
                    }
            }
        }
        .padding()
        .background(Color.whiteColor)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(trainingMenu.isSelected ? Color.controlPanelColor : Color.clear, lineWidth: 2)
        )
        .shadow(radius: 2)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    CustomizeTimerView()
}
