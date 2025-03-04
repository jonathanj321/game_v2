//
//  GameScene.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import SpriteKit

import SpriteKit

class GameScene: SKScene {
    
    let leftJoystick = JoystickNode()
    let rightJoystick = JoystickNode()
    let character = CharacterNode(texture: SKTexture(imageNamed: "character"))  // Load a texture

    override func didMove(to view: SKView) {
        backgroundColor = .black

        character.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(character)
        
        addJoysticks()
    }
    
    func addJoysticks() {
        leftJoystick.position = CGPoint(x: 125, y: 100)
        rightJoystick.position = CGPoint(x: size.width - 125, y: 100)

        addChild(leftJoystick)
        addChild(rightJoystick)
    }

    override func update(_ currentTime: TimeInterval) {
        character.move(with: leftJoystick)
        character.shoot(from: rightJoystick, in: self)
    }
}
