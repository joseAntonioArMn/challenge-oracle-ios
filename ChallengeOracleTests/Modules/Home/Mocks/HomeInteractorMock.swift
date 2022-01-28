//
//  HomeInteractorMock.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
@testable import ChallengeOracle

class HomeInteractorMock: HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol?
    var networkClient: NetworkClientType = NetworkClient()
    
    var moduleTitle: String = "Defined Title"
    var hasMore: Bool = true
    var pageCounter: Int = 0
    
    var setQuestionsResponseCalls = 0
    var fetchQuestionsCalls = 0
    
    func setQuestionsResponse(questionsResponse: QuestionsResponse) {
        setQuestionsResponseCalls += 1
    }
    
    func fetchQuestions(text: String, isNewText: Bool, completion: @escaping (Result<JSONResponse<QuestionsResponse>, NetworkClientError>) -> Void) {
        fetchQuestionsCalls += 1
    }
    
    
}
