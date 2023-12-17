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
        
        APIManager.shared.readUserPost(id: KeychainStorage.shared.userID!, next: "", limit: "10", productId: "Five_Feed")
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
