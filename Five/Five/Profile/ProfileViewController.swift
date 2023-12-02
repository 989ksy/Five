//
//  ProfileViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/29/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()
    
//    private var viewControllers = [MyFiveViewController(), FivedViewController()]
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    
    func bind() {
        
        let input = ProfileViewModel.Input(settingTap: mainView.settingButton.rx.tap)
        
        mainView.settingButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let vc = SettingViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
    
}
