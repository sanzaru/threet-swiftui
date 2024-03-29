//
//  GameGlobals.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct GameGlobals {
    static let appTitle = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    static let gameFont = "Marker Felt"
    static let urlInfo = "https://threet.seriousmonkey.de"
    
    static var versionString: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "unknown"
    }
}
