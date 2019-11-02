//
//  ScoreNode.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class ScoreNode:SKNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(size: CGSize) {
        self.init()
        
        setupPhysics(size: size)
    }
    
    private func setupPhysics(size: CGSize) {
        let nodeSize = CGSize(width: size.width / 2, height: kViewSize.height)
        self.physicsBody = SKPhysicsBody(rectangleOf: nodeSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.score
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    func update(delta: TimeInterval) {
        let moveAmount = CGFloat(delta) * 60 * 2
        
        self.position.x = self.position.x - moveAmount
        
        if self.position.x < (0 - self.frame.size.width) {
            self.removeFromParent()
        }
        
    }
}
