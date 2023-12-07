//
//  APIManager.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import RxSwift
import Moya


final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let provider = MoyaProvider<FiveAPI>(session: Session(interceptor: AuthInterceptor.shared))
//    private let provider = MoyaProvider<FiveAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
//    var provider = MoyaProvider<MainAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

    private let disposeBag = DisposeBag()
    
    //MARK: - 포스트 등록
    
    func createPost(content: String, file: [Data], productID: String) -> Single<Result<CreatePostResponse, FiveError>> {
        
        let data = CreatePost(content: content, file: file, product_id: productID)
        
        return Single.create { single in
            self.provider.request(.createPost(model: data)) { result in
                switch result {
                case .success(let response) :
                    print("===APIManager for CreatePost, StatusCode == \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(CreatePostResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                case .failure(let error) :
                    print("=======\(error.response?.request)")
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else {
                        return
                    }
                    single(.success(.failure(customError)))
                }
                
            }
            
            return Disposables.create()
        }
        
        
    }
    
    
    
    //MARK: - 로그인
    
    func login(email: String, password: String) -> Single<Result<LoginResponse, FiveError>> {
        
        let data = Login(email: email, password: password)
        
        return Single.create { single in
            self.provider.request(.login(model: data)) { result in
                switch result {
                case .success(let response):
                    print("===APIManager, StatusCode == \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                    
                case .failure(let error):
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else {
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
        
    }
    
    
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
    
    
    
    //MARK: - 토큰 갱신
    
    func RefreshToken() -> Single<Result<RefreshTokenResponse, FiveError>> {
        
        return Single.create { single in
            self.provider.request(.tokenRefresh) { result in
                switch result {
                case .success(let response):
                    print("===APIMAnager, StatusCode === \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(RefreshTokenResponse.self, from: response.data)
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

