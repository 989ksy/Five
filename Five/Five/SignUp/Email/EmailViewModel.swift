//
//  EmailViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmailViewModel {
    
    let directionText = BehaviorRelay(value: "@을 포함한 이메일 주소를 입력해주세요.")
    
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    
    struct Input {
        let emailText : ControlProperty<String>
        let tap : ControlEvent<Void>
    }
    
    struct Output {
        let tap : ControlEvent<Void>
        let responseText : BehaviorRelay<String>
        let validation : Observable<Bool>
    }
    
    func transform (input: Input) -> Output {
        
        let validation = input.emailText
            .map{ $0.range(of: self.emailRegex, options: .regularExpression) != nil}
        
        let message = BehaviorRelay(value: String())
        
//        input.tap
//            .withLatestFrom()
//            .flatMap(<#T##selector: (_) throws -> ObservableConvertibleType##(_) throws -> ObservableConvertibleType#>)
//            .subscribe(<#T##observer: ObserverType##ObserverType#>) // bool
        
        
        return Output (tap: input.tap, responseText: message, validation: validation)
    }
    
    
}
