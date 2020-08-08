//
//  SettingsView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        VStack {
            Toggle(isOn: self.$settings.soundEnabled, label: {Text("Sound")})
                .padding()
            
            Spacer()
            
            Text(GameGlobals.getVersionString())
                .padding()
        }
        .navigationBarTitle("Settings", displayMode: .automatic)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameSettings())
    }
}
