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
        
        delegate = self
        
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
        
//        let secondVC = UINavigationController(rootViewController: TestViewController())
//        secondVC.tabBarItem.selectedImage = UIImage(named: "hash.Custom")
//        secondVC.tabBarItem.image = UIImage(named: "hash.Custom")
//        secondVC.tabBarItem.title = "test"
        
        let thirdVC = UINavigationController(rootViewController: ProfileViewController())
        thirdVC.tabBarItem.selectedImage = UIImage(named: "personal")
        thirdVC.tabBarItem.image = UIImage(named: "personal")
        thirdVC.tabBarItem.title = "My"

        viewControllers = [firstVC, thirdVC]
        
    }

}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        if let vc = tabBarController.viewControllers?.last {
            vc.navigationController?.isNavigationBarHidden = true
        }
        
        return true
    }
}
