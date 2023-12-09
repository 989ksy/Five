//
//  LoginViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginViewControllerAttributed {
    func bind()
    func loginAlertForSuccess(message: String)
    func loginAlertForFailure(message: String)
}

class LoginViewController : BaseViewController {
    
    private let mainView = LoginView()
    private let viewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        let view = mainView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    //MARK: - Bind
    
    func bind() {
        
        let input = LoginViewModel.Input(
            email: mainView.emailTextField.rx.text.orEmpty,
            password: mainView.passwordTextField.rx.text.orEmpty,
            loginTap: mainView.loginButton.rx.tap,
            joinTap: mainView.joinButton.rx.tap, eyeTap: mainView.eyeButton.rx.tap
        )
                
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(to: mainView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validation
            .subscribe(with: self) { owner, value in
                owner.mainView.loginButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
            }
            .disposed(by: disposeBag)
        
        output.isSucceeded
            .subscribe(with: self) { owner, bool in
                
                print("LoginVC == 네트워크 통신 결과: \(bool)")
                
                if bool {
                    //로그인 성공 -> 피드 화면전환
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let SceneDelegate = windowScene?.delegate as? SceneDelegate
                    
                    let vc = CustomTabBarController()
                    
                    SceneDelegate?.window?.rootViewController = vc
                    SceneDelegate?.window?.makeKeyAndVisible()
                    
                } else {
                    self.loginAlert(message: "가입되지 않은 계정입니다.\n입력 정보를 확인해주세요.") {
                    }
                }
                
            }
            .disposed(by: disposeBag)
        
        
        //회원가입
        input.joinTap
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                let vc = EmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("join btn tap")
            }
            .disposed(by: disposeBag)
        
        //비밀번호 보기
        input.eyeTap
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, _ in

                owner.mainView.passwordTextField.isSecureTextEntry.toggle()
                owner.mainView.eyeButton.isSelected.toggle()
                
                let eyeImage = owner.mainView.eyeButton.isSelected ? "EyeOn" : "EyeOff"
                owner.mainView.eyeButton.setImage(UIImage(named: eyeImage)?.withTintColor(.systemGray2), for: .normal)
                owner.mainView.eyeButton.tintColor = .clear
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK: - 얼럿
    
    func loginAlert(message: String, completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "안내", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style:.default) { _ in
            completion()
        }

        alert.addAction(ok)
        
        present(alert, animated: true)
    }

    
    
    
}

