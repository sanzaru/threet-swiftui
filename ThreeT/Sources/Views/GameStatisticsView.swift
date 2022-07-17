//
//  GameStatisticsView.swift
//  ThreeT
//
//  Created by Martin Albrecht on 22.02.22.
//  Copyright © 2022 Martin Albrecht. All rights reserved.
//

import SwiftUI

struct GameStatisticsView: View {
    @EnvironmentObject var gameStats: GameStatisticsData
    
    @State private var showResetAlert = false
        
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 30) {
                    HStack {
                        ScoreDataRow(label: Text("labelStatsWins"), score: gameStats.score.win)
                        ScoreDataRow(label: Text("labelStatsDraws"), score: gameStats.score.draw)
                        ScoreDataRow(label: Text("labelStatsLosses"), score: gameStats.score.loss)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("labelStatsOverviewTitle")
                            .font(.headline)

                        HStack {
                            Text("labelStatsWdlRatesLabel")
                            Spacer()
                            Text(gameStats.wdlRateString)
                        }

                        HStack {
                            Text("labelStatsWdlRatioLabel")
                            Spacer()
                            Text(gameStats.wdlRatioString)
                        }
                    }
                }
            }

            Spacer()
            
            Button("labelResetStats") { showResetAlert = true }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.red)
                .actionSheet(isPresented: $showResetAlert) {
                    ActionSheet(
                        title: Text("labelResetStats"),
                        message: Text("labelAlertMessage"),
                        buttons: [
                            .destructive(Text("labelReset"), action: { gameStats.reset() }),
                            .cancel(Text("labelCancel"))
                        ]
                    )
                }
        }
        .padding()
    }
}

extension GameStatisticsView {
    struct ScoreDataRow: View {
        private let label: Text
        private let score: Float
        private let icon: String?
        
        init(label: Text, score: Float, icon: String? = nil) {
            self.label = label
            self.score = score
            self.icon = icon
        }
            
        var body: some View {
            VStack(spacing: 10) {
                if let icon = icon {
                    Text(icon)
                        .font(.system(size: 60))
                }
                
                label
                    .bold()
                    .lineLimit(1)                    
                
                Text(String(Int(score)))
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
            .font(.callout)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.darkBlue)
            )
        }
    }
}

struct GameStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameStatisticsView()
                .environmentObject(
                    GameStatisticsData(
                        //score: .init(win: 20, draw: 5, loss: 2)
                        score: .init(win: 0, draw: 0, loss: 0)
                    )
                )
                .navigationBarTitle("labelStatsTitle", displayMode: .automatic)
        }

        NavigationView {
            GameStatisticsView()
                .environmentObject(
                    GameStatisticsData(score: .init(win: 20, draw: 5, loss: 2))
                )
                .navigationBarTitle("labelStatsTitle", displayMode: .automatic)
        }
        .environment(\.locale, .init(identifier: "de"))
    }
}
