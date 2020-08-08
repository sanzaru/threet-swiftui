//
//  ContentView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: GameSettings
    @ObservedObject var game: Game = Game(mode: nil)
    
    @State fileprivate var showEndConfirm: Bool = false
    
    var body: some View {
        //NavigationView {
            VStack {
                ZStack {
                    VStack {
                        Spacer()
                        GameBoardView(game: game)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        Spacer()
                    }
                    .overlay(
                        ZStack {
                            //if game.state == .running {
                                Text(nextPlayerLabel().localizedFormat())
                                    .foregroundColor(game.state == .running ? .darkBlue : .red)
                                    //.font(.largeTitle)
                                    .font(.custom(GameGlobals.gameFont, size: GameGlobals.fontSize.big.rawValue))
                                    .bold()
                                    .padding()
                            //}
                            
                            ErrorView(message: self.game.error ?? "")
                                .opacity(self.game.error != nil ? 1 : 0)
                        },
                        
                        alignment: .top
                    )
                    .overlay(
                        Text("labelEndGame")
                            .gameFont(color: .red)
                            .alert(isPresented: $showEndConfirm) {
                                Alert(title: Text("labelExitConfirm"), primaryButton: .destructive(Text("Okay")) {
                                    self.game.reset()
                                }, secondaryButton: .cancel())
                            }
                            .onTapGesture(perform: { self.showEndConfirm.toggle() })
                            .padding()
                            .opacity(game.state == .running ? 1 : 0)
                            .animation(.spring()),
                        
                        alignment: .bottom
                    )
                    
                    if game.state == .empty {
                        StartscreenView(game: game)
                    }
                    
                    if game.state == .end {
                        EndscreenView(game: game)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            /*.navigationBarTitle("")
            .navigationBarItems(
                trailing:
                    HStack {
                        NavigationLink(destination: SettingsView().environmentObject(settings)) {
                            Image(systemName: "gear")
                        }
                    }
                )*/
        //}
        //.navigationViewStyle(StackNavigationViewStyle())
    }
    
    fileprivate func nextPlayerLabel() -> String {
        if game.state == .running {
            if game.mode == .single {
                return game.nextPlayer == .player1 ? "labelYourTurn" : "labelEnemyTurn"
            } else {
                return String(format: "labelCurrentPlayer".localizedFormat(), arguments: game.nextPlayer == .player1 ? [1] : [2])
            }
        }
        
        return "ThreeT"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "de"], id: \.self) { id in
            ContentView()
                .environmentObject(GameSettings())
                .environment(\.locale, .init(identifier: id))
        }
    }
}
