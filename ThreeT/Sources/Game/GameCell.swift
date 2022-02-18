//
//  GameCell.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

final class GameCell: ObservableObject {
    @Published var state: State
    
    typealias Index = Int
    
    enum State {
        case empty, player1, player2;
    }
    
    init(initialState: State = .empty) {
        state = initialState
    }
    
    func reset() {
        state = .empty
    }
}

typealias GameCells = [GameCell]
