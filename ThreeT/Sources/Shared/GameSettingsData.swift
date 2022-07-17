//
//  GameSettingsData.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

class GameSettingsData: ObservableObject {
    @Published var soundEnabled: Bool = UserDefaults.standard.object(forKey: GameGlobals.settingsSoundStoreKey) != nil ? UserDefaults.standard.bool(forKey: GameGlobals.settingsSoundStoreKey) : false {
        didSet {
            UserDefaults.standard.set(soundEnabled, forKey: GameGlobals.settingsSoundStoreKey)
        }
    }
}
