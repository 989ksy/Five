//
//  EmailViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

final class EmailViewModel {
    
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let emailText : ControlProperty<String>
        let emailValidationTap : ControlEvent<Void>
        let nextTap : ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation : Observable<Bool>
        let isSucceeded : PublishSubject<Bool>
        let directionText : BehaviorRelay<String>
    }
    
    func transform (input: Input) -> Output {
        
        //이메일 정규식 확인
        let emailTypeValidation = input.emailText
            .map{ $0.range(of: self.emailRegex, options: .regularExpression) != nil}
        
        let isSucceeded = PublishSubject<Bool>()
        let directionText = BehaviorRelay(value: "@을 포함한 이메일 주소를 입력해주세요.")
        
        //네트워크 통신
        input.emailValidationTap
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
                switch result {
                case .success(let response):
                    print(response.message)
                    isSucceeded.onNext(true)
                    directionText.accept(response.message)
                case .failure(let failure):
                    print(failure.localizedDescription)
                    isSucceeded.onNext(false)
                    directionText.accept(failure.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
        
        // 정규식 + 네트워크 true일 때
        let nextValidation = Observable.combineLatest (emailTypeValidation, isSucceeded)
            .map { email, success in
                return email && success
            } //zip..!!!
        
        // nextValidation 디버깅
        nextValidation
            .subscribe(with: self) { owner, isValid in
                print("Next Validation:", isValid)
            }
            .disposed(by: disposeBag)
        
        return Output (emailValidation: nextValidation, isSucceeded: isSucceeded, directionText: directionText)
    }
    
    
}
