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
    var title: String { get }
    func viewDidLoad()
    func didEnterTextInSearchBar(text: String, isFiltering: Bool)
    func didSelectQuestion(question: Question)
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
    var title: String {
        return interactor?.moduleTitle ?? ""
    }
    
    func viewDidLoad() {
        view?.setUpUI()
        view?.setUpTableView()
        view?.setUpSearchController()
    }
    
    func didEnterTextInSearchBar(text: String, isFiltering: Bool) {
        if isFiltering {
            interactor?.fetchQuestions(text: text, completion: { [weak self] result in
                switch result {
                case .success(let questionsResponse):
                    self?.view?.displayQuestions(questions: questionsResponse.decodedObject.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        } else {
            view?.displayQuestions(questions: [])
        }
    }
    
    func didSelectQuestion(question: Question) {
        guard let view = self.view as? UIViewController else { return }
        wireframe?.presentDetailModule(withQuestion: question, fromViewController: view)
    }
    
    // MARK: Interactor --> Presenter
}
