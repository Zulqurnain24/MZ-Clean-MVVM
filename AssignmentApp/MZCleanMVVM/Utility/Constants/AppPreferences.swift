//
//  AppPreferences.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//
import Foundation

class AppPreferences {
   
    enum Settings: String {
        case nightMood = "NightMood"
        var str: String { return rawValue }
    }

    let defaults = UserDefaults.standard
    
    static let shared: AppPreferences = {
        return AppPreferences()
    }()
  
    func changeNightMood() {
        let toState = !keepNightMood()
        defaults.set(toState, forKey: Settings.nightMood.str)
        defaults.synchronize()
        
    }
    
    func keepNightMood() -> Bool {
        return defaults.bool(forKey: Settings.nightMood.str)
    }
}

