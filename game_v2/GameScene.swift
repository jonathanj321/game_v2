//
//  GameScene.swift
//  game_v2
//
//  Created by Jonathan Jiang on 3/3/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Example: Setup a player node.
        let player = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(player)
        
        // Optionally, add GameplayKit entities, systems, etc.
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Update game state and perform collision detection.
    }
}
