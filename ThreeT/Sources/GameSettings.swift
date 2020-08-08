//
//  GameSettings.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var soundEnabled: Bool = UserDefaults.standard.object(forKey: "soundEnabled") != nil ? UserDefaults.standard.bool(forKey: "soundEnabled") : true {
        didSet {
            UserDefaults.standard.set(self.soundEnabled, forKey: "soundEnabled")
        }
    }
}
