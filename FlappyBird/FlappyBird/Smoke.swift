//
//  Smoke.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/25.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Smoke: SKSpriteNode {
    
    private var animation = SKAction()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.smoke0)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    //MARK: - setup
    private func setup()  {
        let frame0 = Textures.sharedInstance.textureWith(name: SpriteName.smoke0)
        let frame1 = Textures.sharedInstance.textureWith(name: SpriteName.smoke1)
        let frame2 = Textures.sharedInstance.textureWith(name: SpriteName.smoke2)
        let frame3 = Textures.sharedInstance.textureWith(name: SpriteName.smoke3)
        let frame4 = Textures.sharedInstance.textureWith(name: SpriteName.smoke4)
        
        animation = SKAction.animate(with: [frame0, frame1, frame2, frame3, frame4], timePerFrame: 0.1)
        
        self.alpha = 0.0

        
    }
     // MARK: - Actions
    func animate()  {
        self.alpha = 1.0
        
        self.run(self.animation) {
            self.removeFromParent()
        }
    }
    
    
    
}
