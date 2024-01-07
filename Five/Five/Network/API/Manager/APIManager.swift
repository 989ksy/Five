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
    
    
    private let disposeBag = DisposeBag()
    
    //MARK: - 다른 유저 프로필 조회
    
    func userProfile(id: String) -> Single<Result<UserProfileResponse, FiveError>>{
        
        return Single.create { single in
            self.provider.request(.userProfile(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(UserProfileResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                    
                case .failure(let error) :
                    print("=======네트워크 실패의 실패 from APIManager : \(error.response?.request)")
                    
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else { return }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
        
    }
    
    
    //MARK: - 댓글 삭제
    
    func deleteComment(postId: String, commentId: String) -> Single<Result<DeleteCommentResponse, FiveError>> {
        
        return Single.create { single in
            
            self.provider.request(.deleteComment(postId: postId, commentId: commentId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(DeleteCommentResponse.self, from: response.data)
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
    
    //MARK: - 프로필 수정
    
    func updateProfile(nick: String, profile: Data) -> Single<Result<UpdateProfileResponse, FiveError>> {
        
        let data = UpdateProfile(nick: nick, profile: profile)
        
        return Single.create { single in
            self.provider.request(.updateProfile(model: data)) { result in
                switch result {
                case .success(let response):
                    print("===APIManager for updateProfile, StatusCode == \(response.statusCode), == response: \(response)")
                    
                    do {
                        let data = try JSONDecoder().decode(UpdateProfileResponse.self, from: response.data)
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
    
    
    //MARK: - 댓글 작성
    
    func createComment(id: String, content: String) -> Single<Result<CreateCommentResponse, FiveError>> {
        return Single.create { single in
            
            let data = CreateComment(content: content)
            self.provider.request(.createComment(model: data, id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(CreateCommentResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                case .failure(let failure) :
                    print(failure)
                    print(failure.errorDescription!)
                    print(failure.errorCode)
                }
            }
            return Disposables.create()
        }
    }
    
    
    //MARK: - 유저별 포스트 조회
    
    func readUserPost(id: String, next: String, limit: String, productId: String) -> Single<Result<readUserPostResponse, FiveError>> {
        
        return Single.create { single in
            self.provider.request(.readUserPost(id: id, next: next, limit: limit, product_id: productId)) { result in
                
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(readUserPostResponse.self, from: response.data)
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
    
    
    //MARK: - 내 프로필 조회
    
    func myProfile() -> Single<Result<MyProfileResponse, FiveError>> {
        
        return Single.create { single in
            
            self.provider.request(.myProfile) { result in
                
                switch result {
                case .success(let response) :
                    do {
                        let data = try JSONDecoder().decode(MyProfileResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                case .failure(let error) :
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else { return }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
    }
    
    
    //MARK: - 좋아요
    
    func likePost(id: String) -> Single<Result<LikePostResponse, FiveError>>{
        
        return Single.create { single in
            self.provider.request(.likePost(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(LikePostResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                    
                case .failure(let error) :
                    print("=======네트워크 실패의 실패 from APIManager : \(error.response?.request)")
                    
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else { return }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
        
    }
    
    
    //MARK: - 포스트 삭제
    
    func deletePost(id: String) -> Single<Result<DeletePostResponse, FiveError>> {
        
        return Single.create { single in
            self.provider.request(.deletePost(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(DeletePostResponse.self, from: response.data)
                        single(.success(.success(data)))
                    } catch {
                        single(.success(.failure(.decodingError)))
                    }
                case.failure(let error):
                    guard let customError = FiveError(rawValue: error.response?.statusCode ??  1) else {
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
        
    }

    
    
    //MARK: - 포스트 조회
    
    func readPost(next: String, limit: String, productId: String) -> Single<Result<ReadPostResponse, FiveError>> {
        
        return Single.create { single in
            self.provider.request(.readPost(next: next, limit: limit, product_id: productId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(ReadPostResponse.self, from: response.data)
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
//                    print("=======\(error.response?.request)")
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

