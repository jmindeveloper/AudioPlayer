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
        
        // 피치조절
        pitchControl.pitch += 100
        
        audioPlayer.scheduleFile(audioFile, at: nil)
        
        try! engine.start()
    }
    
    // currentTime 가져오기
    private func currentTime() -> TimeInterval {
        if let nodeTime: AVAudioTime = audioPlayer.lastRenderTime, let playerTime: AVAudioTime = audioPlayer.playerTime(forNodeTime: nodeTime) {
            return Double(Double(playerTime.sampleTime) / playerTime.sampleRate)
        }
        return 0
    }
    
    // duration 가져오기
    func duration() -> TimeInterval {
        let url = Bundle.main.url(forResource: "2511", withExtension: "mp3")!
        let audioFile = try! AVAudioFile(forReading: url)
        
        let audioNodeFileLength = AVAudioFrameCount(audioFile.length)
        return Double(Double(audioNodeFileLength) / 44100) //Divide by the AVSampleRateKey in the recorder settings
        
        
    }
    
    @IBAction func playButton(_ sender: Any) {
        print(engine.isRunning)
        if !engine.isRunning {
            play()
        }
        audioPlayer.play()
        print(duration())
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        audioPlayer.pause()
    }
    
    @IBAction func stopButton(_ sender: Any) {
        //        audioPlayer.stop()
        //        engine.stop()
        print(currentTime())
    }
}

