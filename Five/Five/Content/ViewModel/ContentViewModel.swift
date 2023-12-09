//
//  ContentViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/30/23.
//

import Foundation
import RxSwift
import RxCocoa

class ContentViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let uploadTap : ControlEvent<Void>
        let textContent : ControlProperty<String>
        let images : Observable<[Data]>
        
    }
    
    struct Output {
        let isSucceeded : Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let isSucceeded = PublishSubject<Bool>()
        
        let text = input.textContent
            .map { text -> String in
            return String(text)
            }
        
        let value = Observable.combineLatest (
            input.images,
            text
        )
        
        input.uploadTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(value, resultSelector: { _, value in
                return value
            })
            .map { value in
                let datas = value.0
                let text = value.1
                
                return (images: datas, text: text)
            }
            .flatMap {
                APIManager.shared.createPost(
                    content: $0.text,
                    file: $0.images,
                    productID: "Five_Feed"
                )
            }
            .subscribe(with: self) { owner, result in
                print("+++contentViewModel", result)
                
                switch result {
                case .success(let response):
                    print("==Content 네트워크 성공: \(response)")
                    isSucceeded.onNext(true)
                case .failure(let failure):
                    print("==Content 네트워크 실패: \(failure)")
                    isSucceeded.onNext(false)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(isSucceeded: isSucceeded)
    }
    
    
}

