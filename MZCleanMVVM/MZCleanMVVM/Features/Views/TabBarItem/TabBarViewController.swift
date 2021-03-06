//
//  TabBarViewController.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//
import UIKit

enum TabBarItems: String {
    case NowShowing
    case TopMovie
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var storyBoard: UIStoryboard?
    var arrayVc: [UIViewController]?
    var itemController: TabBarItemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        arrayVc = []
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .NowShowing))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .TopMovie))
        viewControllers = arrayVc
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

private extension TabBarController{
    
    func setViewControllerForTabBarItem(itemType: TabBarItems)-> UIViewController {
        itemController =  TabBarItemController(itemType: itemType)
        itemController.controller.tabBarItem = UITabBarItem(title: itemType.rawValue, image: UIImage(named: itemController.imageDisabled )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:itemController.imageEnbled))
        let viewController = UINavigationController(rootViewController: itemController.controller)
        return viewController
    }
}

