//
//  StartscreenView.swift
//  ThreeT
//
//  Created by Martin Albrecht on 01.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

struct StartscreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var game: Game?
    
    fileprivate let textColor = GameGlobals.colorDarkBlue
    
    var body: some View {
        HStack {
            VStack(spacing: 15) {                
                Text("Play alone")
                    //.gameFont(fontSize: GameFontSize.big.rawValue, color: textColor)
                    .font(.system(size: GameFontSize.big.rawValue))
                    .foregroundColor(textColor)
                    .bold()
                    .shadow(
                        color: textColor.opacity(0.4),
                        radius: 10, x: 0, y: 0
                    )
                    .onTapGesture {
                        if self.game != nil {
                            self.game!.setGameMode(mode: .single).start()
                        }
                    }
                
                Text("or")
                    //.font(.custom(GameGlobals.gameFont, size: GameFontSize.small.rawValue))
                    .font(.system(size: GameFontSize.small.rawValue))
                    .foregroundColor(textColor)
                    .bold()
                    .foregroundColor(textColor.opacity(0.6))
                
                Text("With a friend")
                    //.gameFont(fontSize: GameFontSize.medium.rawValue, color: textColor)
                    .font(.system(size: GameFontSize.medium.rawValue))
                    .foregroundColor(textColor)
                    .bold()
                    .shadow(
                        color: textColor.opacity(0.4),
                        radius: 10, x: 0, y: 0
                    )
                    .onTapGesture {
                        if self.game != nil {
                            self.game!.setGameMode(mode: .multi).start()
                        }
                    }
                
                /*ButtonView(label: "Demo", color: Color.red)
                .onTapGesture {
                    if self.game != nil {
                        self.game!.setGameMode(mode: .demo).start()
                    }
                }*/
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding([.top, .bottom])
        .background(Color.white.opacity(colorScheme == .light ? 0 : 0.5))
    }
}

struct StartscreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartscreenView(game: Game(mode: .single).start())
    }
}
