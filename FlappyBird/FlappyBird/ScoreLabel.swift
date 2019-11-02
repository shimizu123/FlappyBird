//
//  ScoreLabel.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/24.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class ScoreLabel: SKNode {
    
    private let label = SKLabelNode(fontNamed: kFont)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
        
    }
    
    // MARK: - Setup
    private func setup()  {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.8)
        
        label.text = String(0)
        label.fontColor = Colors.colorFrom(rgb: Colors.score)
        label.fontSize = 200.0
        label.alpha = 0.5
        
        self.addChild(label)
    }

    
    // MARK: - Update
    func updateScore(score: Int)  {
        label.text = String(score)
    }

        
    
}
