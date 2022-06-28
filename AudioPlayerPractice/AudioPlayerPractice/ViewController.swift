//
//  ViewController.swift
//  AudioPlayerPractice
//
//  Created by J_Min on 2022/06/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    var audioFile: AVAudioFile?
    let engine = AVAudioEngine()
    let pitchControl = AVAudioUnitTimePitch()
    let audioPlayer = AVAudioPlayerNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        play()
    }
    
    func play() {
        let url = Bundle.main.url(forResource: "2511", withExtension: "mp3")!
        print(url)
        let audioFile = try! AVAudioFile(forReading: url)
        print(audioFile)
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        
        engine.connect(audioPlayer, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
        
        audioPlayer.scheduleFile(audioFile, at: nil)
        
        try! engine.start()
    }
    
    @IBAction func playButton(_ sender: Any) {
        print(engine.isRunning)
        if !engine.isRunning {
            play()
        }
        audioPlayer.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        audioPlayer.pause()
    }
    
    @IBAction func stopButton(_ sender: Any) {
        audioPlayer.stop()
        engine.stop()
    }
}

