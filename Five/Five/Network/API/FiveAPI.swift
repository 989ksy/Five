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
    case login (email: String, password: String)
    case emailValidation (model: CheckEmail)
    case tokenRefresh// HTTP - GET은 요청바디 없음.
    case withdraw // HTTP - GET은 요청바디 없음.
}

extension FiveAPI : TargetType {
    
    
    //the base URL we'll be using, typically our server.
    var baseURL: URL {
        return URL(string: BaseURL.base)!
     }
    
    //the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
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
        }
    }
    
    //specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .signUp, .login, .emailValidation:
            return .post
        case .tokenRefresh, .withdraw:
            return .get
        }
    }
    
    //specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    var task: Moya.Task {
        switch self {
        case .signUp(let data):
            return .requestJSONEncodable(data)
            
        case .login(let email, let password):
            let data = Login(email: email, password: password)
            return .requestJSONEncodable(data)
            
        case .emailValidation(let data):
            return .requestJSONEncodable(data)
            
        case .tokenRefresh:
            return .requestPlain//.requestParameters(parameters: ["token":""], encoding: URLEncoding.httpBody)
            
        case .withdraw:
            return .requestParameters(parameters: ["_id" : "뭔데..", "email":"a@c.com","nick":"별명"], encoding: URLEncoding.httpBody)
        }
    }
    
    
    //he headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String : String]? {
        
        switch self {
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
                    "SesacKey" : "\(APIKey.sesacKey)", "Authorization" : "토큰..", "Refresh" : "토큰..인데 새 거.."]
        case .withdraw:
            return ["Authorization" : "token...",
                    "SesacKey" : "\(APIKey.sesacKey)"]
        }
        
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

