//
//  CloudController.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class CloudController: SKNode {
    
    private let largeCloud = Cloud(cloudSize: .large)
    private let mediumCloud = Cloud(cloudSize: .medium)
    private let smallCloud = Cloud(cloudSize: .small)
    
    private var cloudArray: [Cloud]!
    private var frameCount: TimeInterval = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
        
    }
    
//   MARK: - setup
    private func setup()  {
        cloudArray = [largeCloud, mediumCloud, smallCloud]
        
//    spawn the first cloud
        self.run(SKAction.wait(forDuration: 0.25)) { 
            self.spawnFirst()
        }
        
        
        
    }
//   MARK: - spawn
    private func spawn()  {
        let randomIndex = RandomIntegerBetween(min: 0, max: cloudArray.count-1)
        
        let randomSpeed = RandomFloatBetween(min: 6.0, max: 12.0)
        
        let cloud = cloudArray[randomIndex].copy() as! Cloud
        
        let startX = kViewSize.width + cloud.size.width
        let startY = RandomFloatBetween(min: kViewSize.height * 0.3, max: kViewSize.height * 0.8)
        
        cloud.position = CGPoint(x: startX, y: startY)
        
        cloud.moveSpeed = randomSpeed
        
        self.addChild(cloud)
        
    }

    
    private func spawnFirst()  {
        let randomIndex = RandomIntegerBetween(min: 0, max: cloudArray.count-1)
        
        let randomSpeed = RandomFloatBetween(min: 6.0, max: 12.0)
        
        let cloud = cloudArray[randomIndex].copy() as! Cloud
        
        let startX = RandomFloatBetween(min: kViewSize.width * 0.3, max: kViewSize.width * 0.7)
        let startY = RandomFloatBetween(min: kViewSize.height * 0.3, max: kViewSize.height * 0.7)
        
        cloud.position = CGPoint(x: startX, y: startY)
        
        cloud.moveSpeed = randomSpeed
        
        self.addChild(cloud)
        
    }
    
//    MARK: - update
    
    func update(delta: TimeInterval)  {
        frameCount += delta
        
        if self.frameCount >= 5.0 {
            spawn()
            
            frameCount = 0.0
            
        }
        
        for node in self.children {
            if let cloud = node as? Cloud{
               cloud.update(delta: delta)
                
            }
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
