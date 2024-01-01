//
//  HomeViewState.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Combine
import SwiftUI

final class HomeViewState: ObservableObject {
    @Published private(set) var firstProgressValue: CGFloat = 0.0
    @Published private(set) var secondProgressValue: CGFloat = 0.0

    @Published private(set) var progressColor: Color = .trainingProgressBackgroundColor
    @Published private(set) var trainingState: TrainingState = .ready

    @Published private(set) var remainingTime: Int = 0

    @Published private(set) var remainingSets: Int = 0
    @Published private(set) var remainingRepetitions: Int = 0
    @Published private(set) var remainingRestBetweenSets: Int = 0
    @Published private(set) var readyTime: Int = 0

    @Published private(set) var firstProgressIsHidden = false
    @Published private(set) var secondProgressIsHidden = true
    @Published private(set) var navigationTitle = ""
    @Published private(set) var currentTitle = " "

    enum TrainingStatus {
        case preparing
        case training
        case resting
        case restBetweenSets

        var title: String {
            switch self {
            case .preparing:
                return "準備"
            case .training:
                return "トレーニング"
            case .resting:
                return "休憩"
            case .restBetweenSets:
                return "セット間休憩"
            }
        }
    }

    private var currentStatus: TrainingStatus = .preparing
    private var sampleTrainingMenu = TrainingMenu(name: "SampleTraining", trainingTime: 5, restDuration: 3, repetitions: 3, sets: 3, restBetweenSets: 3, readyTime: 3)
    private var timer: Timer?
    private var currentSet: Int = 0
    private var currentRepetition: Int = 0
    private var prepareTime: Int = 0
    private var trainingTime: Int = 0
    private var restTime: Int = 0
    private var remainingPrepareTime: Int = 0
    private var remainingTrainingTime: Int = 0
    private var remainingRestTime: Int = 0
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
        prepareTime = sampleTrainingMenu.prepareTime
        trainingTime = sampleTrainingMenu.trainingTime
        remainingPrepareTime = sampleTrainingMenu.prepareTime
        remainingTrainingTime = sampleTrainingMenu.trainingTime
        restTime = sampleTrainingMenu.restTime
        remainingRestTime = sampleTrainingMenu.restTime
        remainingSets = sampleTrainingMenu.sets
        remainingRepetitions = sampleTrainingMenu.repetitions
        remainingRestBetweenSets = sampleTrainingMenu.restBetweenSets
        navigationTitle = sampleTrainingMenu.name
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
        currentStatus = .preparing
        currentTitle = currentStatus.title
        remainingTime = remainingPrepareTime
        progressColor = .prepareProgressBackgroundColor
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTimerProgress()

        }
    }

    private func updateTimerProgress() {
        switch currentStatus {
        case .preparing:
            // 準備中
            remainingPrepareTime -= 1
            remainingTime = remainingPrepareTime
            if remainingPrepareTime <= 0 {
                beginTrainingPeriod()
            }
            updateProgress(remainingPrepareTime, prepareTime, .preparing)

        case .training:
            // トレーニング中
            remainingTrainingTime -= 1
            remainingTime = remainingTrainingTime
            if remainingTrainingTime <= 0 {
                beginRestPeriod()
            }
            updateProgress(remainingTrainingTime, trainingTime, .training)
        case .resting:
            remainingRestTime -= 1
            remainingTime = remainingRestTime
            if remainingRestTime <= 0 {
                beginNextSetOrRepetition()
            }
            updateProgress(remainingRestTime, sampleTrainingMenu.restTime, .resting)
        case .restBetweenSets:
            break
        }
    }

    private func beginTrainingPeriod() {
        remainingTime = remainingTrainingTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.currentStatus = .training
            self.currentTitle = currentStatus.title
            self.firstProgressIsHidden = secondProgressIsHidden ? true : false
            self.secondProgressIsHidden = !firstProgressIsHidden
            self.progressColor = .trainingProgressBackgroundColor
            self.remainingRestTime = restTime

            if self.firstProgressValue != 0.0 {
                self.firstProgressValue = 0.0
            }

            if self.secondProgressValue != 0.0 {
                self.secondProgressValue = 0.0
            }
        }
    }

    private func beginRestPeriod() {
        remainingTime = remainingRestTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.currentStatus = .resting
            self.currentTitle = currentStatus.title
            self.firstProgressIsHidden = secondProgressIsHidden ? true : false
            self.secondProgressIsHidden = !firstProgressIsHidden
            self.progressColor = .restProgressBackgroundColor
            self.remainingTrainingTime = trainingTime
            if self.firstProgressValue != 0.0 {
                self.firstProgressValue = 0.0
            }

            if self.secondProgressValue != 0.0 {
                self.secondProgressValue = 0.0
            }
        }
    }

    private func beginNextSetOrRepetition() {
        //        if currentRepetition < sampleTrainingMenu.repetitions {
        //            currentRepetition += 1
        //        } else if currentSet < sampleTrainingMenu.sets {
        //            currentSet += 1
        //            currentRepetition = 1
        //        } else {
        //            changeTrainingState(to: .ready)
        //            return
        //        }
        remainingTime = remainingTrainingTime

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.currentStatus = .training
            self.currentTitle = currentStatus.title
            self.firstProgressIsHidden = secondProgressIsHidden ? true : false
            self.secondProgressIsHidden = !firstProgressIsHidden
            self.progressColor = .trainingProgressBackgroundColor
            self.remainingRestTime = restTime
            if self.firstProgressValue != 0.0 {
                self.firstProgressValue = 0.0
            }
            if self.secondProgressValue != 0.0 {
                self.secondProgressValue = 0.0
            }

        }
    }

    private func updateProgress(_ remainingTime: Int, _ originalTime: Int, _ currentStatus: TrainingStatus) {
        switch currentStatus {
        case .preparing:
            firstProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
        case .training:
            let newProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
            firstProgressIsHidden ? (secondProgressValue = newProgressValue) : (firstProgressValue = newProgressValue)
        case .resting:
            let newProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
            firstProgressIsHidden ? (secondProgressValue = newProgressValue) : (firstProgressValue = newProgressValue)
        case .restBetweenSets:
            let newProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
            firstProgressIsHidden ? (secondProgressValue = newProgressValue) : (firstProgressValue = newProgressValue)
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
        firstProgressValue = 0.0
        secondProgressValue = 0.0
        firstProgressIsHidden = false
        secondProgressIsHidden = true
        progressColor = .trainingProgressBackgroundColor
        remainingPrepareTime = sampleTrainingMenu.prepareTime
        remainingTime = sampleTrainingMenu.trainingTime
        remainingTrainingTime = sampleTrainingMenu.trainingTime
        remainingRestTime = sampleTrainingMenu.restTime
        currentTitle = " "
    }
}
