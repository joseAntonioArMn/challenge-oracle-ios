//
//  QuestionsCellEntities.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum QuestionType {
    case question
    case loader
}

protocol QuestionItem {
    var type: QuestionType { get }
}

struct QuestionCellItem: QuestionItem {
    var type: QuestionType  {
        return .question
    }
    
    let question: Question
    
    init(question: Question) {
        self.question = question
    }
}

struct LoaderCellItem: QuestionItem {
    var type: QuestionType  {
        return .loader
    }
}
