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

class NicknameViewController : BaseViewController{
    
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
        
        let input = NicknameViewModel.Input(nicknameText: mainView.nicknameTextfield.rx.text.orEmpty, tap: mainView.nextButton.rx.tap)
        
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
        
        output.tap
            .subscribe(with: self) { owner, _ in
                
                //회원가입
                
                self.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    //MARK: - NavigationController Setting
    
    func setNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    
}
