//
//  Sound.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/25.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit
import AVFoundation

enum SoundEffect {
    case crash, fall, highScore, pop, flap, score, smack
}


class Sound {
    
    static let sharedInstance = Sound()
    
    private let music = "Pixel Adventures.mp3"
    private let crashSound = "Crash.caf"
    private let fallSound = "Fall.caf"
    private let flapSound = "Flap.caf"
    private let highScoreSound = "HighScore.caf"
    private let popSound = "Pop.caf"
    private let scoreSound = "HighScore.caf"
    private let smackSound = "Smack.caf"
    
    private var player = AVAudioPlayer()
    private var initialized = false
    
    // MARK: - Music player
    func playMusic()  {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: music, ofType: nil)!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error as NSError {
            print("播放音乐错误\(error)")
        }
        
        player.numberOfLoops = -1
        player.volume = 0.25
        player.prepareToPlay()
        player.play()
        
        initialized = true
    }
    
    func stopMusic()  {
        if player.isPlaying {
            player.stop()
        }
    }
    func pauseMusic()  {
        if player.isPlaying {
            player.pause()
        }
    }
    func resumeMusic()  {
        if initialized {
            player.play()
        }
    }
    // MARK: - Sound Effects
    func playSound(sound: SoundEffect) -> SKAction {
        var file = String()
        
        switch sound {
        case .crash:
            file = crashSound
        case .fall:
            file = fallSound
        case .flap:
            file = flapSound
        case .highScore:
            file = highScoreSound
        case .pop:
            file = popSound
        case .score:
            file = scoreSound
        case .smack:
            file = smackSound
            
        }
        return SKAction.playSoundFileNamed(file, waitForCompletion: false)
    }

    
    
    
    
    
    
}
