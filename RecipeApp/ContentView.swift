//
//  ContentView.swift
//  RecipeApp
//
//  Created by Alanoud Alamrani on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink{
                    page2()
                }label:{
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundColor(Color(hex: "#FB6112"))
                        .padding(.leading,310.0)
                    
                }
                Text("Food Recipes")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading,-155.0)
                
                
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .frame(width: 330, height: 300)
                    .foregroundColor(Color(hex: "#FB6112"))
                    .padding(.top,100)
                
                Text("There’s no recipe yet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(12)
                Text("Please add your recipes")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .padding(.bottom,124)
                
            }
            .padding()
           
        }
    }
}
// Helper to convert hex string to Color
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip the '#'
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ContentView()
}
