//
//  GameSettings.swift
//  ThreeT
//
//  Created by Martin Albrecht on 24.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var soundEnabled: Bool = UserDefaults.standard.object(forKey: "soundEnabled") != nil ? UserDefaults.standard.bool(forKey: "soundEnabled") : true {
        didSet {
            UserDefaults.standard.set(self.soundEnabled, forKey: "soundEnabled")
        }
    }
}
