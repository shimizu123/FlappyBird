//
//  GameScene.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // MARK: - 游戏状态
    private enum State {
        case tutorial, running, paused, gameOver
    }
    
    private let cloudController = CloudController()
    private let hills = Hills()
    private let ground = Ground()
    private let tutorial = Tutorial()
    private let flappy = Flappy()
    private let logController = LogController()
    private let scoreLabel = ScoreLabel()
    private let gameNode = SKNode()
    private let interfaceNode = SKNode()
    private let pauseButton = PauseButton()
    
    
    
    private var lastUpdateTime:TimeInterval = 0.0
    private var state: State = .tutorial
    private var previousState: State = .tutorial
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(paused), name: NSNotification.Name(rawValue: "Pause"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resumeGame), name:NSNotification.Name(rawValue: "Resume") , object: nil)
        
        setup()
    }
    // MARK: -setup
    private func setup()  {
        self.backgroundColor = Colors.colorFrom(rgb: Colors.sky)
        
        self.addChild(gameNode)
        
        gameNode.addChild(cloudController)
        gameNode.addChild(hills)
        gameNode.addChild(ground)
        gameNode.addChild(tutorial)
        gameNode.addChild(flappy)
        gameNode.addChild(logController)
        gameNode.addChild(scoreLabel)
        
        self.addChild(interfaceNode)
        interfaceNode.addChild(pauseButton)
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector.zero
    
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Contact.scene
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 0
        
    }
    
    // MARK: -update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        switch state {
        case .tutorial:
            cloudController.update(delta: delta)
            
        case .running:
            cloudController.update(delta: delta)
            flappy.update()
            logController.update(delta: delta)
            ground.update(delta: delta)
            hills.update(delta: delta)
            
        case .paused:
            return
            
        case .gameOver:
            return
            
        }
        

    }
    // MARK: -touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if pauseButton.contains(touchLocation) {
            pausePressed()
        }
        
        if state == .tutorial {
            if tutorial.contains(touchLocation) {
                tutorial.tapped()
                running()
            }
        } else if state == .running {
                flappy.fly()
        
        }

      
    }
    
    // MARK: - Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        if state != .running {
            return
        } else {
            let other = contact.bodyA.categoryBitMask == Contact.flappy ? contact.bodyB : contact.bodyA
        
            if other.categoryBitMask == Contact.scene {
                flappy.crashed()
                shake()
                flash()
                gameOver()
            }
            if other.categoryBitMask == Contact.log {
                flappy.smacked()
                shake()
                flash()
                gameOver()
            }
            if other.categoryBitMask == Contact.score {
                flappy.updateScore()
                scoreLabel.updateScore(score: flappy.getScore())
            }

            }
        }
    // MARK: - state
    private func running()  {
        state = .running
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
    }
    func paused()  {
        previousState = state
        state = .paused
        
        gameNode.speed = 0.0
        
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.speed = 0.0
        
    }
    func resume()  {
        state = previousState
        
        gameNode.speed = 1.0
        
        if previousState == .running || previousState == .gameOver {
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        } else {
            self.physicsWorld.gravity = CGVector.zero
        }
        
        self.physicsWorld.speed = 1.0
    }
    
    func resumeGame()  {
        //定时器
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resume), userInfo: nil, repeats: false)
    }
    
    
    
    
    
    func gameOver()  {
        state = .gameOver
        
        flappy.gameOver()
        
        pauseButton.run(SKAction.scale(to: 0.0, duration: 0.25)) { 
            self.removeFromParent()
        }
        
        self.run(SKAction.wait(forDuration: 2.0)) { 
            self.loadScene()
        }
    }
    
    private func pausePressed()  {
        pauseButton.tapped()
        
        if pauseButton.getPauseState() {
            paused()
            
            gameNode.isPaused = true
        } else {
            resume()
            
            gameNode.isPaused = false
        
        }
    }
    
    
    
    
    
    
    
    // MARK: - Scene Animations
    private func shake()  {
        gameNode.run(SKAction.shake(amount: CGPoint(x: 16, y: 16), duration: 0.5))
    }
    private func flash()  {
        let colorFlash = SKAction.run { 
            self.backgroundColor = Colors.colorFrom(rgb: Colors.flash)
            
            self.run(SKAction.wait(forDuration: 0.5), completion: {
                self.backgroundColor = Colors.colorFrom(rgb: Colors.sky)
            })
        }
            
        self.run(colorFlash)
        
    }
    
    // MARK: -load scene
    private func loadScene()  {
        let scene = GameOverScene(size: kViewSize, score: flappy.getScore())
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    // MARK: - Deinit
     deinit  {
        NotificationCenter.default.removeObserver(self)
    }
}

