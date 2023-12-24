//
//  Models.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Foundation
import SwiftData

enum TrainingState {
    case ready
    case running
    case pause
}

@Model
final class TrainingMenu {
    let id: UUID
    var name: String
    var restDuration: TimeInterval // 休憩時間（秒単位）
    var repetitions: Int // 繰り返し回数
    var sets: Int // セット数
    var restBetweenSets: TimeInterval // セット間の休憩時間（秒単位）
    var creationDate: Date // 作成日

    init(name: String, restDuration: TimeInterval, repetitions: Int, sets: Int, restBetweenSets: TimeInterval) {
        self.id = UUID()
        self.name = name
        self.restDuration = restDuration
        self.repetitions = repetitions
        self.sets = sets
        self.restBetweenSets = restBetweenSets
        self.creationDate = Date()
    }
}

