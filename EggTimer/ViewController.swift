//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft":5, "Medium": 7, "Hard": 12]
    var timeSpan: Int?
    var duration: Int?
    var player: AVAudioPlayer?
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.titleLabel?.text
        timeSpan = 0
        timerProgress.progress = 0
        duration = eggTimes[hardness!]!
        timerLabel.text = hardness
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

        
    }
    @objc func fireTimer(timer : Timer) {
        timeSpan = timeSpan! + 1
        if timeSpan! <= duration! {
            timerProgress.progress = Float(timeSpan!) / Float(duration!)
        }else{
            timerLabel.text = "DONE!"
            playSound(soundName: "alarm_sound")
            timer.invalidate()
        }
    }
    
    func playSound(soundName: String) {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

            do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                    guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }

}
