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
    case readPost (next: String, limit: String, product_id: String)
    case deletePost (id: String)
    
    case likePost (id: String)
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
        case .createPost: //작성
            return "post"
        case .readPost: //조회
            return "post"
        case .deletePost(let id): //삭제
            return "post"
            
        case .likePost(let id):
            return "post/like/\(id)"
        }
    }
    
    //MARK: - method
    ///specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .signUp, .login, .emailValidation, .createPost, .likePost:
            return .post
        case .tokenRefresh, .withdraw, .readPost:
            return .get
        case .deletePost:
            return .delete
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
            
        case .readPost(let next, let limit, let product_id ):
            return .requestParameters(parameters: ["next" : next, "limit" : limit, "product_id" : product_id], encoding: URLEncoding.queryString)
        case .deletePost(let _id):
            return .requestParameters(parameters: ["_id" : _id], encoding: URLEncoding.queryString)
            
        case .likePost(_):
            return .requestPlain
        }
    }
    
    
    //MARK: - 헤더
    //the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String : String]? {
        
        switch self {
        case .signUp: //회원가입
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .login: //로그인
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .emailValidation: //이메일 중복확인
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .tokenRefresh : //토큰 갱신
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .withdraw: //회원탈퇴
            return ["SesacKey" : "\(APIKey.sesacKey)"]
            
        case .createPost: //포스트 생성
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)", 
                    "Content-Type" : "multipart/form-data",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .readPost: //포스트 조회
            return ["SesacKey" : "\(APIKey.sesacKey)"]
            
        case .deletePost: //포스트 삭제
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)", 
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .likePost: //좋아요
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        }
        
    }
    
    //MARK: - 성공코드
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

