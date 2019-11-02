//
//  Hills.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Hills: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.hills)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
        
    }
    
//    MARK: setup
    private func setup()  {
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint.zero
        
        //在右边增加第二块草
        let childSprite = Textures.sharedInstance.spriteWith(name: SpriteName.hills)
        childSprite.anchorPoint = CGPoint.zero
        childSprite.position = CGPoint(x: self.size.width, y: 0)
        self.addChild(childSprite)

    }
    
//    MARK: setupPhysics
    private func setupPhysics()  {
        
    }
//    MARK: update
    func update(delta: TimeInterval)  {
        let moveAmount = CGFloat(delta) * 60 * 0.25
        
        if self.position.x < 0 - self.size.width / 2 {
            self.position = CGPoint.zero
        } else {
            let newX = self.position.x - moveAmount
            self.position = CGPoint(x: newX, y: self.position.y)
        }

    }
//    MARK: animate
    private func animate()  {
        
    }
    
    
    
    
    
}
