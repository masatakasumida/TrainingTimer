//
//  HomeViewModel.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published private(set) var firstProgressValue: CGFloat = 0.0
    @Published private(set) var secondProgressValue: CGFloat = 0.0

    @Published private(set) var progressColor: Color = .trainingProgressBackgroundColor
    @Published private(set) var trainingPhase: TrainingPhase = .ready

    @Published private(set) var remainingTime: Int = 0

    @Published private(set) var remainingSets: Int = 0
    @Published private(set) var remainingRepetitions: Int = 0
    @Published private(set) var remainingRestBetweenSets: Int = 0
    @Published private(set) var readyTime: Int = 0

    @Published private(set) var firstProgressIsHidden = false
    @Published private(set) var secondProgressIsHidden = true
    @Published private(set) var navigationTitle = ""
    @Published private(set) var currentTitle: Text = Text(" ")
    @AppStorage("firstInstall") var initialInstall = false
    @State private var model = TrainingModel()
    @Binding var trainingMenus: [TrainingMenu]

    enum TrainingActivityStage {
        case preparing
        case training
        case resting
        case restBetweenSets

        var title: Text {
            switch self {
            case .preparing:
                return Text("準備")
            case .training:
                return Text("トレーニング")
            case .resting:
                return Text("休憩")
            case .restBetweenSets:
                return Text("セット間休憩")
            }
        }
    }

    private var currentActivityPhase: TrainingActivityStage = .preparing
    private var timer: Timer?
    private var sets: Int = 0
    private var repetitions: Int = 0
    private var prepareTime: Int = 0
    private var trainingTime: Int = 0
    private var restTime: Int = 0
    private var restBetweenSets: Int = 0
    private var remainingPrepareTime: Int = 0
    private var remainingTrainingTime: Int = 0
    private var remainingRestTime: Int = 0
    private var cancellables: Set<AnyCancellable> = []

    init(trainingMenus: Binding<[TrainingMenu]>) {
        self._trainingMenus = trainingMenus
        $trainingPhase
            .sink { [weak self] state in
                guard let self = self else { return }
                self.updateTimer(for: state)
            }
            .store(in: &cancellables)

        // アプリ初回インストール時、サンプルトレーニングメニューを使用
        if !initialInstall {
            let initialTrainingMenu = TrainingMenu(name: "トレーニング", trainingTime: 20, restDuration: 2, repetitions: 2, sets: 2, restBetweenSets: 3, readyTime: 3, createdAt: Date(), index: 0, isSelected: true)
            model.appendTrainingMenu(initialTrainingMenu)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                trainingMenus.wrappedValue.append(initialTrainingMenu)
                self.remainingTime = initialTrainingMenu.trainingTime
                self.sets = initialTrainingMenu.sets
                self.repetitions = initialTrainingMenu.repetitions
                self.prepareTime = initialTrainingMenu.prepareTime
                self.trainingTime = initialTrainingMenu.trainingTime
                self.restTime = initialTrainingMenu.restTime
                self.restBetweenSets = initialTrainingMenu.restBetweenSets
                self.remainingSets = initialTrainingMenu.sets
                self.remainingRepetitions = initialTrainingMenu.repetitions
                self.remainingPrepareTime = initialTrainingMenu.prepareTime
                self.remainingTrainingTime = initialTrainingMenu.trainingTime
                self.remainingRestTime = initialTrainingMenu.restTime
                self.remainingRestBetweenSets = initialTrainingMenu.restBetweenSets
                self.navigationTitle = initialTrainingMenu.name
            }
            initialInstall = true
        } else {
            if let selectedMenu = trainingMenus.wrappedValue.first(where: { $0.isSelected }) {
                remainingTime = selectedMenu.trainingTime
                sets = selectedMenu.sets
                repetitions = selectedMenu.repetitions
                prepareTime = selectedMenu.prepareTime
                trainingTime = selectedMenu.trainingTime
                restTime = selectedMenu.restTime
                restBetweenSets = selectedMenu.restBetweenSets

                remainingSets = selectedMenu.sets
                remainingRepetitions = selectedMenu.repetitions
                remainingPrepareTime = selectedMenu.prepareTime
                remainingTrainingTime = selectedMenu.trainingTime
                remainingRestTime = selectedMenu.restTime

                remainingRestBetweenSets = selectedMenu.restBetweenSets
                navigationTitle = selectedMenu.name
            }
        }
    }

    private func updateTimer(for state: TrainingPhase) {
        switch state {
        case .running:
            startTimer()
        case .pause:
            pauseTimer()
        case .ready:
            stopTimer()
        case .resume:
            resumeTimer()
        }
    }

    func changeTrainingState(to newState: TrainingPhase) {
        trainingPhase = newState
    }

    private func startTimer() {
        currentActivityPhase = .preparing
        currentTitle = currentActivityPhase.title
        remainingTime = remainingPrepareTime
        progressColor = .prepareProgressBackgroundColor
        setupTimer()
    }

    private func updateTimerProgress() {
        switch currentActivityPhase {
        case .preparing:
            remainingPrepareTime -= 1
            remainingTime = remainingPrepareTime
            if remainingPrepareTime <= 0 {
                beginTrainingPeriod()
            }
            updateProgress(remainingPrepareTime, prepareTime)

        case .training:
            remainingTrainingTime -= 1
            remainingTime = remainingTrainingTime
            if remainingTrainingTime <= 0 {
                beginRestPeriod()
            }
            if remainingTrainingTime <= 3 && remainingTrainingTime > 0 {
                // TODO: 残り3秒の警告音を鳴らす
            }
            updateProgress(remainingTrainingTime, trainingTime)
        case .resting:
            remainingRestTime -= 1
            remainingTime = remainingRestTime
            if remainingRestTime <= 0 {
                beginNextSetOrRepetition()
            }
            updateProgress(remainingRestTime, restTime)
        case .restBetweenSets:
            remainingRestBetweenSets -= 1
            remainingTime = remainingRestBetweenSets
            if remainingRestBetweenSets <= 0 {
                beginTrainingPeriod()
            }
            updateProgress(remainingRestBetweenSets, restBetweenSets)
        }
    }

    private func beginTrainingPeriod() {
        remainingTime = remainingTrainingTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.currentActivityPhase = .training
            self.remainingRestTime = restTime
            self.progressColor = .trainingProgressBackgroundColor
            self.resetUIForNewPhase()
        }
    }

    private func beginRestPeriod() {
        if remainingSets == 1 && remainingRepetitions == 1 {
            remainingTime = trainingTime
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                trainingPhase = .ready
            }
            return
        }
        remainingTime = remainingRestTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.currentActivityPhase = .resting
            self.remainingTrainingTime = trainingTime
            self.progressColor = .restProgressBackgroundColor
            self.resetUIForNewPhase()
        }
    }

    private func beginNextSetOrRepetition() {
        if remainingRepetitions > 1 {
            self.currentActivityPhase = .training
        } else if remainingSets > 1 {
            currentActivityPhase = .restBetweenSets
        }
        remainingTime = remainingTrainingTime

        if currentActivityPhase == .training {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.remainingRepetitions -= 1
                self.remainingRestTime = restTime
                self.progressColor = .trainingProgressBackgroundColor
                self.resetUIForNewPhase()
            }
        } else if currentActivityPhase == .restBetweenSets {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                self.remainingSets -= 1
                self.remainingRepetitions = repetitions
                self.remainingRestTime = restTime
                self.progressColor = .restBetweenSetsProgressBackgroundColor
                self.resetUIForNewPhase()
            }
        }
    }

    private func resetUIForNewPhase() {
        currentTitle = currentActivityPhase.title
        firstProgressIsHidden = secondProgressIsHidden ? true : false
        secondProgressIsHidden = !firstProgressIsHidden
        if firstProgressValue != 0.0 {
            firstProgressValue = 0.0
        }
        if secondProgressValue != 0.0 {
            secondProgressValue = 0.0
        }
    }

    private func updateProgress(_ remainingTime: Int, _ originalTime: Int) {
        let newProgressValue = 1.0 - CGFloat(remainingTime) / CGFloat(originalTime)
        firstProgressIsHidden ? (secondProgressValue = newProgressValue) : (firstProgressValue = newProgressValue)
    }

    private func resumeTimer() {
        setupTimer()
    }

    private func pauseTimer() {
        timer?.invalidate()
    }

    private func stopTimer() {
        timer?.invalidate()
        resetStatus()
    }

    private func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTimerProgress()
        }
    }

    private func resetStatus() {
        firstProgressValue = 0.0
        secondProgressValue = 0.0
        firstProgressIsHidden = secondProgressIsHidden ? true : false
        secondProgressIsHidden = !firstProgressIsHidden
        progressColor = .trainingProgressBackgroundColor
        remainingPrepareTime = prepareTime
        remainingTime = trainingTime
        remainingTrainingTime = trainingTime
        remainingRestTime = restTime
        remainingSets = sets
        remainingRepetitions = repetitions
        remainingRestBetweenSets = restBetweenSets
        currentActivityPhase = .preparing
        currentTitle = Text(" ")
    }
}
