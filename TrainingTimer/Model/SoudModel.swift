//
//  SoudModel.swift
//  FlashingTestApp
//
//  Created by 住田雅隆 on 2022/06/28.
//

import SwiftUI
import AVFoundation

class SoundModel: NSObject, AVAudioPlayerDelegate {
    var effectOne: AVAudioPlayer!
    var effectTwo: AVAudioPlayer!
    var effectThree: AVAudioPlayer!

    override init() {
        super.init()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            // AudioPlayersの初期化
            if let asset = NSDataAsset(name: "ClickOne") {
                effectOne = try AVAudioPlayer(data: asset.data)
            }
            if let asset = NSDataAsset(name: "ClickTwo") {
                effectTwo = try AVAudioPlayer(data: asset.data)
            }
            if let asset = NSDataAsset(name: "ClickThree") {
                effectThree = try AVAudioPlayer(data: asset.data)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func click() {
        effectOne.stop()
        effectOne.currentTime = 0
        effectOne.play()
    }

    func countDown() {
        effectTwo.stop()
        effectTwo.currentTime = 0
        effectTwo.play()
    }

    func countZeroSound() {
        effectThree.stop()
        effectThree.currentTime = 0
        effectThree.play()
    }
}
