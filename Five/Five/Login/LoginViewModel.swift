//
//  LoginViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
    
    struct Input {
        
        let email : ControlProperty<String>
        let password : ControlProperty<String>
        let loginTap : ControlEvent<Void>
        let joinTap : ControlEvent<Void>
        
    }
    
    struct Output {
        
        let validation : Observable<Bool>
        let loginTap : ControlEvent<Void>
        let joinTap : ControlEvent<Void>
        
    }
    
    func transform(input: Input) -> Output {
        
        let validation = Observable.combineLatest(input.email, input.password) { email, password in
            
            return email.range(of: self.emailRegex, options: .regularExpression) != nil && password.range(of: self.passwordRegex, options: .regularExpression) != nil
        }
        
        return Output(validation: validation, loginTap: input.loginTap, joinTap: input.joinTap)
    }
    
    
}

