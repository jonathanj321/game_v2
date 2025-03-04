//
//  GameViewController.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the SpriteKit view.
        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)
        
        // Create the game scene.
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        // Add joystick nodes directly to the scene.
        // (Assumes that you have defined an 'addJoysticks()' method in GameScene,
        // which instantiates and positions two JoystickNode instances.)
//        scene.addJoysticks()
        
        // Present the scene.
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
