//
//  LoginViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol LoginViewControllerAttributed {
    func bind()
}

class LoginViewController : BaseViewController {
    
    private let mainView = LoginView()
    private let viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        let view = mainView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dummy
        mainView.emailTextField.text = "kia@g.com"
        mainView.passwordTextField.text = "#GoKiaV1"
        
        bind()
    }
    
    //MARK: - Bind
    
    func bind() {
        
        let input = LoginViewModel.Input(email: mainView.emailTextField.rx.text.orEmpty, password: mainView.passwordTextField.rx.text.orEmpty, loginTap: mainView.loginButton.rx.tap, joinTap: mainView.joinButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(to: mainView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validation
            .subscribe(with: self) { owner, value in
                owner.mainView.loginButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
            }
            .disposed(by: disposeBag)
        
        output.loginTap
            .subscribe(with: self) { owner, _ in
                let vc = FeedViewController()
                self.navigationController?.pushViewController(vc, animated: true)
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        //회원가입
        output.joinTap
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                let vc = EmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("join btn tap")
            }
            .disposed(by: disposeBag)
        
    }
    
}

