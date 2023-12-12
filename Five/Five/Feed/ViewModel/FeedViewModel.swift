//
//  FeedViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

class FeedViewModel {
    
    let disposeBag = DisposeBag()

    struct Input {
        
        //버튼
        let addContentButtonTap : ControlEvent<Void> //글작성버튼
        let refresh: PublishSubject<Void>
    }
    
    struct Output {
        
        let items: PublishSubject<[ReadData]>
        let nextCursor: BehaviorSubject<String>
        
    }
    
    func transform (input: Input) -> Output {
        
        let FeedData = PublishSubject<[ReadData]>()
        
        var nextCursor = BehaviorSubject(value: "")
        let value = nextCursor.map{ $0 }
                
        
        input.refresh
            .flatMap {
                APIManager.shared.readPost(next: "", limit: "", productId: "Five_Feed")
            }
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===feedVC",response)
                    FeedData.onNext(response.data)
                    nextCursor.onNext(response.nextCursor)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        //네트워크 통신
        APIManager.shared.readPost(next: "", limit: "", productId: "Five_Feed")
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===feedVC",response)
                    FeedData.onNext(response.data)
                    nextCursor.onNext(response.nextCursor)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(items: FeedData, nextCursor: nextCursor)
    }
    
    
}

