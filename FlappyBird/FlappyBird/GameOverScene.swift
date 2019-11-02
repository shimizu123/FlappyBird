//
//  GameOverScene.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: - Private class constants
    private let cloudController = CloudController()
    private let hills = Hills()
    private let ground = Ground()
    private let retryButton = RetryButton()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
    }
    convenience init(size: CGSize, score: Int) {
        self.init(size: size)
        
        setup(score: score)
    }
    
    
    override func didMove(to view: SKView) {
        
    }
    // MARK: -setup
    private func setup(score: Int)  {
        self.backgroundColor = Colors.colorFrom(rgb: Colors.sky)
        
        self.addChild(cloudController)
        self.addChild(hills)
        self.addChild(ground)
        self.addChild(retryButton)
        
        let scoreBoard = ScoreBoard(score: score)
        self.addChild(scoreBoard)
        
    }
    
    // MARK: -update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        cloudController.update(delta: delta)
    }
    // MARK: -touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if retryButton.contains(touchLocation) {
            retryButton.tapped()
            loadScene()
        }
        
        
    }
    // MARK: -load scene
    private func loadScene()  {
        let scene = MenuScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
}


