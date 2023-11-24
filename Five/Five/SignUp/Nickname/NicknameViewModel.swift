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
    
    let directionText = BehaviorRelay(value: "8자 이내의 닉네임을 입력해주세요.")
    
    struct Input {
        let nicknameText : ControlProperty<String>
        let tap : ControlEvent<Void>
    }
    
    struct Output {
        let tap : ControlEvent<Void>
        let validation: Observable<Bool>
    }
    
    func transform (input: Input) -> Output {
        let validation = input.nicknameText
            .map { $0.count <= 8 && $0.count >= 1 }
        return Output(tap: input.tap, validation: validation)
    }
    
    
    
}

