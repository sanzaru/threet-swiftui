//
//  GameCell.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

enum GameCellState {
    case empty, player1, player2;
}

final class GameCell: ObservableObject {
    @Published var state: GameCellState
    
    init() {
        state = .empty
    }
    
    @discardableResult
    func setState(state: GameCellState) -> GameCell {
        self.state = state
        return self
    }
    
    @discardableResult
    func reset() -> GameCell {
        state = .empty
        return self
    }
}
