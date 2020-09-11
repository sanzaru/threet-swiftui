//
//  GameCell.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct GameCellView: View {
    @ObservedObject var cell: GameCell
    
    private let cornerRadius: CGFloat = 10
    private let color: [Color]  = [.darkBlue, .gameRed]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .fill(self.color[0].opacity(0.01))
                    .frame(minWidth: 30, maxWidth: 300, minHeight: 30, maxHeight: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.cornerRadius)
                            .stroke(self.color[0], lineWidth: 1)
                            .frame(minWidth: 30, maxWidth: 300, minHeight: 30, maxHeight: 300)
                    )
                
                
                if self.cell.state != .empty {
                    Text(self.cell.state == .player1 ? "X" : "0")
                        .font(.custom(GameGlobals.gameFont, size: self.fontSize(geometry: geometry)))
                        .foregroundColor(self.cell.state == .player1 ? self.color[0] : self.color[1])
                        .bold()
                        .animation(.easeInOut)
                }
            }
        }
    }
    
    private func fontSize(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height * 0.75
    }
}

struct GameCellView_Previews: PreviewProvider {
    @State static var s: CGFloat = 640.0
    
    static var previews: some View {
        GameCellView(cell: GameCell().setState(state: .player1))
    }
}
