//
//  ContentView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct MainGameView: View {
    @EnvironmentObject var settings: GameSettingsData
    @EnvironmentObject var game: Game
    @EnvironmentObject var gameStats: GameStatisticsData
    
    @State private var showEndConfirm = false
    @State private var activeSheet: SheetContent?
    
    private enum SheetContent: Int, Identifiable {
        case statistics = 0, settings
        var id: Int {
            return self.rawValue
        }
    }
    
    private var nextPlayerLabel: String {
        if game.state == .running {
            if game.mode == .single {
                return game.nextPlayer == .player1 ? "labelYourTurn" : "labelEnemyTurn"
            } else {
                return String(format: "labelCurrentPlayer".localized(), game.nextPlayer == .player1 ? 1 : 2)
            }
        }
        
        return GameGlobals.appTitle
    }
    
    private var viewTitle: String {
        game.state == .running ? nextPlayerLabel.localized() : " "
    }
    
    var body: some View {
        ZStack {
            VStack {
                // Game title / error view
                ZStack {
                    Text(viewTitle)
                        .foregroundColor(.darkBlue)
                        .font(.custom(GameGlobals.gameFont, size: Text.FontSize.medium.rawValue))
                        .bold()
                        .padding([.horizontal, .top])
                    
                    if let error = game.error {
                        ErrorView(message: error)
                    }
                }
                
                // Game board
                GameBoardView(game: game)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)                    
                
                // End game button
                Button(action: { showEndConfirm.toggle() }) {
                    Text("labelEndGame")
                        .gameFont(color: .gameRed)
                        .animation(.spring())
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(game.state == .running ? 1 : 0)
                .padding([.horizontal, .bottom])
            }
            .blur(radius: game.state == .empty ? 3 : 0)
            
            // Cancel game dialog
            .alert(isPresented: $showEndConfirm) {
                Alert(
                    title: Text("labelExitConfirm"),
                    primaryButton: .default(Text("Okay")) { game.reset() },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
                            
            // Buttons for statistics and settings
            .overlay(
                HStack {
//                    Button(
//                        action: { activeSheet = .statistics },
//                        label: {
//                            Image(systemName: "chart.bar.xaxis")
//                                .font(.system(size: 25))
//                                .foregroundColor(.darkBlue)
//                        }
//                    )
                    
                    Button(
                        action: { activeSheet = .settings },
                        label: {
                            Image(systemName: "gear")
                                .font(.system(size: 25))
                                .foregroundColor(.darkBlue)
                        }
                    )
                }
                .opacity(game.state == .running || game.error != nil ? 0 : 1)
                .padding([.horizontal, .top])
                
                ,alignment: .topTrailing
            )
            
            // Game menu
            if game.state == .empty {
                VStack {
                    Text(GameGlobals.appTitle)
                        .foregroundColor(.gameRed)
                        .font(.custom(GameGlobals.gameFont, size: Text.FontSize.large.rawValue))
                        .bold()
                        .padding([.horizontal, .bottom])
                        .shadow(color: Color.gameRed.opacity(0.3), radius: 2, x: 5, y: 5)
                        .rotationEffect(Angle(degrees: -6))
                    
                    GameMenuView(game: game)
                }
            }
            
            // End game menu
            if game.state == .end {
                GameEndedView(game: game)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onReceive(game.onGameEnd, perform: setGameStatistics)
        
        // Sheet content
        .sheet(item: $activeSheet) { sheet in
            NavigationView {
                Group {
                    switch sheet {
                    case .statistics:
                        GameStatisticsView()
                            .environmentObject(gameStats)
                            .navigationBarTitle("labelStatsTitle", displayMode: .automatic)
                        
                    case .settings:
                        SettingsView()
                            .environmentObject(settings)
                            .navigationBarTitle("labelSettings", displayMode: .automatic)
                    }
                }
                .navigationBarItems(trailing: Button("labelDone".localized()) { activeSheet = nil })
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private func setGameStatistics() {
        var scoreType: GameStatisticsData.ScoreType
        
        if game.winner == nil {
            scoreType = .draw
        } else if game.winner == .player1 {
            scoreType = .win
        } else {
            scoreType = .loss
        }
        
        gameStats.set(for: scoreType)
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var langs = ["en", "de"]
    //@State static var langs = ["de"]
    
    static var previews: some View {
        ForEach(langs, id: \.self) { id in
            MainGameView()
                .environmentObject(GameSettingsData())
                .environmentObject(Game(mode: .single))
                .environmentObject(GameStatisticsData())
                .environment(\.locale, .init(identifier: id))

            MainGameView()
                .environmentObject(GameSettingsData())
                .environmentObject(Game(mode: .single))
                .environmentObject(GameStatisticsData())
                .environment(\.locale, .init(identifier: id))
                .preferredColorScheme(.dark)
        }
    }
}
