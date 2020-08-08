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
    static let red = Color("ColorRed")
    static let green = Color("ColorGreen")
}

struct GameGlobals {
    static let gameFont = "Marker Felt"
    
    enum fontSize: CGFloat {
        case small = 20
        case medium = 30
        case big = 50
        case large = 70
    }
    
    static func getVersionString() -> String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? {
            return "Version: \(version)"
        }
        
        return "Version: unknown"
    }
}
