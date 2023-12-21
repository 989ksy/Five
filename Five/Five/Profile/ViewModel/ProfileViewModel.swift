//
//  ProfileViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    var profileData : MyProfileResponse = MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")
    
    let readData = BehaviorSubject<[ReadData]>(value: [])
    
    var data : [ReadData] = [ReadData(likes: [], image: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "")]
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let addContentTapp : ControlEvent<Void>
        let refresh: PublishSubject<Void> //갱신
        let prefetchItem: ControlEvent<[IndexPath]>
    }
    
    struct Output {
        let profileItems: BehaviorSubject<[ReadData]>
        let items: [ReadData]
    }
    
    
    func readData(completion: @escaping (Result<readUserPostResponse, FiveError>) -> Void)
    {
        APIManager.shared.readUserPost(id: KeychainStorage.shared.userID!, next: "", limit: "12", productId: "Five_Feed")
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let data) :
                completion(.success(data))
                    print("*** readUserPostResponse in VM", data)
                    
                case .failure(let error) :
                    print("readUserPostResponse failed",error.rawValue)
                    print(error.errorDescription!)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    func fetchData(completion: @escaping (Result<MyProfileResponse, FiveError>) -> Void) {
        APIManager.shared.myProfile()
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let data) :
                completion(.success(data))
                    
                case .failure(let error) :
                    print("myProfile failed",error.rawValue)
                    print(error.errorDescription!)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
    func transform(input: Input) -> Output {
        
        //페이지네이션
        let nextCursor = BehaviorSubject<String>(value: "")
        var nextCursorItem = ""
        
        //프리페칭
        input.prefetchItem
            .subscribe(with: self) { owner , value in
                
                let itemCount = self.data.count /*try!*/ /*self.readData.value().count*/
                
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
                    
                    var itemArray = try! self.readData.value() //원래 배열
                    itemArray.append(contentsOf: success.data )
                    self.readData.onNext(itemArray)
                    self.data.append(contentsOf: itemArray)
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
//                    print("===최초 Profile",response)
                    self.readData.onNext(response.data)
                    self.data.append(contentsOf: response.data)
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(profileItems: readData, items: data)
    }

    
}
