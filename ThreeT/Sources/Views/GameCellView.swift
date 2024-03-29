//
//  GameCell.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct GameCellView: View {
    var cellState: GameCell.State
    
    var action: (() -> ())
    
    private let cornerRadius: CGFloat = 10
    private let color: [Color]  = [.darkBlue, .gameRed]
    
    var body: some View {
        Button(action: action) {
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(color[0].opacity(0.01))
                        .frame(minWidth: 30, maxWidth: 300, minHeight: 30, maxHeight: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(color[0], lineWidth: 1)
                                .frame(minWidth: 30, maxWidth: 300, minHeight: 30, maxHeight: 300)
                        )
                    
                    if cellState != .empty {
                        Text(cellState == .player1 ? "X" : "0")
                            .font(.custom(GameGlobals.gameFont, size: geometry.size.height * 0.5))
                            .foregroundColor(cellState == .player1 ? color[0] : color[1])
                            .bold()
                            .animation(.easeInOut)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct GameCellView_Previews: PreviewProvider {
    static var previews: some View {
        GameCellView(cellState: .player1) {
            print("Tapped")
        }
        .frame(width: 200, height: 200)

        GameCellView(cellState: .player1) {
            print("Tapped")
        }
        .frame(width: 200, height: 200)
        .preferredColorScheme(.dark)
    }
}
