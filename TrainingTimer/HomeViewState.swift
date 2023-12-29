//
//  HomeViewState.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Combine
import SwiftUI

final class HomeViewState: ObservableObject {
    @Published private(set) var trainingProgressValue: CGFloat = 0.0
    @Published private(set) var restProgressValue: CGFloat = 0.0

    @Published private(set) var progressColor: Color = .trainingProgressBackgroundColor
    @Published private(set) var trainingState: TrainingState = .ready

    @Published private(set) var remainingTime: Int = 0

    @Published private(set) var trainingProgressOpacity = 0.8
    @Published private(set) var restProgressOpacity = 0.0

    private var sampleTrainingMenu = TrainingMenu(name: "SampleTraining", trainingTime: 5, restDuration: 3, repetitions: 3, sets: 3, restBetweenSets: 3, readyTime: 3)
    private var timer: Timer?
    private var currentSet: Int = 0
    private var currentRepetition: Int = 0
    private var trainingTime: Int = 0
    private var restTime: Int = 0
    private var remainingTrainingTime: Int = 0
    private var remainingRestTime: Int = 0
    private var isResting: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    init() {
        $trainingState
            .sink { [weak self] state in
                guard let self = self else { return }
                self.updateTimer(for: state)
            }
            .store(in: &cancellables)
        remainingTime = sampleTrainingMenu.trainingTime
        currentSet = sampleTrainingMenu.sets
        currentRepetition = sampleTrainingMenu.repetitions
        trainingTime = sampleTrainingMenu.trainingTime
        remainingTrainingTime = sampleTrainingMenu.trainingTime
        restTime = sampleTrainingMenu.restTime
        remainingRestTime = sampleTrainingMenu.restTime
        isResting = false
    }

    private func updateTimer(for state: TrainingState) {
        switch state {
        case .running:
            startTimer()
        case .pause:
            pauseTimer()
        case .ready:
            stopTimer()
        }
    }

    func changeTrainingState(to newState: TrainingState) {
        trainingState = newState
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTimerProgress()
        }
    }

    private func updateTimerProgress() {
        if isResting {
            // 休憩中
            remainingRestTime -= 1
            remainingTime = remainingRestTime
            if remainingRestTime <= 0 {
                beginNextSetOrRepetition()
            }
            updateProgress(remainingRestTime, sampleTrainingMenu.restTime, isResting: true)
        } else {
            // トレーニング中
            remainingTrainingTime -= 1
            remainingTime = remainingTrainingTime
            if remainingTrainingTime <= 0 {
                beginRestPeriod()
            }
            updateProgress(remainingTrainingTime, trainingTime, isResting: false)
        }
    }

    private func beginRestPeriod() {
        isResting = true
        remainingTime = remainingRestTime
        trainingProgressOpacity = 0.0
        restProgressOpacity = 0.8
        trainingProgressValue = 0.0
        progressColor = .restProgressBackgroundColor
    }

    private func beginNextSetOrRepetition() {
        if currentRepetition < sampleTrainingMenu.repetitions {
            currentRepetition += 1
        } else if currentSet < sampleTrainingMenu.sets {
            currentSet += 1
            currentRepetition = 1
        } else {
            changeTrainingState(to: .ready)
            return
        }
        isResting = false
        trainingProgressOpacity = 0.8
        restProgressOpacity = 0.0
        restProgressValue = 0.0
        progressColor = .trainingProgressBackgroundColor
        remainingRestTime = restTime
    }

    private func updateProgress(_ remainingTime: Int, _ originalTime: Int, isResting: Bool) {
        if isResting {
            restProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
        } else {
            trainingProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
        }
    }

    private var totalTrainingDuration: Int {
        return (sampleTrainingMenu.trainingTime + sampleTrainingMenu.restTime) * sampleTrainingMenu.repetitions * sampleTrainingMenu.sets
    }

    private func pauseTimer() {
        timer?.invalidate()
    }

    private func stopTimer() {
        timer?.invalidate()
        resetStatus()
    }

    private func resetStatus() {
        trainingProgressValue = 0.0
        restProgressValue = 0.0
        restProgressOpacity = 0.0
        trainingProgressOpacity = 0.7
        progressColor = .trainingProgressBackgroundColor
        remainingTime = sampleTrainingMenu.trainingTime
        remainingTrainingTime = sampleTrainingMenu.trainingTime
        remainingRestTime = sampleTrainingMenu.restTime
    }
}
