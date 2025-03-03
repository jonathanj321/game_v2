//
//  GameViewController.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import UIKit
import SpriteKit
import SwiftUI

class GameViewController: UIViewController {
    
    // Create joystick state objects
    let leftJoystickState = JoystickState()
    let rightJoystickState = JoystickState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the SpriteKit view
        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)
        
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Overlay the joystick views
        setupJoystickViews()
    }
    
    func setupJoystickViews() {
        let joystickSize: CGFloat = 150
        
        // Left joystick (bottom left)
        let leftJoystickVC = UIHostingController(
            rootView: JoystickView(joystickState: leftJoystickState)
        )
        leftJoystickVC.view.frame = CGRect(
            x: 20,
            y: view.bounds.height - joystickSize - 20,
            width: joystickSize,
            height: joystickSize
        )
        leftJoystickVC.view.backgroundColor = .clear
        addChild(leftJoystickVC)
        view.addSubview(leftJoystickVC.view)
        leftJoystickVC.didMove(toParent: self)
        
        // Right joystick (bottom right)
        let rightJoystickVC = UIHostingController(
            rootView: JoystickView(joystickState: rightJoystickState)
        )
        rightJoystickVC.view.frame = CGRect(
            x: view.bounds.width - joystickSize - 20,
            y: view.bounds.height - joystickSize - 20,
            width: joystickSize,
            height: joystickSize
        )
        rightJoystickVC.view.backgroundColor = .clear
        addChild(rightJoystickVC)
        view.addSubview(rightJoystickVC.view)
        rightJoystickVC.didMove(toParent: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
