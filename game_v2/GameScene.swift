//
//  GameScene.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import SpriteKit

import SpriteKit

class GameScene: SKScene {
    
    let joyStickValidArea = CGSize(width: UIScreen.main.bounds.width / 1.45, height: UIScreen.main.bounds.height * 1.6)

    
    var leftJoystick: JoystickNode!
    var rightJoystick: JoystickNode!
    let customBlue = UIColor(red: 9.0/255, green: 133.0/255, blue: 247.0/255, alpha: 255.0/255)
    let customRed = UIColor(red: 234.0/255, green: 73.0/255, blue: 51.0/255, alpha: 255.0/255)

    // Create two joystick nodes
    

    let character = CharacterNode(texture: SKTexture(imageNamed: "character"))  // Load a texture

    override func didMove(to view: SKView) {
        backgroundColor = .black

        character.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(character)
        
        addJoysticks()
    }
    
    func addJoysticks() {
            leftJoystick = JoystickNode(rectSize: joyStickValidArea, color: customBlue)
            rightJoystick = JoystickNode(rectSize: joyStickValidArea, color: customRed)

            // Position the left joystick in the bottom left.
            leftJoystick.position = CGPoint(x: 125,
                                            y: 100)
            // Only add if it's not already in the scene.
            if leftJoystick.parent == nil {
                addChild(leftJoystick)
            }
            
            // Position the right joystick in the bottom right.
            rightJoystick.position = CGPoint(x: size.width - 125,
                                             y: 100)
            if rightJoystick.parent == nil {
                addChild(rightJoystick)
            }
        }

    override func update(_ currentTime: TimeInterval) {
        character.move(with: leftJoystick)
        character.shoot(from: rightJoystick, in: self)
    }
}
