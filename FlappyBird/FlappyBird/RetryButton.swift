//
//  RetryButton.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class RetryButton:SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.retryButton)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
    }
    
    private func setupPhysics() {
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
    }
    
    // MARK: - Actions
    private func animate() {
    }
    func tapped()  {
        
        self.run(Sound.sharedInstance.playSound(sound: .pop))

    }
}

