//
//  ContentView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct MainGameView: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var game: Game
    
    @State private var showEndConfirm: Bool = false
    @State private var showSettings: Bool = false
    
    private var nextPlayerLabel: String {
        if game.state == .running {
            if game.mode == .single {
                return game.nextPlayer == .player1 ? "labelYourTurn" : "labelEnemyTurn"
            } else {
                return String(
                    format: "labelCurrentPlayer".localizedFormat(),
                    arguments: game.nextPlayer == .player1 ? [1] : [2]
                )
            }
        }
        
        return GameGlobals.appTitle
    }
    
    private var viewTitle: String {
        game.state == .running ? nextPlayerLabel.localizedFormat() : " "
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
                        .padding([.horizontal, .bottom])
                        .opacity(game.state == .running ? 1 : 0)
                        .animation(.spring())
                }
                .buttonStyle(PlainButtonStyle())
            }
            .blur(radius: game.state == .empty ? 3 : 0)
            .alert(isPresented: $showEndConfirm) {
                Alert(
                    title: Text("labelExitConfirm"),
                    primaryButton: .destructive(Text("Cancel")),
                    secondaryButton: .default(Text("Okay")) { game.reset() }
                )
            }
                            
            // Settings menu and sheet
            .overlay(
                HStack {
                    Button(
                        action: { showSettings.toggle() },
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
            .sheet(
                isPresented: $showSettings,
                content: { SettingsView().environmentObject(settings) }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var langs = ["en", "de"]
    //@State static var langs = ["de"]
    
    static var previews: some View {
        ForEach(langs, id: \.self) { id in
            MainGameView()
                .environmentObject(GameSettings())
                .environment(\.locale, .init(identifier: id))
        }
    }
}
