//
//  SoudModel.swift
//  FlashingTestApp
//
//  Created by 住田雅隆 on 2022/06/28.
//

import SwiftUI
import AVFoundation

class SoundModel: NSObject {
    
    let effectOne = try! AVAudioPlayer(data: NSDataAsset(name: "sh_pickup03")!.data)
    let effectTwo = try! AVAudioPlayer(data: NSDataAsset(name: "coin07")!.data)
    let effectThree = try! AVAudioPlayer(data: NSDataAsset(name: "coin02")!.data)
    let effectFour = try! AVAudioPlayer(data: NSDataAsset(name: "CH 808 Color A 6")!.data)

    let effectSix = try! AVAudioPlayer(data: NSDataAsset(name: "sh_pickup01")!.data)
    
     func playSound() {
        effectOne.stop()
        effectOne.currentTime = 0
        effectOne.play()
    }
    func trainingSound() {
       effectSix.stop()
       effectSix.currentTime = 0
       effectSix.play()
   }
    func emphasisSound() {
       effectTwo.stop()
       effectTwo.currentTime = 0
       effectTwo.play()
    }
    func countDownSound() {
        effectThree.stop()
        effectThree.currentTime = 0
        effectThree.play()
    }
    func intervalSound() {
        effectFour.stop()
        effectFour.currentTime = 0
        effectFour.play()
    }
    
    
    

}
