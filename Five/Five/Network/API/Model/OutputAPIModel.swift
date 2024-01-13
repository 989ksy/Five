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
    let likes, image, hashTags : [String]
    let creator: Creator
    let ratio: String //content1
    
    enum CodingKeys: String, CodingKey {
        case likes, image, hashTags
        case id = "_id"
        case time, content, creator
        case productId = "product_id"
        case ratio = "content1"
    }
}

struct Creator: Decodable {
    let id, nick: String
    let  profile : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick, profile
    }
    
}

//MARK: - 해시태그 검색

struct HashtagResponse: Decodable {
    let data: [HashData]
    let nextCursor: String

    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

struct HashData: Decodable {
    let likes: [String]
    let image, hashTags: [String]
    let comments: [String]
    let id: String
    let creator: Creator
    let time, content, productID: String

    enum CodingKeys: String, CodingKey {
        case likes, image, hashTags, comments
        case id = "_id"
        case creator, time, content
        case productID = "product_id"
    }
}


//MARK: - 포스트 조회

struct ReadPostResponse: Decodable, Hashable {
    let data: [ReadData]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

struct ReadData : Decodable, Hashable {
    
    let likes, image, hashTags: [String]
    let comments: [CreateCommentResponse]
    let id: String
    let creator: Creator
    let time, content, productID: String
    let ratio: String?
    
    enum CodingKeys: String, CodingKey {
        case likes, image, comments, hashTags
        case id = "_id"
        case creator, time, content
        case productID = "product_id"
        case ratio = "content1"
    }
    
    static func == (lhs: ReadData, rhs: ReadData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
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

struct MyProfileResponse: Decodable {
    let posts : [String]
    let followers: [String]
    let following: [String]
    let id : String
    let email : String
    var nick : String
    
    enum CodingKeys: String, CodingKey {
        case posts, followers, following
        case email, nick
        case id = "_id"
    }
    
}

//MARK: - 다른유저 프로필 조회

struct UserProfileResponse: Decodable {
    let posts : [String]
    let followers: [String]
    let following: [String]
    let id : String
    var nick : String
    
    enum CodingKeys: String, CodingKey {
        case posts, followers, following
        case nick
        case id = "_id"
    }
    
}


//MARK: - 유저별 포스트 조회

struct readUserPostResponse : Decodable {
    var data: [ReadData]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

//MARK: - 댓글 작성

struct CreateCommentResponse : Decodable {
        let id, content, time: String
        let creator: Creator

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case content, time, creator
        }
    }

//MARK: - 댓글 삭제

struct DeleteCommentResponse : Decodable {
    let postID, commentID : String
}

//MARK: - 프로필 업데이트

struct UpdateProfileResponse : Decodable {
    
    let posts: [String]
    let followers, following: [String]
    let id, email, nick, profile: String
    
    enum CodingKeys: String, CodingKey {
        case posts, followers, following
        case id = "_id"
        case email, nick, profile
        
    }
}
