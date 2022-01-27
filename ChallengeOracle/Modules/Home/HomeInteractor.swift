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
    func fetchQuestions(text: String, completion: @escaping (Result<JSONResponse<QuestionsResponse>, NetworkClientError>) -> Void)
}

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: VIPER Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var networkClient: NetworkClientType = NetworkClient()
    
    // MARK: Presenter --> Interactor
    var moduleTitle: String {
        return "Top Questions"
    }
    
    func fetchQuestions(text: String, completion: @escaping (Result<JSONResponse<QuestionsResponse>, NetworkClientError>) -> Void) {
        let request = HTTPRequest(url: UserEndpoints.searchQuestion(text: text).url)
        networkClient.decodedJSONRequest(type: QuestionsResponse.self, request: request, completion: completion)
    }
}
