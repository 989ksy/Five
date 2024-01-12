//
//  EmailViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol EmailViewControllerAttributed {
    func bind()
}

final class EmailViewController: BaseViewController {
    
    private let mainView = EmailView()
    private let viewModel = EmailViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor

        setNavigation()
        bind()
    }
    
    override func configureView() {}
    override func setConstraints() {}
    
    //MARK: - bind
    
    func bind() {
        
        let input = EmailViewModel.Input(emailText: mainView.emailTextfield.rx.text.orEmpty, emailValidationTap: mainView.validationButton.rx.tap, nextTap: mainView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.directionText
            .asDriver()
            .drive(self.mainView.directionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emailValidation
            .bind(to: self.mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.emailValidation
            .subscribe(with: self) { owner, value in
                owner.mainView.nextButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
                owner.mainView.nextButton.isEnabled = value
                print("===emailValidation 버튼: \(value)")
                
            }
            .disposed(by: disposeBag)
          
        input.nextTap
            .subscribe(with: self) { owner, _ in
                let vc = PasswordViewController()
                guard let emailInput = owner.mainView.emailTextfield.text else {return }
                vc.emailInputText = emailInput
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    //MARK: - NavigationController Setting
    
    func setNavigation() {
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    
}

        
