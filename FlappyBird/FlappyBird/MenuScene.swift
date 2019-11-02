//
//  MenuScene.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    private let cloudController = CloudController()
    private let hills = Hills()
    private let logo = Logo()
    private let title = Title()
    private let playbutton = PlayButton()
    private let ground = Ground()
    
    private var lastUpdateTime: TimeInterval = 0.0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        setup()
        
        Sound.sharedInstance.playMusic()
    }
    // MARK: -setup
    private func setup()  {
        self.backgroundColor = Colors.colorFrom(rgb: Colors.sky)
        
        self.addChild(cloudController)
        self.addChild(hills)
        self.addChild(logo)
        self.addChild(title)
        self.addChild(playbutton)
        self.addChild(ground)
        
       
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
        
        if playbutton.contains(touchLocation) {
            playbutton.tapped()
            loadScene()
        }
        
        
    }
    // MARK: -load scene
    private func loadScene()  {
        let scene = GameScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
