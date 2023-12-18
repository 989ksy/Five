//
//  SettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit
import RxCocoa
import RxSwift

final class SettingViewController : BaseViewController {
    
    let mainView = SettingView()
    
    var transitedData = BehaviorRelay(value: [MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")])
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        self.hideKeyboardWhenTappedAround()
        setting()
    }
    
    
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(savedButtonTapped))
    }
    
    func setting() {
        mainView.nicknameTextField.text = transitedData.value.first?.nick
    }
    
    @objc func savedButtonTapped() {
        
    }
    
}
