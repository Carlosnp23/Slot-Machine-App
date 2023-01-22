//
//  ContentView.swift
//  Slot Machine App
//
//  Created by Carlos Norambuena on 2023-01-22.
//

import SwiftUI

struct ContentView: View {
    
    private var symbols = ["Clubs", "Spades", "Hearts"]
    private var betAmount = 5
    @State private var numbers = [2, 1, 0]
    @State private var credits = 500
    
    var body: some View {
        ZStack {
           
            // Background
            Rectangle().foregroundColor(Color(red:160/255, green: 160/255, blue: 160/255))
                .edgesIgnoringSafeArea(.all)
    
            
            VStack {
                               
                Spacer()
                
                // Title
                HStack {
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.cyan)
                    
                    Text("Slot Machine App")
                        .fontWeight(.bold)
                    
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.cyan)
                }.scaleEffect(1.5)
                
                
                Spacer()
                
                // Credit Counter
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                
                Spacer()
                
                // Cards
                HStack {
                    
                    Spacer()

                    Image(symbols[numbers[0]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[1]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[2]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                // Button
                Button(action: {
                    
                    // Change the images
                    self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)

                    // Check winnings
                    
                    
                }) {
                    Text("Spin")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(50)
                }
                
                Spacer()
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
