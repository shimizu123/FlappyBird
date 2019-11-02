//
//  Flappy.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit

class Flappy: SKSpriteNode {
    
    private let animationName = "Flap"
    
    private var score = 0
    
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
      
    }

    // MARK: - Setup
    private func setup()  {
        let flap0 = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        let flap1 = Textures.sharedInstance.textureWith(name: SpriteName.player1)
        
        let animation = SKAction.animate(with: [flap0,flap1], timePerFrame: 0.1)
        
        self.run(SKAction.repeatForever(animation), withKey: animationName)
        
        self.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.8)
        
        
    }

    private func setupPhysics()  {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height/3, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.flappy
        self.physicsBody?.collisionBitMask = Contact.scene
        self.physicsBody?.contactTestBitMask = Contact.scene | Contact.log | Contact.score
    }
    
    // MARK: - update

    func update()  {
        if self.physicsBody!.velocity.dy > 30.0 {
            self.zRotation = CGFloat(M_PI / 6.0)
        } else if self.physicsBody!.velocity.dy < -100.0 {
            self.zRotation = CGFloat(-1 * (M_PI_4))
        } else {
            self.zRotation = 0.0
        }
        
                
    }
    
    // MARK: - Actions
    func fly()  {
        self.physicsBody?.velocity = CGVector.zero
        
        let impulse = CGVector(dx:0, dy: 20)
        
        self.physicsBody?.applyImpulse(impulse)
        
        self.run(Sound.sharedInstance.playSound(sound: .flap))
        
    }

    
    private func animate() {
    }

    // MARK: - Update score
    func updateScore()  {
        score += 1
        
        self.run(Sound.sharedInstance.playSound(sound: .score))
    }
    
    func getScore() -> Int {
        return score
    }
    
    //MARK：声音
    func crashed()  {
        self.run(Sound.sharedInstance.playSound(sound: .crash))
    }
    func smacked()  {
        self.run(Sound.sharedInstance.playSound(sound: .smack)) { 
            self.run(Sound.sharedInstance.playSound(sound: .fall))
        }
    }
    private func stopAnimation()  {
        self.removeAction(forKey: animationName)
    }
    //MARK: - 烟雾效果
    private func animateSmoke()  {
        let smoke = Smoke()
        self.addChild(smoke)
        smoke.animate()
        
    }
    
    
    func gameOver()  {
        stopAnimation()
        animateSmoke()
        checkScore()
    }
    
    private func checkScore()  {
        if score > Settings.sharedInstance.getScore() {
            Settings.sharedInstance.saveBest(score: score)
        }
    }
}
