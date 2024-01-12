//
//  ProfileViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    //내 프로필 조회
    var myProfileData : MyProfileResponse = MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")
    
    var userProfileData: UserProfileResponse = UserProfileResponse(posts: [], followers: [], following: [], id: "", nick: "")
    
    //내 게시글 조회
    var readMyData: [ReadData] = [ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: "")]
    
    //유저 게시글 조회
    var readUserData: [ReadData] = [ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: "")]
    
    //프로파일VC -> 포스트VC 값전달 때 사용
    var userData = BehaviorRelay(value: ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: ""))
    
    let readDataForMe = BehaviorSubject<[ReadData]>(value: [])
    let readDataForOther = BehaviorSubject<[ReadData]>(value: [])
    
    var currentSegment: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var userId: String? //FeedVC 에서 받아온 값
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let addContentTapp : ControlEvent<Void>
        let refresh: PublishSubject<Void> //갱신
        let prefetchItem: ControlEvent<[IndexPath]>
    }
    
    struct Output {
        let profileItems: BehaviorSubject<[ReadData]>
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
    
    func readDataForUser(userID: String, completion: @escaping (Result<readUserPostResponse, FiveError>) -> Void)
    {
        APIManager.shared.readUserPost(id: userID, next: "", limit: "12", productId: "Five_Feed")
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
    
    //내 프로필 조회
    func fetchMyProfileData(completion: @escaping (Result<MyProfileResponse, FiveError>) -> Void) {
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
    
    //유저 프로필조회
    func fetchUserProfileData(userID:String, completion: @escaping (Result<UserProfileResponse, FiveError>) -> Void) {
        
        APIManager.shared.userProfile(id: userID)
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let data) :
                completion(.success(data))
                    
                case .failure(let error) :
                    print("UserProfile failed",error.rawValue)
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
                
                let itemCount = self.readMyData.count
                
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
                    
                    var itemArray = try! self.readDataForMe.value() //원래 배열
                    itemArray.append(contentsOf: success.data )
                    self.readDataForMe.onNext(itemArray)
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
                    self.readDataForMe.onNext(response.data)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
            .disposed(by: disposeBag)
        
        //다른 유저의 게시글 조회
        
        if let userId = userId {
            APIManager.shared.readUserPost(id: userId, next: "", limit: "12", productId: "Five_Feed")
                .subscribe(with: self) { owner, value in
                    switch value {
                    case .success(let response):
                        self.readDataForOther.onNext(response.data)
                        
                    case .failure(let error):
                        print("\(error)")
                    }
                }
                .disposed(by: disposeBag)
        }

        
        return Output(profileItems: readDataForMe)
    }

    
}
