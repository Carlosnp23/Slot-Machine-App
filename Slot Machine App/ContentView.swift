//
//  ContentView.swift
//  Slot Machine App
//
//  Created by Carlos Norambuena on 2023-01-22.
//
//  File name: Slot Machine APP
//  Author's name: Carlos Norambuena Perez
//  Student ID: 301265667
//  Date: 2023-02-05
//  App Description: Assignment 1 - Slot Machine Part 1
//  Version of Xcode: Version 14.2 (14C18)

import SwiftUI

struct ContentView: View {
    
    private var symbols = ["Clubs", "Spades", "Hearts", "Jackpot"]
    @State private var betAmount = 1
    @State private var numbers = [3, 2, 1, 0]
    @State private var credits = 15
    @State private var currentJackpot = 1500
    @State private var betEntry = 1
    @State private var timesLost = 0
    @State private var spinButtonDisabled = false
    @State private var win = false
    
    var body: some View {
        
        NavigationView {
            
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
                                .font(.custom("Courier", fixedSize: 20))
                                .fontWeight(.bold)
                                .shadow(color: .gray, radius: 2, x: 0, y: 15)
                            
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
                            .background(win ? Color.green.opacity(0.5) : Color.white.opacity(0.5))
                            .scaleEffect(win ? 1.2 : 1)
                            .cornerRadius(20)
                        
                        Spacer()
                        
                        Button(action: {
                            
                            if betEntry == 1 {
                                betEntry = 3
                                betAmount = 3
                                
                            } else if betEntry == 3 {
                                betEntry = 5
                                betAmount = 5
                                
                            } else if betEntry == 5 {
                                betEntry = 10
                                betAmount = 10
                                
                            } else {
                                betEntry = 1
                                betAmount = 1
                                
                            }
                            
                            // Activate the SPIN button when you have enough credits to play.
                            if betAmount <= credits && betEntry <= credits {
                                spinButtonDisabled = false
                            } else {
                                spinButtonDisabled = true
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
                        
                    }.animation(.easeInOut(duration: 1))
                    
                    Spacer()
                    
                    // Button Spin
                    Button(action: {
                        
                        // Change the images
                        numbers[0] = Int.random(in: 0...symbols.count - 1)
                        numbers[1] = Int.random(in: 0...symbols.count - 1)
                        numbers[2] = Int.random(in: 0...symbols.count - 1)
                        numbers[3] = Int.random(in: 0...symbols.count - 1)
                        
                        // Check winnings
                        if numbers[0] == numbers[1] &&
                            numbers[1] == numbers[2] {
                            
                            // WON
                            credits += betAmount * 10
                            
                            win = true
                            
                            // Deducts the credit played
                        } else {
                            credits -= betAmount

                            // Losing x times increases the Current jackpot
                            timesLost += 1

                            if timesLost == 5 {
                                currentJackpot += currentJackpot * 1/5
                                timesLost = 0
                            }
                            
                            // Deactivate the SPIN button when you do not have enough credits to play.
                            if betAmount > credits {
                                spinButtonDisabled = true
                            }
                            
                            win = false
                            
                        }
                        
                        if numbers[3] == numbers[0] &&
                            numbers[3] == numbers[1] &&
                            numbers[3] == numbers[2] {
                            
                            // WON
                            win = true
                            credits += credits + currentJackpot
                            currentJackpot = 0
                            
                        }
                        
                    }) {
                        Text("SPIN")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.pink)
                            .cornerRadius(50)
                    }.disabled(spinButtonDisabled)
                    
                    NavigationLink(destination: Support_Help(),
                                   label: {Text("Help")})
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .padding([.leading, .trailing], 7)
                    .background(Color.cyan)
                    .cornerRadius(70)
                    
                    Spacer()
                    
                    // Button Reset & Exit
                    HStack {
                        
                        Spacer()
                        
                        // Button Reset
                        Button(action: {
                            
                            spinButtonDisabled = false
                            win = false
                            
                            credits = 15
                            numbers = [3, 3, 3]
                            currentJackpot = 1500
                            
                            betEntry = 1
                            betAmount = 1
                            
                        }) {
                            Text("RESET")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(50)
                                .animation(.easeInOut(duration: 1.5))
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
}

struct Support_Help: View {
    var body: some View {
        NavigationView {
            VStack {
                                    
                    Spacer()
                    
                    // Title
                    HStack {
                        
                        Image(systemName: "exclamationmark.shield")
                            .foregroundColor(.cyan)
                        
                        Text("Instructions")
                            .font(.title)
                            .fontWeight(.bold)
                        
                    }.scaleEffect(1.5)
                    
                    Spacer()
                    
                    VStack {
                        
                        Group {
                            
                            Text("Progressive Jackpot:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                            
                            Text(" Offer a minimum jackpot that grows as the game is played.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                            
                            Text("Credits:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text(" This is the total amount of Credits you have to play with.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                            
                            Text("Increase Bet:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text(" A feature that can help you multiply your winnings. ")
                                .font(.body)
                                .multilineTextAlignment(.center)
                            
                            Text("Bet Entry:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text("Amount of Bet to play.")
                                .font(.body)
                                .multilineTextAlignment(.center)

                            Text("Spin:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text(" This is the button that starts the fun. Press it to spin the reels and win big prizes.")
                                .font(.body)
                                .multilineTextAlignment(.center)

                        }
                        
                        Group {
                            
/*                            Text("Reset:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text("Resets the APP.")
                                .font(.body)
                                .multilineTextAlignment(.center)

                            Text("Exit:")
                                .font(.custom("Courier", fixedSize: 23))
                                .fontWeight(.bold)
                                .padding([.leading, .trailing, .top], 10)

                            Text("Closes the APP.")
                                .font(.body)
                                .multilineTextAlignment(.center)
*/
                        }
                        
                        Text("Paytable")
                            .font(.custom("Courier", fixedSize: 23))
                            .fontWeight(.bold)
                            .padding([.leading, .trailing, .top], 10)
                        
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
