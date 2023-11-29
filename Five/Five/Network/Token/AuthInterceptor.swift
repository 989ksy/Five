//
//  AuthInterceptor.swift
//  Five
//
//  Created by Seungyeon Kim on 11/28/23.
//
import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

final class AuthInterceptor: RequestInterceptor {

    static let shared = AuthInterceptor()
    
    private let disposeBag = DisposeBag()

    private init() {}

    //adapt를 통해 Request Header에 필요한 토큰을 넣기
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(BaseURL.base) == true,
              let accessToken = KeychainStorage.shared.userToken,
              let refreshToken = KeychainStorage.shared.userRefreshToken
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(accessToken, forHTTPHeaderField: "accessToken")
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "refreshToken")
        print("adator 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }

    //response의 statusCode가 401인 경우 토큰을 갱신하는 API를 호출
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        APIManager.shared.RefreshToken()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let response):
                    print("Retry-토큰 재발급 성공")
                    KeychainStorage.shared.userToken = response.token
                case .failure(let error):
                    //갱신 실패 -> 로그인 화면으로 전환
                    completion(.doNotRetryWithError(error))
                }
            }
            .disposed(by: disposeBag)
        
        
    }

    
    
        
}