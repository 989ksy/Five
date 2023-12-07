//
//  FiveAPI.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import Moya

enum FiveAPI {
    case signUp (model: Signup)
    case login (model: Login)
    case emailValidation (model: CheckEmail)
    case tokenRefresh
    case withdraw
    
    case createPost (model: CreatePost)
    case readPost
}

extension FiveAPI : TargetType {
    
    //MARK: - BaseURL
    ///the base URL we'll be using, typically our server.
    var baseURL: URL {
        return URL(string: BaseURL.base)!
     }
    
    
    //MARK: - Path
    ///the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
            
            //회원
        case .signUp:
            return "join"
        case .login:
            return "login"
        case .emailValidation:
            return "validation/email"
        case .tokenRefresh:
            return "refresh"
        case .withdraw:
            return "withdraw"
            
            //포스트
        case .createPost, .readPost:
            return "post"
        }
    }
    
    //MARK: - method
    ///specify which method our calls should use.
    var method: Moya.Method {
        switch self {
            
        case .signUp, .login, .emailValidation, .createPost:
            return .post
        case .tokenRefresh, .withdraw, .readPost:
            return .get
        }
    }
    
    //MARK: - task
    ///specify body parameters, objects, files etc.
    /// or just do a plain request without a body.
    var task: Moya.Task {
        switch self {
            
            //회원가입-로그인-탈퇴
        case .signUp(let data):
            return .requestJSONEncodable(data)
            
        case .login(let data):
            return .requestJSONEncodable(data)
            
        case .emailValidation(let data):
            return .requestJSONEncodable(data)
            
        case .tokenRefresh:
            return .requestPlain
            
        case .withdraw:
            return .requestPlain
            
            //포스트 작성-조회
        case .createPost(let data):
            
            var multipartData: [MultipartFormData] = []

            if let file = data.file {
                for item in file {
                    let multi = MultipartFormData(
                        provider: .data(item),
                        name: "file",
                        fileName: "\(Date()).jpeg", //UUID().uuidString
                        mimeType: "image/jpeg"
                    )
                    multipartData.append(multi)
                }
            }
            
            let productIdData = MultipartFormData(provider: .data(data.product_id.data(using: .utf8)!), name: "product_id")
            multipartData.append(productIdData)
            if let contentData = data.content {
                let multi = MultipartFormData(provider: .data(contentData.data(using: .utf8)!), name: "content")
                multipartData.append(multi)
            }
            print("multipartData", multipartData)
            return .uploadMultipart(multipartData)
            
        case .readPost:
            return .requestPlain
        }
    }
    
    
    //MARK: - 헤더
    //the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String : String]? {
        
        switch self {
            //회원가입-로그인-탈퇴
        case .signUp:
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        case .login:
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        case .emailValidation:
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        case .tokenRefresh :
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        case .withdraw:
            return ["SesacKey" : "\(APIKey.sesacKey)"]
            
            //포스트조회-업로드
        case .createPost:
            
            print("======= 포스트업로드 fiveAPI, accessToken: \(KeychainStorage.shared.userToken!), === refresh: \(KeychainStorage.shared.userRefreshToken!)")
            
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)" ,"Content-Type" : "multipart/form-data", "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .readPost:
            return ["Content-Type" : "multipart/form-data", "SesacKey" : "\(APIKey.sesacKey)"]
        }
        
    }
    
    //MARK: - 성공코드
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

