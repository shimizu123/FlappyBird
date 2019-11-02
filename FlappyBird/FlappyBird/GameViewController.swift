//
//  GameViewController.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if view.scene == nil {
                if kDebug {
                    view.showsPhysics = true
                    view.showsDrawCount = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
                
                let scene = MenuScene(size: kViewSize)
                let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
                
                view.presentScene(scene, transition: transition)
                
                
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
