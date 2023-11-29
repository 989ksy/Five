//
//  LoginViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

class LoginViewModel {
    
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
    
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let email : ControlProperty<String>
        let password : ControlProperty<String>
        
        let loginTap : ControlEvent<Void>
        let joinTap : ControlEvent<Void>
        
        var emailInput : String
        var passwordInput : String
        
    }
    
    struct Output {
        
        let validation : Observable<Bool>
        let isSucceeded : Observable<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        let validation = Observable.combineLatest(input.email, input.password) { email, password in
            
            return email.range(of: self.emailRegex, options: .regularExpression) != nil && password.range(of: self.passwordRegex, options: .regularExpression) != nil
        }
        
        let isSucceeded = PublishSubject<Bool>()
        
        input.loginTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap{
                APIManager.shared.login(email: input.emailInput, password: input.passwordInput)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let response):
                    isSucceeded.onNext(true)
                    print("==login: \(response)")
                    KeychainStorage.shared.userToken = response.token
                    print("==Token: 토큰이 성공적으로 저장되었습니다.")
                    KeychainStorage.shared.userRefreshToken = response.refreshToken
                    print("==RefreshToken: 갱신토큰이 성공적으로 저장되었습니다.")
                case .failure(let failure):
                    isSucceeded.onNext(false)
                    print("===login failure: \(failure.errorDescription ?? "APIManager error")")
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(validation: validation, isSucceeded: isSucceeded)
    }
    
    
}

