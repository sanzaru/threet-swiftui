//
//  ErrorView.swift
//  This source file is part of the ThreeT project
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//  Licensed under Apache License v2.0
//

import SwiftUI

struct ErrorView: View {
    @State var message = ""
    
    var body: some View {
        HStack {
            Text("Error: \(message)")
                .font(.body)
                .bold()
            
            Spacer()
        }
        .padding()
        .foregroundColor(Color.white)
        .background(Color.red)        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Some debug error message!")
    }
}
