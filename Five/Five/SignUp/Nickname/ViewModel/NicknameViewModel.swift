//
//  NicknameViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

class NicknameViewModel {
    
    let directionText = BehaviorRelay(value: "30자 이내로 입력해주세요.")
    let disposeBag = DisposeBag()
    
    struct Input {
        let nicknameText : ControlProperty<String>
        var email : String
        var password : String
        let joinTap : ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let isSucceeded: PublishSubject<Bool>
    }
    
    func transform (input: Input) -> Output {
        
        let nicknameCountValidation = input.nicknameText
            .map { $0.count <= 30 && $0.count >= 1 }
        
        let isSucceeded = PublishSubject<Bool>()
        
        input.joinTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.nicknameText, resultSelector: {_, query in
                return query
            })
            .map { query in
                return "\(query)"
            }
            .flatMap {
                APIManager.shared.signuUp(email: input.email, password: input.password, nick: $0)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let response):
                    isSucceeded.onNext(true)
                    print("==SignUp: \(response)")
                case .failure(let failure):
                    isSucceeded.onNext(false)
                    print(failure.errorDescription ?? "error")
                }
            }
            .disposed(by: disposeBag )
        
        
        
        return Output( validation: nicknameCountValidation, isSucceeded: isSucceeded)
    }
    
    
    
}

