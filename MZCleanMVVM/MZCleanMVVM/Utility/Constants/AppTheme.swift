//
//  AppTheme.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import UIKit
import MessageUI

enum AppTheme: Int {
    case `default`, NightMode
    
    enum Keys {
        static let selectedTheme = "SelectedTheme"
    }
    
    static var current: AppTheme {
        return  AppPreferences.shared.keepNightMood() ? .NightMode :  .default
    }
    

    //Mark:- Main View
    var backgroundColor: UIColor {
        switch self {
        case .default :   return Color.WhiteGray
        case .NightMode:      return Color.NightRider
        }
    }

    //MARK:- text

        var mainFontColor: UIColor {
            switch self {
            case .default : return  Color.Charcoal
            case .NightMode : return Color.WhiteSmoke //0x6F6F6F
            }
        }

    var subFontColor: UIColor {
        switch self {
        case .default :   return Color.NavyBlueLight
        case .NightMode:  return Color.NavyBlue
        }
    }

    var buttonColor: UIColor {
        switch self {
        case .default:  return Color.green
        case .NightMode: return Color.lightGray
        }
    }

    
    
    func apply() {
     
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        }
}


