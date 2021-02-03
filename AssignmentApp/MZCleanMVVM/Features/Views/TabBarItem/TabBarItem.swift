//
//  TabBarItem.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation
import UIKit

struct TabBarItemController {
    
    let controller: UIViewController
    let imageEnbled: String
    let imageDisabled: String
    private let controllerName: String
    
    
    init(itemType: TabBarItems) {
        switch itemType {
        case .NowShowing:
            self.controllerName = Constants.TabBarItems.Movies.name
            self.controller = NowPlayingViewController()
            self.imageEnbled = Constants.TabBarItems.Movies.imageEnbled
            self.imageDisabled = Constants.TabBarItems.Movies.imageDisabled
        case .TopMovie:
            self.controllerName = Constants.TabBarItems.TvShows.name
            self.controller = TopRatedViewController()
            self.imageEnbled = Constants.TabBarItems.TvShows.imageEnbled
            self.imageDisabled = Constants.TabBarItems.TvShows.imageDisabled
        }
    }
}
