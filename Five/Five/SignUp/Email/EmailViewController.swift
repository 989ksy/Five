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

class EmailViewController: BaseViewController {
    
    private let mainView = EmailView()
    private let viewModel = EmailViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                        
        APIManager.shared.emailValidation(email: "test565@naver.com")
            .subscribe { event in
                switch event {
                case .success(let result) :
                    print("validatoin ok : \(result)")
                case .failure( let error):
                    print("validation fail : \(error)")
                }
            }
            .disposed(by: disposeBag)

        
        setNavigation()
        bind()
    }
    
    override func configureView() {}
    override func setConstraints() {}
    
    //MARK: - bind
    
    func bind() {
        
        let input = EmailViewModel.Input(emailText: mainView.emailTextfield.rx.text.orEmpty, tap: mainView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        viewModel.directionText
            .asDriver()
            .drive(self.mainView.directionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(to: self.mainView.nextButton.rx.isEnabled, self.mainView.directionLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validation
            .subscribe(with: self) { owner, value in
                owner.mainView.nextButton.backgroundColor = value ? CustomColor.pointColor : .lightGray
                owner.mainView.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        /*
         - 이메일 입력
         - validationCheck -> "이미 가입된 이메일입니다"
         - check되면 버튼 => 활성화 => 화면전환 & 값전달
         */
        
//        output.responseText
//            .bind(to: mainView.directionLabel.rx.text)
//            .disposed(by: disposeBag)
        
//        output.responseText
//            .subscribe(with: self) { owner, text in
//                owner.mainView.
//            }
//            .disposed(by: disposeBag)
        
//        output.responseText
//            .subscribe {
//                if $0 == "성공" {
//                    .push
//                } else {
//                    tex.text = "뭐가 안되서 안되는 겁니다"
//                }
//            }
        
        output.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.emailText, resultSelector: { _, query in
                return query
            })
            .map { query in
                return "\(query)" }
            .flatMap{
                APIManager.shared.emailValidation(email: $0)
            }
            .subscribe(with: self) { owner, result in

                
                
            }
            .disposed(by: disposeBag)
        
        
//            .bind { _ in
//
//                /// statusCode 200
//                let vc = PasswordViewController()
//                vc.email = "\(input.emailText)"
//
//                //화면전환 -> PasswordVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            .disposed(by: disposeBag)
    }
    
    
    //MARK: - NavigationController Setting
    
    func setNavigation() {
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    
}

