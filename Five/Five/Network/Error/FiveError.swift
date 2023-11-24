//
//  FiveError.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation
import Moya

enum FiveError: Int, Error, LocalizedError {
    
    case decodingError = 1
    
    //MARK: - 공통 응답코드
    
    case unknownKey = 420 // 키값 없거나 틀릴 경우
    case overcall = 429 // 과호출
    case weirdURL = 444 //비정상 URL
    case unauthorized = 500 //비정상 요청
    
    //MARK: - 응답코드별 상황
    
    case valueRequired = 400 //필수값 내놔
    case existedAccount = 409
    case unacceptedAccount = 401
    case Forbidden = 403
    case expiredToken = 419
    
    var errorDescription: String? {
        switch self {
        case .unknownKey:
            return "SesacKey 키값이 없거나 틀립니다."
        case .overcall:
            return "과호출입니다."
        case .weirdURL:
            return "비정상 URL을 통해 요청하였습니다."
        case .unauthorized:
            return "비정상 요청 및 사전에 정의되지 않는 에러가 발생하였습니다."
        case .valueRequired:
            return "필수값을 채워주세요."
        case .existedAccount:
            return "이미 사용중인 이메일입니다."
        case .unacceptedAccount:
            return "가입되지 않은 계정입니다. 비밀번호 입력을 확인해주세요."
        case .Forbidden:
            return "접근권한이 없습니다."
        case .expiredToken:
            return "리프레시 토큰이 만려되었습니다. 다시 로그인 해주세요."
        case .decodingError:
            return "decoding error"
        }
    }
}

