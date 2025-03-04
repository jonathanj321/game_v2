//
//  CharacterNode.swift
//  game_v2
//
//  Created by Moritz Kohlenz on 3/3/25.
//

import SpriteKit

class CharacterNode: SKSpriteNode {
    
    var speedMultiplier: CGFloat = 0.1 // Movement speed

    func move(with joystick: JoystickNode) {
        guard joystick.isActive else { return }
        
        let dx = cos(joystick.angle) * joystick.distance * speedMultiplier
        let dy = sin(joystick.angle) * joystick.distance * speedMultiplier
        
        position.x += dx
        position.y += dy
    }
    
    func shoot(from joystick: JoystickNode, in scene: SKScene) {
        guard joystick.isActive, joystick.distance > 20 else { return }  // Only shoot if joystick is pushed far enough
        
        let projectile = ProjectileNode()
        projectile.position = self.position
        
        scene.addChild(projectile)
        projectile.launch(angle: joystick.angle)
    }
}
