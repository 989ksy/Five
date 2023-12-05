//
//  NicknameViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol NicknameViewControllerAttributed {
    func bind()
    func setNavigation()
}

final class NicknameViewController : BaseViewController{
    
    private let mainView = NicknameView()
    private let viewModel = NicknameViewModel()
    
    let disposeBag = DisposeBag()
    
    var emailInputText : String?
    var passwordInputText : String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind()
        setNavigation()
    }
    
    //MARK: - Bind
    
    func bind() {
        
        let input = NicknameViewModel.Input(nicknameText: mainView.nicknameTextfield.rx.text.orEmpty, email: emailInputText ?? "", password: passwordInputText ?? "", joinTap: mainView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        viewModel.directionText
            .bind(to: mainView.directionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(to: mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validation
            .subscribe(with: self) { owner, value in
                owner.mainView.nextButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
            }
            .disposed(by: disposeBag)
        
        input.joinTap
            .subscribe(with: self) { owner, _ in
                
                guard let nickname = owner.mainView.nicknameTextfield.text else { return }
                
                let alert = UIAlertController(title: "확인", message: "\(nickname)님, 가입을 환영합니다!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style:.default) { _ in
                    
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
                alert.addAction(ok)
                
                self.present(alert, animated: true)
                
            }
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - NavigationController Setting
    
    func setNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    
}
