//
//  ProfileSecondCellViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 12/17/23.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileSecondCellViewModel {
    
    let disposeBag = DisposeBag()
    
    let profileData = BehaviorSubject<[ReadData]>(value: [])
    
    
    struct Input {
        let prefetchItem: ControlEvent<[IndexPath]>
    }
    
    struct Output {
        let profileItems: BehaviorSubject<[ReadData]>
    }
    
    func transform(input: Input) -> Output {
        
        //페이지네이션
        let nextCursor = BehaviorSubject<String>(value: "")
        var nextCursorItem = ""
        
        //프리페칭
        input.prefetchItem
            .subscribe(with: self) { owner , value in
                
                let itemCount = try! self.profileData.value().count
                
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
                APIManager.shared.readUserPost(id: KeychainStorage.shared.userID!, next: nextCursorItem, limit: "12", productId: "Five_Feed")
            }
            .subscribe(with: self) { owner , response in

                switch response {
                case .success(let success) :
                    
                    var itemArray = try! self.profileData.value() //원래 배열
                    itemArray.append(contentsOf: success.data )
                    self.profileData.onNext(itemArray)
                    nextCursorItem = success.nextCursor
                
                case .failure(let failure) :
                    print ("=== 커서값 변경 실패:",failure)
                }
                                         
            }
            .disposed(by: disposeBag)
        
        //포스트 조회 (최초 진입 시)
        APIManager.shared.readUserPost(id: KeychainStorage.shared.userID!, next: "", limit: "12", productId: "Five_Feed")
            .subscribe(with: self) { owner, value in
                switch value {
                case .success(let response):
                    print("===최초 Profile",response)
                    self.profileData.onNext(response.data)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(profileItems: profileData)
    }
    
}
