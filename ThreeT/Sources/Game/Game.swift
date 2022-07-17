//
//  Game.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI
import Combine

final class Game: ObservableObject {
    enum State {
        case empty, running, paused, thinking, end
    }

    enum Mode {
        case single, multi, network, demo
    }
    
    let onGameEnd = PassthroughSubject<Void, Never>()
    let onGameStart = PassthroughSubject<Void, Never>()
    
    @Published var mode: Mode?
    @Published var cells: GameCells = []
    @Published var nextPlayer: GameCell.State = .player1
    @Published var state: State = .empty
    @Published var error: String?
    @Published var winner: GameCell.State?
    
    private let enemy: Enemy

    /// Flag if we have a winner
    private var hasWinner: Bool {
        // Horizontal
        cells[0].state != .empty && cells[0].state == cells[1].state && cells[1].state == cells[2].state ||
        cells[3].state != .empty && cells[3].state == cells[4].state && cells[4].state == cells[5].state ||
        cells[6].state != .empty && cells[6].state == cells[7].state && cells[7].state == cells[8].state ||

        // Vertical
        cells[0].state != .empty && cells[0].state == cells[3].state && cells[3].state == cells[6].state ||
        cells[1].state != .empty && cells[1].state == cells[4].state && cells[4].state == cells[7].state ||
        cells[2].state != .empty && cells[2].state == cells[5].state && cells[5].state == cells[8].state ||

        // Diagonal
        cells[0].state != .empty && cells[0].state == cells[4].state && cells[4].state == cells[8].state ||
        cells[2].state != .empty && cells[2].state == cells[4].state && cells[4].state == cells[6].state
    }
    
    /// Initialize a game object
    /// - Parameter mode: The initial game mode for the game object
    init(mode: Mode?) {
        enemy = Enemy(state: .player2, oponnent: .player1)
        self.mode = mode
        initCells()
    }
}

// MARK: - Start the game
extension Game {
    /// Start a game
    func start(mode: Mode) {
        self.mode = mode
        start()
    }

    /// Start a game
    func start() {
        state = .running

        if mode == .demo {
            next()
            return
        }

        onGameStart.send()
    }
}

// MARK: - Restart / Reset
extension Game {
    /// Restart the game
    func restart() {
        reset()
        state = .running

        onGameStart.send()
    }

    /// Reset the game
    func reset() {
        resetCells()
        error = nil
        nextPlayer = .player1
        state = .empty
        winner = nil
    }
}

// MARK: - Game control
extension Game {
    /// Calculate next step in game
    func next() {
        if state == .running {
            switch nextPlayer {
            case .player1:
                if mode == .demo {
                    let cell = enemy.getRandomFreeCell(cells: cells)

                    setCellValue(index: cell)
                    sleep(5)
                }

                nextPlayer = .player2
                if mode == .single || mode == .demo {
                    next()
                }

            case .player2:
                if mode == .single || mode == .demo {
                    if setCellValue(index: enemy.analyze(cells: cells)) {
                        nextPlayer = .player1
                    }
                } else {
                    nextPlayer = .player1
                }

                if mode == .demo {
                    next()
                }

            default:
                break
            }
        }
    }

    /// End the game
    /// - Parameter winner: Cell state defining the winner
    func end(winner: GameCell.State?) {
        if let winner = winner {
            self.winner = winner == .player2 ? .player2 : .player1
        }
        
        state = .end
        onGameEnd.send()
    }
}

// MARK: - Cell operations
extension Game {
    /// Set cell value in given row and col index
    /// - Parameters:
    ///   - row: The row index
    ///   - col: The col index
    /// - Returns: True on field set, false if field was not set
    @discardableResult
    func setCellValue(row: Int, col: Int) -> Bool {
        if state == .running || state == .thinking {
            let cell = cells[calculateIndex(row: row, col: col)]

            if cell.state == .empty {
                cell.state = nextPlayer
                analyze()
                return true
            }
        }

        return false
    }

    /// Set the value inside the cell of the given cell index
    /// The index must be a number in the range of 0...9
    /// - Parameter index: The index number of the field to set
    /// - Returns: True on field set, false if field was not set
    @discardableResult
    func setCellValue(index: Int) -> Bool {
        if state == .running || state == .thinking {
            if index >= 0 && index < 9 && cells[index].state == .empty {
                cells[index].state = nextPlayer
                analyze()
                return true
            }
        }

        return false
    }

    /// Calculate the field index for given row and col. The returned number will be in range 0...9
    /// - Parameters:
    ///   - row: The row index
    ///   - col: The col index
    /// - Returns: The index number of the field
    func calculateIndex(row: Int, col: Int) -> Int {
        let index = (row * 3) + col
        return index <= 8 ? index : 0
    }
}

// MARK: - Private methods
extension Game {
    /// Analyze the game for winner
    private func analyze() {
        // Check for win condition
        if hasWinner {
            end(winner: nextPlayer)
            return
        }

        // Check for a draw
        if cells.filter({ $0.state != .empty }).count == cells.count {
            end(winner: nil)
        }
    }

    /// Reset all cell values
    private func resetCells() {
        cells.forEach { cell in
            cell.reset()
        }
    }

    /// Initialize all cell values
    private func initCells() {
        cells = (0...8).map({ _ in GameCell() })
    }
}
