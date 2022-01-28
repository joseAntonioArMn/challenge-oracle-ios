//
//  HomeInteractor.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? { get set }
    var networkClient: NetworkClientType { get set }
    
    /// Presenter --> Interactor
    var moduleTitle: String { get }
    var hasMore: Bool { get }
    var pageCounter: Int { get }
    func setQuestionsResponse(questionsResponse: QuestionsResponse)
    func fetchQuestions(text: String, isNewText: Bool, completion: @escaping (Result<JSONResponse<QuestionsResponse>, NetworkClientError>) -> Void)
}

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: VIPER Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var networkClient: NetworkClientType = NetworkClient()
    
    // MARK: Public Properties
    var pageCounter = 0
    
    // MARK: Private Properties
    private var questionsResponse: QuestionsResponse?
    
    // MARK: Presenter --> Interactor
    var moduleTitle: String {
        return "Top Questions"
    }
    
    var hasMore: Bool {
        return questionsResponse?.hasMore ?? false
    }
    
    func fetchQuestions(text: String, isNewText: Bool, completion: @escaping (Result<JSONResponse<QuestionsResponse>, NetworkClientError>) -> Void) {
        if isNewText { pageCounter = 0 }
        pageCounter += 1
        let request = HTTPRequest(url: UserEndpoints.searchQuestion(text: text, page: pageCounter).url)
        networkClient.decodedJSONRequest(type: QuestionsResponse.self, request: request, completion: completion)
    }
    
    func setQuestionsResponse(questionsResponse: QuestionsResponse) {
        self.questionsResponse = questionsResponse
    }
}
