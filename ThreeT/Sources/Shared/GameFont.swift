//
//  ButtonView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

extension Text {
    enum FontSize: CGFloat {
        case small = 20
        case medium = 30
        case big = 50
        case large = 90
    }
    
    func gameFont(fontSize: CGFloat = 30, color: Color, cornerRadius: CGFloat = 8) -> some View {
        bold()
        //.font(.system(size: fontSize))
        .font(.custom(GameGlobals.gameFont, size: fontSize))
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .foregroundColor(color)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {        
        Text("Debug label")
            .gameFont(color: Color("ColorBlueDark"))            
    }
}
