//
//  Models.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Foundation
import SwiftData

enum TrainingPhase {
    case ready
    case running
    case pause
    case resume
}

//@Model
final class TrainingMenu {
    let id: UUID
    var name: String
    var trainingTime: Int // トレーニング時間
    var restTime: Int // 休憩時間（秒単位）
    var repetitions: Int // 繰り返し回数
    var sets: Int // セット数
    var restBetweenSets: Int // セット間の休憩時間（秒単位）
    var prepareTime: Int // トレーニング開始前の準備時間
    var creationAt: Date // 作成日
    var index: Int // セル管理用のindex
    var isSelected: Bool // 選択しているトレーニング


    init(name: String, trainingTime: Int,restDuration: Int, repetitions: Int, sets: Int, restBetweenSets: Int, readyTime: Int, createdAt: Date, index: Int, isSelected: Bool) {
        self.id = UUID()
        self.name = name
        self.trainingTime = trainingTime
        self.restTime = restDuration
        self.repetitions = repetitions
        self.sets = sets
        self.restBetweenSets = restBetweenSets
        self.prepareTime = readyTime
        self.creationAt = createdAt
        self.index = index
        self.isSelected = isSelected
    }
}

