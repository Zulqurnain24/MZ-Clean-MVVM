//
//  CustomFont.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import UIKit


struct FontSize {
    private enum Keys {
        static let fontPoint = "fontPoint"
    }
    
    static var fontPoint: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.fontPoint)
            UserDefaults.standard.synchronize()
        }
        
        get {
            return UserDefaults.standard.integer(forKey: Keys.fontPoint)
        }
    }
}


enum Font: String {
    case `default` = "Kalpurush"
    case droidSans = "DroidSans"
    var str: String { return rawValue }
    private enum Keys {
        static let selectedFont = "SelectedFont"
    }
    
    static var selectedFont: Font {
        guard let storedFontName = UserDefaults.standard.string(forKey: Keys.selectedFont) else { return .default }
        return Font(rawValue: storedFontName) ?? .default
    }
    
    static let allValues: [Font] = [.default, .droidSans]
    func save() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedFont)
        UserDefaults.standard.synchronize()
    }
}
