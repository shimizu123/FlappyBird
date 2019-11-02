//
//  SKAction+Effects.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/25.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

extension SKAction {
    
    class func shake(amount: CGPoint, duration: TimeInterval) -> SKAction {
        
        let startX: CGFloat = 0.0
        let startY: CGFloat = 0.0
        
        let shakeNumber = Int(duration / 0.016)
        
        var actions: [SKAction] = []
        
        for _ in 0...shakeNumber {
            
            let newX = startX + CGFloat(arc4random_uniform(UInt32(amount.x) - UInt32(amount.x / 2)))
            let newY = startY + CGFloat(arc4random_uniform(UInt32(amount.y) - UInt32(amount.y / 2)))
            
            actions.append(SKAction.move(to: CGPoint(x: newX, y: newY), duration: 0.016))
        }
        
        actions.append(SKAction.move(to: CGPoint(x: startX, y: startY), duration: 0.016))
        
        return SKAction.sequence(actions)
    }
    
    
    
}
