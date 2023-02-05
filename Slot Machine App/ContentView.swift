//
//  ContentView.swift
//  Slot Machine App
//
//  Created by Carlos Norambuena on 2023-01-22.
//
//  File name: Slot Machine APP
//  Author's name: Carlos Norambuena Perez
//  Student ID: 301265667
//  Date: 2023-01-22
//  App Description: Assignment 1 - Slot Machine Part 1
//  Version of Xcode: Version 14.2 (14C18)

import SwiftUI

struct ContentView: View {
    
    private var symbols = ["Clubs", "Spades", "Hearts"]
    private var betAmount = 3
    @State private var numbers = [2, 1, 0]
    @State private var credits = 150
    @State private var currentJackpot = 150000
    @State private var betEntry = 1

    
    var body: some View {
        ZStack {
           
            // Background
            Rectangle().foregroundColor(Color(red:160/255, green: 160/255, blue: 160/255))
                .edgesIgnoringSafeArea(.all)
    
            
            VStack {
                              
                Group {
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

                    // Current Jackpot
                    Text("Current Jackpot: " + String(currentJackpot))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(50)
                    
                    Spacer()
                }
                                                
                Group {
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

                    // Credit Counter
                    Text("Credits: " + String(credits))
                        .foregroundColor(.black)
                        .padding(.all, 10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if self.betEntry == 1 {
                            self.betEntry = 5

                        } else if self.betEntry == 5 {
                            self.betEntry = 10

                        } else if self.betEntry == 10 {
                            self.betEntry = 15

                        } else {
                            self.betEntry = 1
                            
                        }
                        
                    }) {
                        Text("Increase Bet")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.all, 5)
                            .padding([.leading, .trailing], 30)
                            .background(Color.pink)
                            .cornerRadius(50)
                    }
                    // Bet Entry
                    Text("Bet Entry: " + String(betEntry))
                    
                }

                                
                Spacer()
                
                // Button Spin
                Button(action: {
                    
                    // Change the images
                    self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)

                    // Check winnings
                    if self.numbers[0] == self.numbers[1] &&
                        self.numbers[1] == self.numbers[2] {
                        
                        // WON
                        self.credits += betAmount * 10
                        
                    } else {
                        self.credits -= betAmount
                    }
                    
                }) {
                    Text("SPIN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(50)
                }
                
                Spacer()
                    
                // Button Reset & Exit
                HStack {
                    
                    Spacer()
                    

                    // Button Reset
                    Button(action: {
                        
                    }) {
                        Text("RESET")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.pink)
                            .cornerRadius(50)
                    }
                    
                    // Button Exit
                    Button(action: {
                        exit(0)
                    }) {
                        Text("EXIT")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
