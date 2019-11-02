//
//  Log.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Log: SKSpriteNode {
    
    enum Logtype {
        case top, bottom
    }
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    convenience init(type: Logtype) {
        var texture = SKTexture()
        
        switch type {
        case .top:
            texture = Textures.sharedInstance.textureWith(name: SpriteName.topLog)
        default:
            texture = Textures.sharedInstance.textureWith(name: SpriteName.bottomLog)
        }
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
        
    }
    // MARK: - Setup
    private func setup() {
    }
    
    private func setupPhysics()  {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.log
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    // MARK: - Update
    func update(delta: TimeInterval)  {
        let moveAmount = CGFloat(delta) * 60 * 2
        
        self.position.x -= moveAmount
        
        if self.position.x < -self.size.width {
            self.removeFromParent()
        }
        
    }
    
    // MARK: - Actions
    private func animate() {
    }

    
}
