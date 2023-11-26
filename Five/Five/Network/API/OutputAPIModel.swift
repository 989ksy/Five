//
//  OutputAPIModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation

//결과값

//MARK: - 회원가입
struct SignupResponse : Decodable {
    let _id : String
    let email : String
    let nick : String
}

//MARK: - 로그인

struct LoginResponse: Decodable {
    let token: String
    let refreshToken: String
}

//MARK: - 이메일 중복 확인

struct CheckEmailResponse : Decodable {
    let message: String
}

//MARK: - 토큰 갱신

struct RefreshToken : Decodable {
    let token : String
}
