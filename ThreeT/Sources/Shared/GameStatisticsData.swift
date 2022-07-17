//
//  GameStatisticsData.swift
//  ThreeT
//
//  Created by Martin Albrecht on 22.02.22.
//  Copyright © 2022 Martin Albrecht. All rights reserved.
//

import SwiftUI

class GameStatisticsData: ObservableObject {
    private(set) var score = Score()

    var wdlRateString: String {
        [score.wdlRate.0.gameStatsString, score.wdlRate.1.gameStatsString, score.wdlRate.2.gameStatsString]
            .joined(separator: " / ")
    }

    var wdlRatioString: String {
        let value = [score.win, score.draw, score.loss]
        return String(format: "%.2f", value.reduce(0.0, +) / Float(value.count))
    }

    private let storeKey: String = "GameStatistics"
    private let store = UserDefaults.standard
    
    enum ScoreType {
        case win, draw, loss
    }
    
    struct Score: Codable, Hashable {
        var win: Float = 0, draw: Float = 0, loss: Float = 0
        var encoded: Data? { try? PropertyListEncoder().encode(self) }
        
        var wdlRate: (Float, Float, Float) {
            let total = win + draw + loss
            return total > 0 ? (win/total, draw/total, loss/total) : (0,0,0)
        }
        
        mutating func reset() {
            win = 0
            draw = 0
            loss = 0
        }
        
        func decoded(from data: Data) -> Score? {
            return try? PropertyListDecoder().decode(Score.self, from: data)
        }
    }
    
    /// Initiaize
    /// - Parameter storeKey: Key for the UserDefaults save and load function.
    init() {
        if let stats = store.object(forKey: storeKey) as? Data,
           let decoded = score.decoded(from: stats) {
            score = decoded
        }
    }
    
    init(score: Score) {
        self.score = score
    }
    
    func set(for type: ScoreType){
        set(value: 1, for: type)
    }
    
    func set(value: Int, for type: ScoreType) {
        switch type {
        case .win:
            score.win += 1
            
        case .draw:
            score.draw += 1
            
        case .loss:
            score.loss += 1
        }
        
        save()
    }
    
    func reset() {
        score.reset()
        save()
    }
    
    private func save() {
        if let encoded = score.encoded {
            store.set(encoded, forKey: storeKey)
        }
    }
}

extension Float {
    var gameStatsString: String {
        return self > 0 ? String(format: "%.2f", self) : "0"
    }
}
