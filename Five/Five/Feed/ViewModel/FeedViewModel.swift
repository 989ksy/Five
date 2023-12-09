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
    
//    func fetchData() {
//        
//        APIManager.shared.readPost(next: "", limit: "5", productId: "Five_Feed")
//            .subscribe(with: self) { owner, value in
//                switch value {
//                case .success(let response):
//                    print("===feedVC",response)
//                    
//                case .failure(let error):
//                    print("\(error)")
//                    
//                }
//            }
//            .disposed(by: disposeBag)
//    }
//    
//    
    
    struct Input {
        
        //버튼
        let addContentButtonTap : ControlEvent<Void> //글작성버튼
//        let nicknameButtonTap : ControlEvent<Void> //닉네임버튼
//        let commentButtonTap : ControlEvent<Void> //댓글버튼
//        let contentButtonTap : ControlEvent<Void> //내용버튼
        
    }
    
    struct Output {
        
//        let isSucceded : Observable<Bool>
        let items: PublishSubject<[ReadData]>
        
        
    }
    
    func transform (input: Input) -> Output {
        
        let contentData = PublishSubject<[ReadData]>()
        
        APIManager.shared.readPost(next: "", limit: "5", productId: "Five_Feed")
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===feedVC",response)
                    
                    contentData.onNext(response.data)
                
                case .failure(let error):
                    print("\(error)")
                    
                }
            }
            .disposed(by: disposeBag)
        
        
    return Output(items: contentData)
    }
    
    
}
