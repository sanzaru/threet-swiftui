//
//  GameMenuView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct GameMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var game: Game
    
    fileprivate let textColor: Color = .darkBlue
    
    var body: some View {
        VStack(spacing: 15) {
            Button(
                action: { game.start(mode: .single) },
                label: {
                    Text("labelPlayAlone")
                        .font(.system(size: Text.FontSize.small.rawValue))
                }
            )
            .accessibility(identifier: "play-alone")
            .buttonStyle(GameMenuButtonStyle(backgroundColor: Color.darkBlue.opacity(0.9), small: false))
            
            Text("labelOr")
                .font(.system(size: Text.FontSize.small.rawValue))
                .bold()
                .foregroundColor(Color.gameRed.opacity(0.8))
            
            
            Button(
                action: { game.start(mode: .multi) },
                label: {
                    Text("labelMultiplayer")
                        .font(.system(size: Text.FontSize.small.rawValue))
                }
            )
            .accessibility(identifier: "play-versus")
            .buttonStyle(GameMenuButtonStyle(backgroundColor: Color.darkBlue.opacity(0.9), small: false))
            
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
        GameMenuView(game: Game(mode: .single).start())
    }
}
