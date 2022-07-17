//
//  GameSettingsData.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

class GameSettingsData: ObservableObject {
    @Published var soundEnabled = UserDefaults.standard.bool(forKey: GameSettingsData.settingsSoundStoreKey) {
        didSet {
            UserDefaults.standard.set(soundEnabled, forKey: GameSettingsData.settingsSoundStoreKey)
        }
    }

    private static let settingsSoundStoreKey = "soundEnabled"
}
