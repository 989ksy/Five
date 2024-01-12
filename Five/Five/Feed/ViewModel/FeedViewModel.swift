//
//  FeedViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedViewModel {

    let disposeBag = DisposeBag()
    
    let feedData = BehaviorSubject<[ReadData]>(value: [])
    
    
    struct Input {
        
        //버튼
        let addContentButtonTap : ControlEvent<Void> //글작성버튼
        let refresh: PublishSubject<Void> //갱신
        
        let prefetchItem: ControlEvent<[IndexPath]> //페이지네이션
    }
    
    struct Output {
        let items: BehaviorSubject<[ReadData]>
    }
    
    func transform (input: Input) -> Output {
                
        //MARK: - 페이지네이션
        
        // 페이지네이션 요소
        let nextCursor = BehaviorSubject<String>(value: "") // 지금
        var nextCursorItem = "" // 미리 커서 저장 , 페이지네이션에 사용할 값
        
        
        //프리페칭해!
        //조건: 배열의 마지막쯤이 되었을 때 = 네트워크 콜
        input.prefetchItem
            .subscribe(with: self) { owner , value in
                
                let itemCount = try! self.feedData.value().count
                
                if value.contains(where: { $0.row == itemCount - 1 }) {
                    if nextCursorItem != "0" {
                        nextCursor.onNext(nextCursorItem)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        
        // 커서값이 바뀔 때(변화가 감지 될 때) 실행
        nextCursor
            .flatMap {_ in
                APIManager.shared.readPost(next: nextCursorItem, limit: "10", productId: "Five_Feed")
            }
            .subscribe(with: self) { owner , response in

                switch response {
                case .success(let success) :
                    
                    var itemArray = try! self.feedData.value() //원래 배열
                    itemArray.append(contentsOf: success.data )
                    self.feedData.onNext(itemArray) // 원래 + 새로움 = 갈아
                    
                    nextCursorItem = success.nextCursor // 페이지네이션에 쓸 넥스트 커서를 저장해
                
                case .failure(let failure) :
                    print ("=== 커서값 변경 실패:",failure)
                }
                                         
            }
            .disposed(by: disposeBag)
                
        
        //MARK: - 게시글 갱신 (컨텐츠 작성 후)
        
        input.refresh
            .flatMap {
                APIManager.shared.readPost(next: "", limit: "10", productId: "Five_Feed")
            }
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===갱신 feedVC",response)
                    self.feedData.onNext(response.data)

                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        
        //MARK: - 게시글 조회 (최초)
        //네트워크 통신
        APIManager.shared.readPost(next: "", limit: "10", productId: "Five_Feed")
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===최초 feedVC",response)
                    self.feedData.onNext(response.data)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(items: feedData)
    }
    
    
}

