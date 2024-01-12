//
//  HashViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 1/12/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HashViewModel {
    
    let disposeBag = DisposeBag()
    
    
    //서버 전체 데이터 불러오기
    func fetchReadData(completion: @escaping (Result<ReadPostResponse, FiveError>) -> Void) {
        
        APIManager.shared.readPost(next: "", limit: "100", productId: "Five_Feed")
            .subscribe(with: self) { owner, response in
                
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                    print("*** fetchReadData in VM", data)
                    
                case .failure(let error):
                    print("readUserPostResponse failed",error.rawValue)
                    print(error.errorDescription!)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
