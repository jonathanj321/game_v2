//
//  ProjectileNode.swift
//  game_v2
//
//  Created by Moritz Kohlenz on 3/3/25.
//

import SpriteKit

class ProjectileNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "projectile")  // Use a small image or colored node
        super.init(texture: texture, color: .clear, size: CGSize(width: 10, height: 10))
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0x1 << 1  // Set projectile collision category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func launch(angle: CGFloat) {
        let speed: CGFloat = 400  // Adjust speed as needed
        let dx = cos(angle) * speed
        let dy = sin(angle) * speed
        self.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
    }
}
