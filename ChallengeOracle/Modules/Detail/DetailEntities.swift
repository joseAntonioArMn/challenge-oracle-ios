//
//  DetailEntities.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum DetailType {
    case user
    case question
}

protocol DetailItem {
    var type: DetailType { get }
}

struct DetailQuestionItem: DetailItem {
    var type: DetailType  {
        return .question
    }
    
    let question: Question
    
    init(question: Question) {
        self.question = question
    }
}

struct DetailUserItem: DetailItem {
    var type: DetailType  {
        return .user
    }
    
    let user: Owner
    
    init(user: Owner) {
        self.user = user
    }
}
