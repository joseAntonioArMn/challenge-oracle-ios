//
//  DetailInteractor.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    
    /// Presenter --> Interactor
    var moduleTitle: String { get }
    var currentQuesion: Question { get }
    var owner: Owner { get }
    var userLink: String { get }
}

class DetailInteractor: DetailInteractorInputProtocol {
    
    // MARK: VIPER Properties
    weak var presenter: DetailInteractorOutputProtocol?
    var networkClient: NetworkClientType = NetworkClient()
    
    // MARK: Private Properties
    let question: Question
    
    // MARK: Init
    init(question: Question) {
        self.question = question
    }
    
    // MARK: Presenter --> Interactor
    var moduleTitle: String {
        return "Question ID: \(question.id)"
    }
    
    var currentQuesion: Question {
        return question
    }
    
    var owner: Owner {
        return question.owner
    }
    
    var userLink: String {
        return question.owner.link
    }
    
    // MARK: Private Methods
}
