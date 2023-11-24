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


//MARK: - 닉네임

struct Nickname: Encodable {
    let nick: String
}

//MARK: - 이메일 중복 확인

struct CheckEmail: Encodable {
    let email: String
}

//MARK: - 토큰 갱신 _ LSLP에선 토큰갱신 x, 로그인으로 화면전환되어야함....인데 http라 바디없음...

//struct Token: Encodable {
//    let receivedToken : String
//}
