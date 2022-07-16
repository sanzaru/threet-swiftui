//
//  SettingsView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettingsData

    @State private var showResetDialog = false
    
    var body: some View {
        VStack {
            Form {
                Section(footer: Text("labelSettingsSoundDesc")) {
                    Toggle(isOn: $settings.soundEnabled, label: { Text("labelSettingsSound") })
                }
                
                Section {
                    HStack {
                        Text("labelVersion")
                        Spacer()
                        Text(GameGlobals.versionString)
                    }
                    
                    Button(
                        action: {
                            if let url = URL(string: GameGlobals.urlInfo) {
                                UIApplication.shared.open(url)
                            }
                        },
                        label: {
                            HStack {
                                Text("labelSettingsMoreInfo")
                                Spacer()
                                Image(systemName: "globe")
                            }
                        }
                    )
                }
            }
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(GameSettingsData())
    }
}
