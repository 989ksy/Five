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

final class LoginViewModel {
    
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
    
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let email : ControlProperty<String>
        let password : ControlProperty<String>
        
        let loginTap : ControlEvent<Void>
        let joinTap : ControlEvent<Void>
        
        let eyeTap : ControlEvent<Void>
        
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
        
        let value = Observable.combineLatest(input.email, input.password)
            .map { user in
                return user
            } //$0가능
        
        input.loginTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(value)
            .flatMap { user in
                APIManager.shared.login(email: user.0, password: user.1)
            }
            .subscribe(with: self) { owner, result in
                
//                print("============\(result)")
                                
                switch result {
                case .success(let response):
                    
                    print("==*LoginVM*== response", response)
                    
                    isSucceeded.onNext(true)
                    KeychainStorage.shared.userToken = response.token
                    
                    print("==*LoginVM*==Token: 토큰이 성공적으로 저장되었습니다. == ")
                    
                    KeychainStorage.shared.userRefreshToken = response.refreshToken
                    
                    print("==*LoginVM*==RefreshToken: 갱신토큰이 성공적으로 저장되었습니다.")
                    
                    KeychainStorage.shared.userID = response.id
                    print("==*LoginVM*==UserID: userId가 성공적으로 저장되었습니다.")
                    
                case .failure(let failure):
                    isSucceeded.onNext(false)
                    print("==*LoginVM*===login failure: \(failure.errorDescription ?? "APIManager error")")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(validation: validation, isSucceeded: isSucceeded)
    }
    
    
}

