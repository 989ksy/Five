//
//  InputAPIModel.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import Foundation

//입력값 (요청바디)

//MARK: - 회원가입

struct Signup : Encodable {
    let email: String
    let password : String
    let nick : String
}

//MARK: - 로그인

struct Login: Encodable {
    let email: String
    let password: String
}

//MARK: - 이메일 중복 확인

struct CheckEmail: Encodable {
    let email: String
}

