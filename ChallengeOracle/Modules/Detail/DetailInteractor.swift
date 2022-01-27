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
}

class DetailInteractor: DetailInteractorInputProtocol {
    
    // MARK: VIPER Properties
    weak var presenter: DetailInteractorOutputProtocol?
    
    // MARK: Private Properties
    let question: Question
    
    // MARK: Init
    init(question: Question) {
        self.question = question
    }
    
    // MARK: Presenter --> Interactor
    
    // MARK: Private Methods
}
