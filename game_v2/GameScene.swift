//
//  GameScene.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import SpriteKit

class GameScene: SKScene {
    // Create two joystick nodes
    let leftJoystick = JoystickNode()
    let rightJoystick = JoystickNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Call the method to add the joysticks to the scene.
        addJoysticks()
    }
    
    /// Adds two joystick nodes to the scene.
    func addJoysticks() {
        let joystickPadding: CGFloat = 20

        // Position the left joystick in the bottom left.
        leftJoystick.position = CGPoint(x: 75 + joystickPadding,
                                        y: 75 + joystickPadding)
        // Only add if it's not already in the scene.
        if leftJoystick.parent == nil {
            addChild(leftJoystick)
        }
        
        // Position the right joystick in the bottom right.
        rightJoystick.position = CGPoint(x: size.width - 75 - joystickPadding,
                                         y: 75 + joystickPadding)
        if rightJoystick.parent == nil {
            addChild(rightJoystick)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Use joystick values (like leftJoystick.angle, leftJoystick.distance, etc.)
        // to control your game objects or camera.
    }
}
