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
            
        case .login(let data):
            return .requestJSONEncodable(data)
            
        case .emailValidation(let data):
            return .requestJSONEncodable(data)
            
        case .tokenRefresh:
            return .requestPlain
            
        case .withdraw:
            return .requestPlain
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
                    "SesacKey" : "\(APIKey.sesacKey)"]
        case .withdraw:
            return [ "SesacKey" : "\(APIKey.sesacKey)"]
        }
        
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

