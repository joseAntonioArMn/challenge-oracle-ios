//
//  HomePresenter.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireframe: HomeWireframeProtocol? { get set }
    
    /// View --> Presenter
    func viewDidLoad()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    /// Interactor --> Presenter
}

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    // MARK: VIPER Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireframe: HomeWireframeProtocol?
    
    // MARK: View --> Presenter
    func viewDidLoad() {
        interactor?.fetchQuestions(text: "swiftui", completion: { [weak self] result in
            switch result {
            case .success(let questionsResponse):
                print(questionsResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: Interactor --> Presenter
}
