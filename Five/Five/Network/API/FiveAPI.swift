//
//  FiveAPI.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import Moya

enum FiveAPI {
    //회원가입 & 로그인
    case signUp (model: Signup)
    case login (model: Login)
    case emailValidation (model: CheckEmail)
    case tokenRefresh
    case withdraw
    
    //포스트
    case createPost (model: CreatePost)
    case readPost (next: String, limit: String, product_id: String)
    case deletePost (id: String)
    case readUserPost (id: String, next: String, limit: String, product_id: String)
    
    //좋아요
    case likePost (id: String)
    
    //프로필
    case myProfile
    case updateProfile (model: UpdateProfile)
    case userProfile (id: String)
    
    //댓글
    case createComment (model: CreateComment, id: String)
    case deleteComment (postId: String, commentId: String)
    
    //해시태그
    case hashtag (next: String, limit: String, product_id: String, hashTag: String)
    
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
            return "post/\(id)"
        case .readUserPost(let id, let next, let limit, let product_id):
            return "post/user/\(id)"
            
            //좋아요
        case .likePost(let id):
            return "post/like/\(id)"
            
            //프로필
        case .myProfile:
            return "profile/me"
        case .updateProfile:
            return "profile/me"
        case .userProfile(let id):
            return "profile/\(id)"
            
            //댓글
        case .createComment(_, let id):
            return "post/\(id)/comment"
        case .deleteComment(postId: let postId, commentId: let commentId):
            return "post/\(postId)/comment/\(commentId)"
            
            //해시태그
        case .hashtag:
            return "post/hashtag"
        }
        
            
    }
    
    //MARK: - method
    ///specify which method our calls should use.
    var method: Moya.Method {
        switch self {
            
            //포스트
        case .signUp,
                .login,
                .emailValidation,
                .createPost,
                .likePost,
                .createComment:
            return .post
            
            //겟
        case .tokenRefresh,
                .withdraw,
                .readPost,
                .myProfile,
                .readUserPost,
                .userProfile,
                .hashtag:
            return .get
            
            //딜리트
        case .deletePost,
                .deleteComment:
            return .delete
            
            //풋
        case .updateProfile:
            return .put
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
            
            //포스트 작성
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
            
            let content1Data = MultipartFormData(provider: .data(data.content1.data(using: .utf8)!), name: "content1")
                multipartData.append(content1Data)

            
            print("multipartData", multipartData)
            
            return .uploadMultipart(multipartData)
            
        case .readPost(let next, let limit, let product_id ):
            return .requestParameters(parameters: ["next" : next, "limit" : limit, "product_id" : product_id], encoding: URLEncoding.queryString)
            
        case .deletePost(_):
            return .requestPlain
            
        case .likePost(_):
            return .requestPlain
            
        case .myProfile:
            return .requestPlain
            
        case .userProfile:
            return .requestPlain
        
        case .readUserPost(let id, let next, let limit, let product_id):
            return .requestParameters(parameters: ["next" : next, "limit" : limit, "product_id" : product_id], encoding: URLEncoding.queryString)
            
        case .createComment(let data, _):
            return .requestJSONEncodable(data)
            
        case .updateProfile(model: let data):
            var multipartData: [MultipartFormData] = []
            
            if let file = data.profile {
                let multi = MultipartFormData(
                    provider: .data(file),
                    name: "profile",
                    fileName: "\(Date()).jpeg",
                    mimeType: "image/jpeg"
                )
                multipartData.append(multi)
            }
            
            let nicknData = data.nick
            let multi = MultipartFormData(
                provider: .data(nicknData.data(using: .utf8)!),
                name: "nick"
            )
            multipartData.append(multi)
            
            print("multipartData", multipartData)
            
            return .uploadMultipart(multipartData)
            
        case .deleteComment:
            return .requestPlain
            
        case .hashtag(let next, let limit, let product_id, let hashTag):
            return .requestParameters(parameters: ["next" : next, "limit" : limit, "product_id" : product_id, "hashTag": hashTag], encoding: URLEncoding.queryString)
        }
    }
    
    
    //MARK: - 헤더
    //the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String : String]? {
        
        switch self {
            
            // [content-type, SesacKey]

        case .signUp, //회원가입
                .login, //로그인
                .emailValidation, //이메일 중복확인
                .tokenRefresh:
            return ["Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .createPost: //포스트 생성
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)", 
                    "Content-Type" : "multipart/form-data",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .createComment,
                .updateProfile:
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)",
                    "Content-Type" : "application/json",
                    "SesacKey" : "\(APIKey.sesacKey)"]
            
        case .readPost,
                .withdraw: //포스트 조회
            return ["SesacKey" : "\(APIKey.sesacKey)"]
            
        case .readUserPost,
                .myProfile, //내 프로필
                .deletePost, //포스트 삭제
                .likePost, //좋아요
                .userProfile,
                .deleteComment,
                .hashtag:
            return ["Authorization" : "\(KeychainStorage.shared.userToken!)",
                    "SesacKey" : "\(APIKey.sesacKey)"]
                        
        }
        
    }
    
    //MARK: - 성공코드
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

