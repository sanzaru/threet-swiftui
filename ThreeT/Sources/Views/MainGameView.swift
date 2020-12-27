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
    @ObservedObject var game: Game = Game(mode: nil)
    
    @State private var showEndConfirm: Bool = false
    @State private var showSettings: Bool = false
    
    private var nextPlayerLabel: String {
        if game.state == .running {
            if game.mode == .single {
                return game.nextPlayer == .player1 ? "labelYourTurn" : "labelEnemyTurn"
            } else {
                return String(format: "labelCurrentPlayer".localizedFormat(), arguments: game.nextPlayer == .player1 ? [1] : [2])
            }
        }
        
        return GameGlobals.appTitle
    }
    
    var body: some View {
        ZStack {
            // Game board
            VStack {
                Spacer()
                GameBoardView(game: game)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .opacity(game.state == .running ? 1 : 0.6)
                Spacer()
            }
                
            .overlay(
                ZStack {
                    if game.state == .running {
                        Text(nextPlayerLabel.localizedFormat())
                            .foregroundColor(.darkBlue)
                            .font(.custom(GameGlobals.gameFont, size: GameGlobals.fontSize.medium.rawValue))
                            .bold()
                            .padding()
                    }
                    
                    ErrorView(message: game.error ?? "")
                        .opacity(game.error != nil ? 1 : 0)
                }
                
                ,alignment: .top
            )
                
            .overlay(
                Button(action: { showEndConfirm.toggle() }) {
                    Text("labelEndGame")
                        .gameFont(color: .gameRed)
                        .alert(isPresented: $showEndConfirm) {
                            Alert(title: Text("labelExitConfirm"), primaryButton: .destructive(Text("Okay")) {
                                game.reset()
                            }, secondaryButton: .cancel())
                        }
                        .padding()
                        .opacity(game.state == .running ? 1 : 0)
                        .animation(.spring())
                }
                .buttonStyle(PlainButtonStyle())
                
                ,alignment: .bottom
            )
            
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
                        .font(.custom(GameGlobals.gameFont, size: GameGlobals.fontSize.large.rawValue))
                        .bold()
                        .padding([.horizontal, .bottom])
                        .shadow(color: Color.gameRed.opacity(0.3), radius: 2, x: 5, y: 5)
                        .rotationEffect(Angle(degrees: -6))
                    
                    StartscreenView(game: game)
                }
            }
            
            // End game menu
            if game.state == .end {
                EndscreenView(game: game)
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
