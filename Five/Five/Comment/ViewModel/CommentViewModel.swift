//
//  CommentViewModel.swift
//  Five
//
//  Created by Seungyeon Kim on 12/21/23.
//

import Foundation
import RxSwift
import RxCocoa

class CommentViewModel {
        
    let disposeBag = DisposeBag()
    
    func fetchDeleteComment(postId: String, commentId: String, completion: @escaping (Result<DeleteCommentResponse, FiveError>) -> Void)  {
        
        APIManager.shared.deleteComment(postId: postId, commentId: commentId)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("deleteComment failed",error.rawValue)
                    print(error.errorDescription!)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
