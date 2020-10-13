//
//  StartscreenView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct GameMenuButton: ViewModifier {
    var background: Color = Color.darkBlue.opacity(0.9)
    var small: Bool = false
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 120)
            .multilineTextAlignment(.center)
            .font(.system(size: small ? 20 : 30))
            .padding(.horizontal, small ? 25 : 50)
            .padding(.vertical, small ? 7 : 15)
            .background(background)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(color: background.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}

extension View {
    func gameButton(background: Color, small: Bool) -> some View {
        self.modifier(GameMenuButton(background: background, small: small))
    }
}

struct StartscreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var game: Game?
    
    fileprivate let textColor: Color = .darkBlue
    
    var body: some View {
        VStack(spacing: 15) {
            Button(
                action: {
                    if self.game != nil {
                        self.game!.setGameMode(mode: .single).start()
                    }
                },
                label: {
                    Text("labelPlayAlone")
                        .font(.system(size: GameGlobals.fontSize.small.rawValue))
                        .gameButton(background: Color.darkBlue.opacity(0.9), small: false)
                }
            )
            .accessibility(identifier: "play-alone")
            
            Text("labelOr")
                .font(.system(size: GameGlobals.fontSize.small.rawValue))
                .bold()
                .foregroundColor(Color.gameRed.opacity(0.8))
            
            
            Button(
                action: {
                    if self.game != nil {
                        self.game!.setGameMode(mode: .multi).start()
                    }
                },
                label: {
                    Text("labelMultiplayer")
                        .font(.system(size: GameGlobals.fontSize.small.rawValue))
                        .gameButton(background: Color.darkBlue.opacity(0.9), small: false)
                }
            )
            .accessibility(identifier: "play-versus")
            
            /*ButtonView(label: "Demo", color: Color.red)
            .onTapGesture {
                if self.game != nil {
                    self.game!.setGameMode(mode: .demo).start()
                }
            }*/
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .bottom], 15)
    }
}

struct StartscreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartscreenView(game: Game(mode: .single).start())
    }
}
