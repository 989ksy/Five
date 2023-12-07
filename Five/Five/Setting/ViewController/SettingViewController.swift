//
//  SettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit

final class SettingViewController : BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(savedButtonTapped))
    }
    
    @objc func savedButtonTapped() {
        
    }
    
}
