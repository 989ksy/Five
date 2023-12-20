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
    
    let disposeBag = DisposeBag()
    
    
    struct Input {
        let addContentTapp : ControlEvent<Void>
        let refresh: PublishSubject<Void> //갱신
    }
    
    struct Output {}
    
    
    func fetchData(Completion: @escaping (Result<MyProfileResponse, FiveError>) -> Void) {
        APIManager.shared.myProfile()
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let data) :
                Completion(.success(data))
                    
                case .failure(let error) :
                    print("myProfile failed",error.rawValue)
                    print(error.errorDescription!)
                }
            }
            .disposed(by: disposeBag)
    }

    
}
