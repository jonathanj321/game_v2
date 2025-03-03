//
//  GameViewController.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import SwiftUI
import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the SpriteKit view.
        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        // Overlay the joystick views.
        setupJoystickViews()
    }
    
    func setupJoystickViews() {
        let joystickSize: CGFloat = 150
        
        // Left Joystick (bottom left)
        let leftJoystickVC = UIHostingController(rootView: JoystickView())
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
        
        // Right Joystick (bottom right)
        let rightJoystickVC = UIHostingController(rootView: JoystickView())
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
    
    override var prefersStatusBarHidden: Bool { true }
}
