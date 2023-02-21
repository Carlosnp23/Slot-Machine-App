//
//  ContentView.swift
//  Slot Machine App
//
//  Created by Carlos Norambuena on 2023-01-22.
//
//  File name: Slot Machine APP
//  Author's name: Carlos Norambuena Perez
//  Student ID: 301265667
//  Date: 2023-02-20
//  App Description: Assignment 1 - Slot Machine Part 1
//  Version of Xcode: Version 14.2 (14C18)

import SwiftUI
import UserNotifications

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var jackpots: FetchedResults<Jackpot>
    
    @State private var Authorization = false
    
    private var symbols = ["Clubs", "Spades", "Hearts", "Jackpot"]
    @State private var betAmount = 1
    @State private var numbers = [3, 2, 1, 0]
    @State private var credits = 150
    @State private var currentJackpot = 1500
    @State private var betEntry = 1
    @State private var timesLost = 0
    @State private var spinButtonDisabled = false
    @State private var win = false
    @State private var jackpot = false
    @State private var spin = 0
    @State private var HighScore = 0
    
    
    @State private var userName = ""
    @State private var userJackpot = ""
    @State private var userHighScore = ""
    
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
                        Text("Global Jackpot: " + String(currentJackpot))
                            .fontWeight(.bold)
                            .font(.custom("Courier", fixedSize: 19))
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .background(jackpot ? Color.yellow.opacity(0.5) : Color.black.opacity(0.5))
                            .scaleEffect(win ? 1.2 : 1)                            .cornerRadius(50)
                        
                        Spacer()
                    }.animation(.easeInOut(duration: 1))
                    
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
                            .background(win ? Color.yellow.opacity(0.5) : Color.white.opacity(0.5))
                            .scaleEffect(win ? 1.2 : 1)
                            .cornerRadius(20)
                        
                        Text("High Score:" + String(HighScore))
                            .font(.custom("Courier", fixedSize: 23))
                            .fontWeight(.bold)
                            .padding([.leading, .trailing, .top], 10)
                        
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
                        
                        //Authorization to receive notifications
                        if Authorization == false {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                                success, error in
                                if success {
                                    print("All set")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                            Authorization = true
                            
                        } else {
                            spin += spin + 1
                            
                            // Change the images
                            numbers[0] = Int.random(in: 0...symbols.count - 1)
                            numbers[1] = Int.random(in: 0...symbols.count - 1)
                            numbers[2] = Int.random(in: 0...symbols.count - 1)
                            numbers[3] = Int.random(in: 0...symbols.count - 1)
                            
                            // Check winnings
                            if numbers[0] == numbers[1] &&
                                numbers[1] == numbers[2] {
                                
                                // Probability
                                if spin >= 7 && spin < 14 {
                                    
                                    credits += betAmount * 12
                                    
                                    if HighScore <= (betAmount * 12) {
                                        HighScore = betAmount * 12
                                    }
                                    
                                    currentJackpot = currentJackpot - (betAmount * 12)
                                    
                                    spin = 0
                                    
                                } else if spin >= 14 && spin < 21 {
                                    
                                    credits += betAmount * 15
                                    
                                    if HighScore <= (betAmount * 15) {
                                        HighScore = betAmount * 15
                                    }
                                    
                                    currentJackpot = currentJackpot - (betAmount * 15)
                                    
                                    spin = 0
                                    
                                } else if spin >= 21 && spin < 35  {
                                    
                                    credits += betAmount * 17
                                    
                                    if HighScore <= (betAmount * 17) {
                                        HighScore = betAmount * 17
                                    }
                                    
                                    currentJackpot = currentJackpot - (betAmount * 17)
                                    
                                    spin = 0
                                    
                                } else if spin >= 35 && spin < 48  {
                                    
                                    credits += betAmount * 20
                                    
                                    if HighScore <= (betAmount * 20) {
                                        HighScore = betAmount * 20
                                    }
                                    
                                    currentJackpot = currentJackpot - (betAmount * 20)
                                    
                                    spin = 0
                                    
                                } else if spin >= 48 && spin < 60 {
                                    
                                    credits += betAmount * 25
                                    
                                    if HighScore <= (betAmount * 25) {
                                        HighScore = betAmount * 25
                                    }
                                    
                                    currentJackpot = currentJackpot - (betAmount * 25)
                                    
                                    spin = 0
                                    
                                } else if spin >= 61 {
                                    
                                    // Local notifications
                                    let content = UNMutableNotificationContent()
                                    content.title = " Winner Alert "
                                    content.subtitle = " You won the Global Jackpot !! "
                                    content.sound = UNNotificationSound.default
                                    
                                    let trigger = UNTimeIntervalNotificationTrigger(
                                        timeInterval: 1, repeats: false)
                                    
                                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                    UNUserNotificationCenter.current().add(request)

                                    // WON Jackpot
                                    win = true
                                    credits += credits + currentJackpot
                                    HighScore = currentJackpot

                                    userName = "Carlos"
                                    userJackpot = String(currentJackpot)
                                    userHighScore = String(HighScore)

                                    let jackpot = Jackpot(context: moc)
                                    jackpot.id = UUID()
                                    jackpot.name = userName
                                    jackpot.jackpot = userJackpot
                                                                        
                                    do {
                                        try moc.save()
                                        
                                        print(jackpot.id ?? "Unknown")
                                        print(jackpot.name ?? "Unknown")
                                        print(jackpot.jackpot ?? "Unknown")
                                        
                                    } catch {
                                        
                                    }
                                    
                                    currentJackpot = 0
                                    spin = 0
                                    
                                }
                                
                                win = true
                                
                                // Deducts the credit played
                            } else {
                                credits -= betAmount
                                if spin >= 35 { spin = 0 }
                                
                                // Losing x times increases the Current jackpot
                                timesLost += 1
                                
                                if timesLost == 10 {
                                    currentJackpot += currentJackpot * 1/5
                                    timesLost = 0
                                }
                                
                                // Deactivate the SPIN button when you do not have enough credits to play.
                                if betAmount > credits {
                                    spinButtonDisabled = true
                                }
                                
                                win = false
                                
                            }
                            
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
                    
                    
                    // Navigating to the Help screen
                    NavigationLink(destination: Support_Help()) {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                            
                            Text("Help")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 7)
                                .background(Color.cyan)
                                .cornerRadius(70)
                            
                            Image(systemName: "exclamationmark.octagon.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                            
                        }
                    }
                    
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
                            spin = 0
                            HighScore = 0
                            
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

// Help screen
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
                    
                    Image(systemName: "exclamationmark.shield")
                        .foregroundColor(.cyan)
                    
                }.scaleEffect(1.5)
                
                Spacer()
                
                VStack {
                    
                    // Game Instructions
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
                    
                    HStack {
                        
                        Image("Hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        Image("Spades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        Image("Clubs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                    
                    // Instructions for Winning
                    Text("By obtaining the 3 equal symbols, the credits played will be multiplied by 10.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Text("For example:")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing, .top], 10)
                    
                    HStack {
                        Image("Hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Image("Hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Image("Hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text("Bet Entry = 3")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    Text("Won: 3 * 12 = 36 Credits.")
                        .font(.body)
                        .multilineTextAlignment(.center)
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
