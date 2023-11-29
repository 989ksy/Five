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
    //기본 컬러세팅
        
        self.tabBar.tintColor = CustomColor.pointColor
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .systemGray6
        
    //아이콘 설정
        let firstVC = UINavigationController(rootViewController: FeedViewController())
        firstVC.tabBarItem.selectedImage = UIImage(named: "home")
//        firstVC.tabBarItem.title = ""
        firstVC.tabBarItem.image = UIImage(named: "home")
        
        let secondVC = UINavigationController(rootViewController: ProfileViewController())
        secondVC.tabBarItem.selectedImage = UIImage(named: "personal")
        secondVC.tabBarItem.image = UIImage(named: "personal")
        secondVC.tabBarItem.title = "Profile"

        viewControllers = [firstVC, secondVC]
        
    }

}
