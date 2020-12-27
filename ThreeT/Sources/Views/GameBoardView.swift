//
//  GameBoardView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI
import AVFoundation

struct GameBoardView: View {
    @EnvironmentObject var settings: GameSettings
    @ObservedObject var game: Game
    
    @State private var showNotification: Bool = false
    @State private var timer: Timer?
    @State private var dropSound: AVAudioPlayer?
    
    private let notificationTimeout: TimeInterval = 3
    private let containerSpacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(spacing: containerSpacing) {
                    ForEach(0..<3, id: \.self) {rowIndex in
                        HStack(spacing: containerSpacing) {
                            ForEach(0...2, id: \.self) {colIndex in
                                GameCellView(
                                    cell: game.cells[game.calculateIndex(row: rowIndex, col: colIndex)],
                                    action: {
                                        if game.state != .thinking && game.setCellValue(row: rowIndex, col: colIndex) {
                                            if settings.soundEnabled {
                                                dropSound?.play()
                                            }
                                            game.next()
                                        }
                                        
                                        setNotificationTimer()
                                    }
                                )
                                .accessibility(identifier: "gamecell-\(rowIndex)-\(colIndex)")
                                .frame(
                                    width: cellSize(geometry: geometry),
                                    height: cellSize(geometry: geometry)
                                )
                                .animation(.linear)
                            }
                        }
                    }
                }
                .onAppear(perform: setup)
                .onReceive(game.onGameStart) {
                    showNotification = false
                    resetNotification()
                }
                
                /*if game.mode == .multi {
                    Text("You may pass the device to your friend, now")
                        .font(.body)
                        .foregroundColor(Color.green)
                        .padding()
                        .opacity(showNotification && game.state == .running ? 1 : 0)
                        .animation(.easeInOut)
                }*/
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func setup() {
        if dropSound == nil {
            if let path = Bundle.main.path(forResource: "Sounds/Drop.m4a", ofType: nil) {
                do {
                    dropSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                } catch {
                    dump(error)
                }
            }
        }
    }
    
    private func cellSize(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width > geometry.size.height ? (geometry.size.height / 3) - 30 : (geometry.size.width / 3) - 30
    }
    
    private func resetNotification() {
        showNotification = false
        
        if timer != nil {
            timer!.invalidate()
        }
    }
    
    private func setNotificationTimer() {
        resetNotification()
        
        if game.mode == .multi  {
            timer = Timer.scheduledTimer(withTimeInterval: notificationTimeout, repeats: false ) { _ in
                showNotification = game.state == .running
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(game: Game(mode: .single).start())
    }
}
