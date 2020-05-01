//
//  EndscreenView.swift
//  ThreeT
//
//  Created by Martin Albrecht on 02.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

struct EndscreenView: View {
    @State var game: Game
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Text(getPlayerLabel().localizedFormat())
                        .foregroundColor(.white)
                        .font(.custom(GameGlobals.gameFont, size: GameFontSize.medium.rawValue))
                        .bold()
                    
                    Text("Game Over")
                        .foregroundColor(.white)
                        .font(.headline)
                        .bold()
                }
                
                Spacer()
            }
            
            VStack {
                Text("Play again")
                    .gameFont(color: .green)
                    .onTapGesture {
                        self.game.restart()
                    }
                
                Text("Exit")
                    .gameFont(color: .red)
                    .onTapGesture {
                        self.game.reset()
                    }
            }
            .padding(.top, 10)
        }
        .padding(.leading, 50)
        .padding(.trailing, 50)
        .padding([.top, .bottom])
        .background(GameGlobals.colorDarkBlue.opacity(0.95))
    }
    
    func getPlayerLabel() -> String {
        if game.winner == nil {
            return "Draw, no winner."
        }
        
        if game.mode == .multi {
            return String(format: "Winner: Player %d".localizedFormat(), arguments: self.game.winner == .player1 ? [1] : [2])
        }
        
        return "\(self.game.winner == .player1 ? "You won!" : "You lost!")"
    }
}

struct EndscreenView_Previews: PreviewProvider {
    static var previews: some View {
        EndscreenView(game: Game(mode: .single))
    }
}
