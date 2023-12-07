//
//  PasswordViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PasswordViewModel {
    
    let firstGuideText = BehaviorRelay(value: "✓ 영문 및 숫자 8-20자 이내")
    let secondGuideText = BehaviorRelay(value: "✓ 비밀번호 일치")
    let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
    
    struct Input {
        
        let originText : ControlProperty<String>
        let checkText : ControlProperty<String>
        let tap : ControlEvent<Void>
    }
    
    struct Output {
        let tap : ControlEvent<Void>
        let validation : Observable<Bool>
    }
    
    func transform (input: Input) -> Output {
        
        let validation = Observable.combineLatest(input.originText, input.checkText) { origin, check in
            return origin == check && !origin.isEmpty && !check.isEmpty
        }
        return Output(tap: input.tap, validation: validation)
    }
    
    
}

