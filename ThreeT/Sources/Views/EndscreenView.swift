//
//  EndscreenView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct EndscreenView: View {
    @State var game: Game
    
    private var playerLabel: String {
        if game.winner == nil {
            return "labelDraw"
        }
        
        if game.mode == .multi {
            return String(format: "labelWinner".localizedFormat(), arguments: self.game.winner == .player1 ? [1] : [2])
        }
        
        return "\(self.game.winner == .player1 ? "labelWin" : "labelLost")"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Text(playerLabel.localizedFormat())
                        .foregroundColor(.white)
                        .font(.custom(GameGlobals.gameFont, size: GameGlobals.fontSize.medium.rawValue))
                        .bold()
                    
                    Text("labelGameOver")
                        .foregroundColor(.white)
                        .font(.headline)
                        .bold()
                }
                
                Spacer()
            }
            .frame(maxWidth: 400)
            .padding([.top, .bottom])
            .background(Color.darkBlue.opacity(0.95))
            
            HStack {
                Button(
                    action: { game.restart() },
                    label: { Text("labelPlayAgain") }
                )
                .buttonStyle(GameMenuButtonStyle(backgroundColor: .gameGreen, small: true))
                
                Button(
                    action: { game.reset() },
                    label: { Text("labelExit") }
                )
                .buttonStyle(GameMenuButtonStyle(backgroundColor: .gameRed, small: true))             
            }
            .padding(.top, 20)
        }
    }
}

struct EndscreenView_Previews: PreviewProvider {
    static var previews: some View {
        EndscreenView(game: Game(mode: .single))
    }
}
