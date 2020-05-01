//
//  ErrorView.swift
//  ThreeT
//
//  Created by Martin Albrecht on 01.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
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
