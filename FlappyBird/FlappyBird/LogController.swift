//
//  LogController.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class LogController: SKNode {
    
    private let topLog = Log(type: .top)
    private let bottomLog = Log(type: .bottom)
    private let logGap: CGFloat = 250.0
    
    private var scoreNode = ScoreNode()
    private var logArray: [Log]!
    private var frameCount: TimeInterval = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Setup
    private func setup()  {
        logArray = [topLog, bottomLog]
        
        scoreNode = ScoreNode(size: bottomLog.size)
    }
    
    
     // MARK: - Spawn
    private func spawn() {
        let randomY = CGFloat(arc4random_uniform(UInt32(kViewSize.height/3)))
        
        let newTopLog = logArray[0].copy() as! Log
        let newBottomLog = logArray[1].copy() as! Log
        let newScoreNode = scoreNode.copy() as! ScoreNode

        
        newBottomLog.position = CGPoint(x: kViewSize.width + bottomLog.size.width, y: randomY)
        newTopLog.position = CGPoint(x: newBottomLog.position.x, y: newBottomLog.position.y + bottomLog.size.height + logGap)
        newScoreNode.position = CGPoint(x: newBottomLog.position.x + newBottomLog.size.width * 0.75, y: kViewSize.height / 2)
        
        self.addChild(newBottomLog)
        self.addChild(newTopLog)
        self.addChild(newScoreNode)
        
    }
    
    
    // MARK: - Update
    func update(delta: TimeInterval)  {
        frameCount += delta
        
        if frameCount >= 2.0 {
            spawn()
            
            frameCount = 0.0
        }
        
        for node in self.children {
            if let log = node as? Log {
                log.update(delta: delta)
            }
            if let scoreNode = node as? ScoreNode {
                scoreNode.update(delta: delta)
            }

        }
    }
    
    
    
    
}
