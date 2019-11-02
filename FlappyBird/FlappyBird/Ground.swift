//
//  Ground.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.ground)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        // Set the anchorPoint to be in the bottom left corner, (0,0)
        self.anchorPoint = CGPoint.zero
        
        // Set the position to be in the bottom left corner (0,0)
        self.position = CGPoint.zero
        
        //在右边增加第二块地面
        let childSprite = Textures.sharedInstance.spriteWith(name: SpriteName.ground)
        childSprite.anchorPoint = CGPoint.zero
        childSprite.position = CGPoint(x: self.size.width, y: 0)
        self.addChild(childSprite)
        
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.scene
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 0
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        let moveAmount = CGFloat(delta) * 60 * 2
        
        if self.position.x < 0 - self.size.width / 2 {
            self.position = CGPoint.zero
        } else {
            let newX = self.position.x - moveAmount
            self.position = CGPoint(x: newX, y: self.position.y)
        }
    }
    
    // MARK: - Actions
    private func animate() {
    }
}
