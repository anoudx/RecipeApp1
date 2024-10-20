//
//  ContentView.swift
//  RecipeApp
//
//  Created by Alanoud Alamrani on 17/04/1446 AH.
//

import SwiftUI

struct page3: View {
    var body: some View {
        VStack {
                   Text("Hello, World!")
                       .font(.title)
                       .padding()
                       .background(Color(red: 90/255, green: 200/255, blue: 250/255)) // RGBA equivalent
                       .cornerRadius(10) // Optional: for rounded corners
                       .opacity(1) // Full opacity
               }
               .padding()
           }
    }

#Preview {
    page3()
}

