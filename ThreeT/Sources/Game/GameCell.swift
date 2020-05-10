//
//  GameCell.swift
//  ThreeT
//
//  Created by Martin Albrecht on 31.03.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import SwiftUI

enum GameCellState {
    case empty, player1, player2;
}

final class GameCell: ObservableObject {
    @Published var state: GameCellState
    
    init() {
        self.state = .empty
    }
    
    @discardableResult
    func setState(state: GameCellState) -> GameCell {
        self.state = state
        return self
    }
    
    @discardableResult
    func reset() -> GameCell {
        self.state = .empty
        return self
    }
}
