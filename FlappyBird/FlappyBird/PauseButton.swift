//
//  PauseButton.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/25.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class PauseButton: SKSpriteNode {
    
    private let pauseTexture = Textures.sharedInstance.textureWith(name: SpriteName.pauseButton)
    private let resumeTexture = Textures.sharedInstance.textureWith(name: SpriteName.resumeButton)
    
    private var gamePaused = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.pauseButton)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        
    }
    
    // MARK: - Setup
    private func setup()  {
        self.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
        self.position = CGPoint(x: kViewSize.width, y: kViewSize.height)
    }
    // MARK: - Actions
    func tapped()  {
        gamePaused = !gamePaused
        
        self.texture = gamePaused ? resumeTexture : pauseTexture
        
        self.run(Sound.sharedInstance.playSound(sound: .pop))
        
        if gamePaused {
            Sound.sharedInstance.pauseMusic()
        } else {
            Sound.sharedInstance.resumeMusic()
        }
        
    }
    
    func getPauseState() -> Bool {
        return gamePaused
    }


    
    
    
    
    
    
    
    
}
