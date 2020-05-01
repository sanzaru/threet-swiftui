//
//  GameGlobals.swift
//  ThreeT
//
//  Created by Martin Albrecht on 20.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

enum GameFontSize: CGFloat {
    case small = 20
    case medium = 30
    case big = 50
    case large = 70
}

struct GameGlobals {
    static let colorDarkBlue = Color("ColorBlueDark")
    static let colorMediumBlue = Color("ColorBlueMedium")
    static let colorRed = Color("ColorRed")
    static let colorGreen = Color("ColorGreen")
    
    static let gameFont = "Marker Felt"
    
    static func getVersionString() -> String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? {
            return "Version: \(version)"
        }
        
        return "Version: unknown"
    }
}
