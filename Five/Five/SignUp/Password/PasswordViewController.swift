//
//  PasswordViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol PasswordViewControllerAttributed {
    func bind()
    func setNavigation()
}

final class PasswordViewController : BaseViewController {
    
    var emailInputText : String?
    
    private let mainView = PasswordView()
    private let viewModel = PasswordViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        bind()
        setNavigation()
        
        //dummy
        mainView.passwordTextfield.text = "#gokiaV11"
    }
    
    override func configureView() {}
    override func setConstraints() {}
    
    //MARK: - bind
    
    
    func bind() {
        
        let input = PasswordViewModel.Input(originText: self.mainView.passwordTextfield.rx.text.orEmpty, checkText: self.mainView.checkPasswordTextfield.rx.text.orEmpty, tap: self.mainView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        // 체크 안내 레이블
        viewModel.firstGuideText
            .bind(to: mainView.firstDirectionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.secondGuideText
            .bind(to: mainView.secondDirectionLabel.rx.text)
            .disposed(by: disposeBag)
        
        //입력값 체크
        
        input.originText
            .map { $0.range(of: self.viewModel.passwordRegex, options: .regularExpression) != nil}
            .subscribe(with: self) { owner, value in
                owner.mainView.firstDirectionLabel.textColor = value ? CustomColor.pointColor : .lightGray
            }
            .disposed(by: disposeBag)
        
        output.validation
        .subscribe(with: self) { owner, value in
            owner.mainView.secondDirectionLabel.textColor = value ? CustomColor.pointColor : .lightGray
            owner.mainView.nextButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
        }
        .disposed(by: disposeBag)
        
        //버튼
        output.validation
            .bind(to: mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.tap
            .subscribe(with: self, onNext: { owner, _ in
                
                let vc = NicknameViewController()
                vc.emailInputText = self.emailInputText
                guard let passwordInputText = owner.mainView.checkPasswordTextfield.text
                else { return }
                vc.passwordInputText = passwordInputText
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                print("password NextBtn tap")
            })
            .disposed(by: disposeBag)

            
    }
    
    //MARK: - NavigationController Setting
    
    func setNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    
}

