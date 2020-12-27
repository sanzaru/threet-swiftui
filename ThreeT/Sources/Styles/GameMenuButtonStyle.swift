//
//  GameMenuButtonStyle.swift
//  ThreeT
//
//  Created by Martin Albrecht on 25.12.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

struct GameMenuButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color.darkBlue.opacity(0.9)
    var foregroundColor: Color = .white
    var small: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .font(.system(size: small ? 20 : 30))
            .padding(.horizontal, small ? 25 : 50)
            .padding(.vertical, small ? 7 : 15)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .shadow(color: backgroundColor.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}
