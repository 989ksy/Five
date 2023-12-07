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

struct RefreshTokenResponse : Decodable {
    let token : String
}

//MARK: - 포스트 작성

struct CreatePostResponse: Decodable {

    let id, time, content: String
    let productId : String
    let likes, image : [String]
    let creator: Creator
    
    enum CodingKeys: String, CodingKey {
        case likes, image
        case id = "_id"
        case time, content, creator
        case productId = "product_id"
    }
}

struct Creator: Decodable {
    
    let id, nick : String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick
    }
    
}
