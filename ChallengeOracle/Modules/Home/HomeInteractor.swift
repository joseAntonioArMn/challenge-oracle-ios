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
}

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: VIPER Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var networkClient: NetworkClientType = NetworkClient()
    
    // MARK: Presenter --> Interactor
}
