//
//  Question.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

struct Question: Decodable {
    let title: String
    let tags: [String]
    let creationDate: Int
    let owner: Owner
    let viewsCount: Int
    let answersCount: Int
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case tags
        case creationDate = "creation_date"
        case owner
        case viewsCount = "view_count"
        case answersCount = "answer_count"
        case score
    }
}

struct Owner: Decodable {
    let name: String
    let id: Int
    let reputation: Int
    let type: String
    let imageURL: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case id = "user_id"
        case reputation
        case type = "user_type"
        case imageURL = "profile_image"
        case link
    }
}
