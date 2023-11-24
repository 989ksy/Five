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
    let email : String
    let password : String
    let nick: String
}

//MARK: - 로그인

struct LoginResponse: Decodable {
    let email: String
    let password: String
}

//MARK: - 닉네임

struct NicknameResponse : Decodable {
    let nick: String
}

//MARK: - 이메일 중복 확인

struct CheckEmailResponse : Decodable {
    let message: String
}
