//
//  GameGlobals.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

extension Color {
    static let darkBlue = Color("ColorBlueDark")
    static let mediumBlue = Color("ColorBlueMedium")
    static let gameRed = Color("ColorRed")
    static let gameGreen = Color("ColorGreen")
}

struct GameGlobals {
    static let appTitle = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    static let gameFont = "Marker Felt"
    static let urlInfo = "https://threet.seriousmonkey.de"
    
    static func versionString() -> String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? {
            return version
        }
        
        return "unknown"
    }
}
