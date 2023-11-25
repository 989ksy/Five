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
    
    func signuUp(email: String, password: String, nick: String) -> Single<Result<SignupResponse, FiveError>> {
        
        let data = Signup(email: email, password: password, nick: nick)
        
        return Single.create { single in
            self.provider.request(.signUp(model: data)) { result in
                switch result {
                case .success(let response):
                    print("===APIMAnager, StatusCode === \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(SignupResponse.self, from: response.data)
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

    
    //MARK: - 이메일 중복확인
    
    func emailValidation(email: String) -> Single<Result< CheckEmailResponse, FiveError>> {
        
        let data = CheckEmail(email: email)
    
        return Single.create { single in
            
            self.provider.request(.emailValidation(model: data)) { result in
                                
                switch result {
                    
                case .success(let response):
                    print("=== APIManager, StatusCode === \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(CheckEmailResponse.self, from: response.data)
                        single(.success(.success(data)))
                        
//                        let statusCode = response.statusCode
                        
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

