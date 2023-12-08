//
//  CustomTabBarController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/29/23.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.shadowColor = .clear
        appearance.backgroundColor = CustomColor.backgroundColor
        tabBarItem.standardAppearance = appearance
        
        tabBarItem.scrollEdgeAppearance = tabBarItem.standardAppearance
        
        
    //기본 컬러세팅
        
        self.tabBar.tintColor = CustomColor.pointColor
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .systemGray6
        
    //아이콘 설정
        let firstVC = UINavigationController(rootViewController: FeedViewController())
        firstVC.tabBarItem.selectedImage = UIImage(named: "home")
        firstVC.tabBarItem.title = "Five"
        firstVC.tabBarItem.image = UIImage(named: "home")
        
        let secondVC = UINavigationController(rootViewController: SearchViewController())
        secondVC.tabBarItem.selectedImage = UIImage(named: "searchIcon")
        secondVC.tabBarItem.image = UIImage(named: "searchIcon")
        secondVC.tabBarItem.title = "Search"
        
        let thirdVC = UINavigationController(rootViewController: ProfileViewController())
        thirdVC.tabBarItem.selectedImage = UIImage(named: "personal")
        thirdVC.tabBarItem.image = UIImage(named: "personal")
        thirdVC.tabBarItem.title = "My"

        viewControllers = [firstVC, secondVC, thirdVC]
        
    }

}
