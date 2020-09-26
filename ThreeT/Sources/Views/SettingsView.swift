//
//  SettingsView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(footer: Text("labelSettingsSoundDesc")) {
                        Toggle(isOn: self.$settings.soundEnabled, label: { Text("labelSettingsSound") })
                    }
                    
                    Section {
                        HStack {
                            Text("labelVersion")
                            Spacer()
                            Text(GameGlobals.versionString())
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
            .navigationBarTitle("labelSettings", displayMode: .automatic)
            .navigationBarItems(
                trailing: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() },
                    label: { Text("labelDone") }
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameSettings())
    }
}
