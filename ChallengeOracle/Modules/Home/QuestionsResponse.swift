//
//  QuestionsResponse.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

struct QuestionsResponse: Decodable {
    let items: [Question]
    let hasMore: Bool
    let quotaMax: Int
    let quotaRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}
