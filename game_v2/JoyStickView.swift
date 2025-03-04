//
//  JoyStickView.swift
//  game_v2
//
//  Created by Moritz Kohlenz on 3/3/25.
//

import SpriteKit

class JoystickNode: SKNode {
    
    // MARK: - State Properties
    
    var angle: CGFloat = 0
    var isActive: Bool = false
    var distance: CGFloat = 0
    
    // MARK: - Constants
    
    private let bigCircleRadius: CGFloat = 50
    private let smallCircleRadius: CGFloat = 20
    private let defaultLocation = CGPoint(x: 0, y: 0)
    
    private let outerCircle: SKShapeNode
    private let innerCircle: SKShapeNode
    
    // A background area to make sure touches are detected
    private let touchArea: SKShapeNode
    
    override init() {
        // Outer circle (base of the joystick)
        outerCircle = SKShapeNode(circleOfRadius: bigCircleRadius)
        outerCircle.fillColor = .gray
        outerCircle.alpha = 0.5
        
        // Inner circle (joystick knob)
        innerCircle = SKShapeNode(circleOfRadius: smallCircleRadius)
        innerCircle.fillColor = .darkGray
        innerCircle.alpha = 0.7
        
        // Touch detection area (invisible)
        touchArea = SKShapeNode(circleOfRadius: bigCircleRadius * 2)
        touchArea.fillColor = .clear
        touchArea.strokeColor = .clear
        
        super.init()
        
        self.isUserInteractionEnabled = true
        
        // Position circles
        outerCircle.position = defaultLocation
        innerCircle.position = defaultLocation
        touchArea.position = defaultLocation
        
        addChild(outerCircle)
        addChild(innerCircle)
        addChild(touchArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touch Handling

    // Add this property in your JoystickNode class
    private var activeTouch: UITouch?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Only register a new touch if one is not already active
        if activeTouch == nil {
            for touch in touches {
                let location = touch.location(in: self)
                // Optionally, check if the location is within your touch area:
                if touchArea.contains(location) {
                    activeTouch = touch
                    isActive = true
                    updateJoystick(to: location)
                    break
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let activeTouch = activeTouch, touches.contains(activeTouch) {
            let location = activeTouch.location(in: self)
            updateJoystick(to: location)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let activeTouch = activeTouch, touches.contains(activeTouch) {
            resetJoystick()
            self.activeTouch = nil
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let activeTouch = activeTouch, touches.contains(activeTouch) {
            resetJoystick()
            self.activeTouch = nil
        }
    }

//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        resetJoystick()
//    }
        
    private func updateJoystick(to location: CGPoint) {
        isActive = true
        let dx = location.x - outerCircle.position.x
        let dy = location.y - outerCircle.position.y
        let computedDistance = hypot(dx, dy)
        
        if outerCircle.position == defaultLocation && innerCircle.position == defaultLocation && computedDistance > bigCircleRadius {
            outerCircle.position = location
            innerCircle.position = location
            return
        }
        
        let computedAngle = atan2(dy, dx)
        let deltaDistance = max(0, computedDistance - bigCircleRadius)
        let newX = outerCircle.position.x + deltaDistance * cos(computedAngle)
        let newY = outerCircle.position.y + deltaDistance * sin(computedAngle)
        
        outerCircle.position = CGPoint(x: newX, y: newY)
        innerCircle.position = location
        angle = computedAngle
        distance = computedDistance
    }

    private func resetJoystick() {
        innerCircle.position = defaultLocation
        outerCircle.position = defaultLocation
        angle = 0
        distance = 0
        isActive = false
    }
}
