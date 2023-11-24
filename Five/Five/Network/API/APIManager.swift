//
//  APIManager.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import Moya


class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let provider = MoyaProvider<FiveAPI>()
    private let disposeBag = DisposeBag()
    
    //MARK: - 회원가입
    

    
    //MARK: - 이메일 중복확인
    
    func emailValidation(email: String) -> Single<Result< CheckEmailResponse, FiveError>> {
        
        let data = CheckEmail(email: email)
    
        return Single.create { single in
            
            self.provider.request(.emailValidation(model: data)) { result in
                
                //상태코드 체크 500번까지 성공으로 넘기기.
                
                switch result {
                    
                case .success(let response):
                    print("=== APIManager, StatusCode === \(response.statusCode)")
                    
                    guard let data = try? JSONDecoder().decode(CheckEmailResponse.self, from: response.data) else {
                        single(.success(.failure(.decodingError)))
                        return
                    }
                    
                    single(.success(.success(data)))
                    
                    do {
                        let data = try JSONDecoder().decode(CheckEmailResponse.self, from: response.data)
                        single(.success(.success(data)))
                        
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                    

                case .failure(let error):
                    
                    guard let customError = FiveError(rawValue: error.response?.statusCode ?? 1) else {
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            
            return Disposables.create()
            
        }
        
        
        
    }
    
    
    
}

