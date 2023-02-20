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

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "GlobalJackpot")
    
    init() {
        container.loadPersistentStores {
            description, error in if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

