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

//MARK: - 포스트 작성

struct CreatePost: Encodable {
    let content : String?
    let file : [Data]?
    let product_id : String
}

//MARK: - 댓글 작성

struct CreateComment: Encodable {
    let content : String?
}

//MARK: - 프로필 변경

struct UpdateProfile: Encodable {
    let nick : String
    let profile : Data?
}
