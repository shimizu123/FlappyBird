//
//  Cloud.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Cloud: SKSpriteNode{
    
    enum CloudSize {
        case large, medium, small
    }
    
    var moveSpeed: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    convenience init(cloudSize: CloudSize) {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.cloud)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup(cloudSize: cloudSize)
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup(cloudSize: CloudSize) {
        switch cloudSize {
        case .large:
            return
            
        case .medium:
            self.setScale(0.75)
            
        case .small:
            self.setScale(0.5)
            
        }
    }
    
    private func setupPhysics() {
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        let speedX = CGFloat(delta) * moveSpeed * 2
        
        self.position.x -= speedX
        
        // Remove the cloud if completely offscreen left
        if self.position.x < (0 - self.size.width) {
            self.removeFromParent()
        }
    }
    
    // MARK: - Actions
    private func animate() {
    }

    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
