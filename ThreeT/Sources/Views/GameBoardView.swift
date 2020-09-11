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
            VStack {
                VStack(spacing: self.containerSpacing) {
                    ForEach(0...2, id: \.self) {rowIndex in
                        HStack(spacing: self.containerSpacing) {
                            ForEach(0...2, id: \.self) {colIndex in
                                GameCellView(
                                    cell: self.game.cells[self.game.calculateIndex(row: rowIndex, col: colIndex)]
                                )
                                .frame(
                                    width: self.cellSize(geometry: geometry),
                                    height: self.cellSize(geometry: geometry)
                                )
                                .animation(.linear)
                                .onTapGesture {
                                    if self.game.state != .thinking && self.game.setCellValue(row: rowIndex, col: colIndex) {
                                        if self.settings.soundEnabled && self.dropSound != nil {
                                            self.dropSound?.play()
                                        }
                                        self.game.next()
                                    }
                                    
                                    self.setNotificationTimer()
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: self.setup)
                .onReceive(self.game.onGameStart) {
                    self.showNotification = false
                    self.resetNotification()
                }
                
                /*if self.game.mode == .multi {
                    Text("You may pass the device to your friend, now")
                        .font(.body)
                        .foregroundColor(Color.green)
                        .padding()
                        .opacity(self.showNotification && self.game.state == .running ? 1 : 0)
                        .animation(.easeInOut)
                }*/
            }
        }
    }
    
    private func setup() {
        if dropSound == nil {
            if let path = Bundle.main.path(forResource: "Sounds/Drop.m4a", ofType:nil) {
                do {
                    self.dropSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
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
        self.resetNotification()
        
        if game.mode == .multi  {
            timer = Timer.scheduledTimer(withTimeInterval: notificationTimeout, repeats: false ) { _ in
                self.showNotification = self.game.state == .running
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(game: Game(mode: .single).start())
    }
}
