//
//  Enemy.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//
import CoreML

struct Enemy {
    private let state: GameCell.State
    private let oponnent: GameCell.State
    
    /// Initialize the enemy with a given game state and the opnonent's identifier
    /// - Parameters:
    ///   - state: Cell state describing the state
    ///   - oponnent: Identifier for the oponent
    init(state: GameCell.State, oponnent: GameCell.State) {
        self.state = state
        self.oponnent = oponnent
    }
}

extension Enemy {
    /// Calculate the index for a random free cell on the game board
    /// - Parameter cells: The cells of the game board
    /// - Returns: Index of the cell
    func getRandomFreeCell(cells: GameCells) -> Int {
        var found = false
        repeat {
            let rnd = Int.random(in: 0...8)

            if cells[rnd].state == .empty {
                found = true
                return rnd
            }
        } while found == false
    }
}

extension Enemy {
    /// Analyze the board and find next cell to take
    func analyze(cells: GameCells) -> GameCell.Index {
        if let model = try? TicTacToe(configuration: MLModelConfiguration()) {
            let input = TicTacToeInput(
                Field_0: cells[0].state.rawValue,
                Field_1: cells[1].state.rawValue,
                Field_2: cells[2].state.rawValue,
                Field_3: cells[3].state.rawValue,
                Field_4: cells[4].state.rawValue,
                Field_5: cells[5].state.rawValue,
                Field_6: cells[6].state.rawValue,
                Field_7: cells[7].state.rawValue,
                Field_8: cells[8].state.rawValue
            )

            if let prediction = try? model.prediction(input: input) {
                return GameCell.Index(prediction.Taken)
            }
        }

        return getRandomFreeCell(cells: cells)
    }

    // MARK: Legacy analyze function

    /// Analyze the board and find next cell to take
    /// The enemy will always first attempt to win, followed by an attempt to block any chance to lose the game.
    /// If no win condition and no condition to block are found the enemy will take a random free cell on the board.
    /// - Parameter cells: The cells of the game board
    /// - Returns: Index of the cell the enemy takes
//    func analyze(cells: GameCells) -> GameCell.Index {
//        if cells[1].state == state && cells[2].state == state ||
//            cells[3].state == state && cells[6].state == state ||
//            cells[8].state == state && cells[4].state == state ||
//            cells[1].state == oponnent && cells[2].state == oponnent ||
//            cells[3].state == oponnent && cells[6].state == oponnent ||
//            cells[8].state == oponnent && cells[4].state == oponnent {
//            if cells[0].state == .empty {
//                return 0
//            }
//        }
//
//        if cells[4].state == state && cells[7].state == state ||
//            cells[0].state == state && cells[2].state == state ||
//            cells[0].state == oponnent && cells[2].state == oponnent ||
//            cells[4].state == oponnent && cells[7].state == oponnent {
//            if cells[1].state == .empty {
//                return 1
//            }
//        }
//
//        if cells[0].state == state && cells[1].state == state ||
//            cells[5].state == state && cells[8].state == state ||
//            cells[6].state == state && cells[4].state == state ||
//            cells[0].state == oponnent && cells[1].state == oponnent ||
//            cells[5].state == oponnent && cells[8].state == oponnent ||
//            cells[6].state == oponnent && cells[4].state == oponnent {
//            if cells[2].state == .empty {
//                return 2
//            }
//        }
//
//        if cells[4].state == state && cells[5].state == state ||
//            cells[0].state == state && cells[6].state == state ||
//            cells[4].state == oponnent && cells[5].state == oponnent ||
//            cells[0].state == oponnent && cells[6].state == oponnent {
//            if cells[3].state == .empty {
//                return 3
//            }
//        }
//
//        if cells[3].state == state && cells[5].state == state ||
//            cells[1].state == state && cells[7].state == state ||
//            cells[0].state == state && cells[8].state == state ||
//            cells[2].state == state && cells[6].state == state ||
//            cells[3].state == oponnent && cells[5].state == oponnent ||
//            cells[1].state == oponnent && cells[7].state == oponnent ||
//            cells[0].state == oponnent && cells[8].state == oponnent ||
//            cells[2].state == oponnent && cells[6].state == oponnent {
//            if cells[4].state == .empty {
//                return 4
//            }
//        }
//
//        if cells[3].state == state && cells[4].state == state ||
//            cells[2].state == state && cells[8].state == state ||
//            cells[3].state == oponnent && cells[4].state == oponnent ||
//            cells[2].state == oponnent && cells[8].state == oponnent {
//            if cells[5].state == .empty {
//                return 5
//            }
//        }
//
//        if cells[7].state == state && cells[8].state == state ||
//            cells[0].state == state && cells[3].state == state ||
//            cells[2].state == state && cells[4].state == state ||
//            cells[7].state == oponnent && cells[8].state == oponnent ||
//            cells[0].state == oponnent && cells[3].state == oponnent ||
//            cells[2].state == oponnent && cells[4].state == oponnent {
//            if cells[6].state == .empty {
//                return 6
//            }
//        }
//
//        if cells[1].state == state && cells[4].state == state ||
//            cells[6].state == state && cells[8].state == state ||
//            cells[1].state == oponnent && cells[4].state == oponnent ||
//            cells[6].state == oponnent && cells[8].state == oponnent {
//            if cells[7].state == .empty {
//                return 7
//            }
//        }
//
//        if cells[6].state == state && cells[7].state == state ||
//            cells[2].state == state && cells[5].state == state ||
//            cells[0].state == state && cells[4].state == state ||
//            cells[6].state == oponnent && cells[7].state == oponnent ||
//            cells[2].state == oponnent && cells[5].state == oponnent ||
//            cells[0].state == oponnent && cells[4].state == oponnent {
//            if cells[8].state == .empty {
//                return 8
//            }
//        }
//
//        return getRandomFreeCell(cells: cells)
//    }
}
