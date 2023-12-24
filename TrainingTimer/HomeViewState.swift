//
//  HomeViewState.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/24.
//

import Combine
import Foundation

final class HomeViewState: ObservableObject {
    @Published private(set) var progressValue: Float = 0.0
    @Published private(set) var trainingState: TrainingState = .ready
    private var timer: Timer?
    private var cancellables: Set<AnyCancellable> = []

    init() {
        $trainingState
            .sink { [weak self] state in
                guard let self = self else { return }
                self.updateTimer(for: state)
            }
            .store(in: &cancellables)
    }

    private func updateTimer(for state: TrainingState) {
        switch state {
        case .running:
            startTimer()
        case .pause:
            pauseTimer()
        case .ready:
            stopTimer()
            resetProgress()
        }
    }

    func changeTrainingState(to newState: TrainingState) {
        trainingState = newState
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.progressValue += 0.1
            if self.progressValue >= 1.0 {
                self.progressValue = 0.0
                self.changeTrainingState(to: .ready)
            }
        }
    }

    private func pauseTimer() {
        timer?.invalidate()
    }

    private func stopTimer() {
        timer?.invalidate()
    }

    private func resetProgress() {
        progressValue = 0.0
    }
}
