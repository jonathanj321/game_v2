//
//  JoyStickState.swift
//  game_v2
//
//  Created by Moritz Kohlenz on 3/3/25.
//

import SwiftUI
import Combine

class JoystickState: ObservableObject {
    @Published var angle: Double = 0
    @Published var isActive: Bool = false
    @Published var distance: Double = 0
}
