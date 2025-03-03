//
//  JoyStickView.swift
//  game_v2
//
//  Created by Moritz Kohlenz on 3/3/25.
//

import SwiftUI

struct JoystickView: View {
    // Internal joystick state properties
    @State private var angle: Double = 0
    @State private var isActive: Bool = false
    @State private var distance: Double = 0
    
    // Default positions and dimensions within the view (assuming a 150x150 frame)
    private let defaultLocation = CGPoint(x: 75, y: 75)
    @State private var outerCircleLocation: CGPoint = CGPoint(x: 75, y: 75)
    @State private var innerCircleLocation: CGPoint = CGPoint(x: 75, y: 75)
    private let bigCircleRadius: CGFloat = 50
    
    // Gesture for controlling the joystick
    var fingerDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                isActive = true
                let computedDistance = sqrt(pow(value.location.x - outerCircleLocation.x, 2) +
                                            pow(value.location.y - outerCircleLocation.y, 2))
                
                if outerCircleLocation == defaultLocation && innerCircleLocation == defaultLocation && computedDistance > bigCircleRadius {
                    outerCircleLocation = value.location
                    innerCircleLocation = value.location
                    return
                }
                
                let computedAngle = atan2(value.location.y - outerCircleLocation.y,
                                          value.location.x - outerCircleLocation.x)
                let newX = outerCircleLocation.x + max(0, (computedDistance - bigCircleRadius)) * cos(computedAngle)
                let newY = outerCircleLocation.y + max(0, (computedDistance - bigCircleRadius)) * sin(computedAngle)
                
                outerCircleLocation = CGPoint(x: newX, y: newY)
                innerCircleLocation = value.location
                angle = computedAngle
                distance = computedDistance
            }
            .onEnded { _ in
                outerCircleLocation = defaultLocation
                innerCircleLocation = defaultLocation
                angle = 0
                isActive = false
                distance = 0
            }
    }
    
    // Display the computed angle as text (in degrees)
    var angleText: String {
        let computedAngle = atan2(innerCircleLocation.y - outerCircleLocation.y,
                                  innerCircleLocation.x - outerCircleLocation.x)
        var degrees = Int(-computedAngle * 180 / .pi)
        if degrees < 0 { degrees += 360 }
        return "\(degrees)°"
    }
    
    var body: some View {
        ZStack {
            // Full-area transparent background to capture gestures.
            Color.clear
                .frame(width: 1, height: 1)
                .contentShape(Rectangle())
                .simultaneousGesture(fingerDrag)
            
            // Outer circle representing the joystick base.
            Circle()
                .foregroundColor(.gray).opacity(0.5)
                .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 2)
                .position(outerCircleLocation)
                .gesture(fingerDrag)
            
            // Inner circle representing the joystick knob.
            Circle()
                .foregroundColor(Color(white: 0.4745)).opacity(0.5)
                .frame(width: bigCircleRadius / 1.25, height: bigCircleRadius / 1.25)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
            
            // Angle text overlay.
            Text(angleText)
                .font(.caption)
                .foregroundColor(.white)
                .bold()
                .padding(4)
                .background(Color.black.opacity(0.7))
                .cornerRadius(5)
                .position(x: 75, y: 20)
        }
        .frame(width: 150, height: 150)
    }
}
