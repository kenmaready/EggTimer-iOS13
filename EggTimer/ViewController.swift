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
    let cookTimes = [
        "Soft": 5 * 60,
        "Medium": 7 * 60,
        "Hard": 12 * 60
    ]
    var cookSeconds: Int?;
    var timer: Timer?
    var counter: Int?
    var player: AVAudioPlayer!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        cookSeconds = cookTimes[sender.currentTitle ?? "Medium"]
        startTimer(seconds: cookSeconds!)
    }
    
    func startTimer(seconds: Int) {
        timer?.invalidate()
        self.timerLabel.text = "Cook time remaining:"
        self.progressBar.progress = 0
        self.progressBar.alpha = 1
        var secondsLeft = seconds - 1
        var cookProgress: Float = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
            if secondsLeft > 0 {
                let mins = secondsLeft / 60;
                let secs = secondsLeft % 60;
                self.timerDisplay.text = "\(mins):\(secs < 10 ? "0" : "")\(secs)"
                cookProgress = Float(seconds - secondsLeft) / Float(seconds)
                self.progressBar.progress = cookProgress
                if secondsLeft < 60 {
                    self.progressBar.trackTintColor = UIColor .systemPink
                }
                secondsLeft -= 1
            } else {
                self.timerDisplay.text = "Done"
                self.timerLabel.text = ""
                self.progressBar.progress = 1.0
                self.playSound()
                timer.invalidate()
                
            }
        }
    }
        
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
                                    
    
}
