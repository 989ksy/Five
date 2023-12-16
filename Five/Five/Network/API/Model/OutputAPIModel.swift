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
    let id : String
    
    enum CodingKeys: String, CodingKey {
        case token, refreshToken
        case id = "_id"
    }
    
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

//MARK: - 포스트 조회

struct ReadPostResponse: Decodable {
    let data: [ReadData]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

struct ReadData : Decodable {
    let likes, image: [String]
    let id: String
    let creator: Creator
    let time, content, productID: String
    
    enum CodingKeys: String, CodingKey {
        case likes, image
        case id = "_id"
        case creator, time, content
        case productID = "product_id"
    }
}

//MARK: - 포스트 삭제

struct DeletePostResponse: Decodable {
    let id : String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}

//MARK: - 좋아요

struct LikePostResponse: Decodable{
    let likeStatus : Bool
    
    enum CodingKeys: String, CodingKey {
        case likeStatus = "like_status"
    }
}

//MARK: - 내 프로필 조회

struct myProfileResponse : Decodable {
    let post : [String]
    let followers: [String]
    let following: [String]
    let id : String
    let email : String
    let nick : String
    
    enum CodingKeys: String, CodingKey {
        case post, followers, following
        case email, nick
        case id = "_id"
    }
}


