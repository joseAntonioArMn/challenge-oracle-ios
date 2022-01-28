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
    var currentText: String { get set }
    var currentItems: [QuestionItem] { get set }
    
    /// View --> Presenter
    var title: String { get }
    func viewDidLoad()
    func didEnterTextInSearchBar(text: String, isFiltering: Bool)
    func didSelectQuestionItem(questionItem: QuestionItem)
    func willDisplayCell(withIndexPath indexPath: IndexPath)
    func manageQuestionResponse(questionsResponse: QuestionsResponse, isNewText: Bool)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    /// Interactor --> Presenter
}

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    // MARK: VIPER Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireframe: HomeWireframeProtocol?
    
    // MARK: Public Properties
    var currentText = ""
    var currentItems: [QuestionItem] = []
    
    // MARK: Private Properties
    private var currentQuestionsCount: Int {
        return currentItems.count
    }
    private var timer: Timer?
    private var shouldRequestMoreQuestions = false
    private var isLoading = false
    
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
        timer?.invalidate()
        if isFiltering {
            timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
            currentText = text
            currentItems = []
        } else {
            shouldRequestMoreQuestions = false
            isLoading = false
            view?.displayQuestionsItems(questionItems: [])
        }
    }
    
    func didSelectQuestionItem(questionItem: QuestionItem) {
        guard let view = self.view as? UIViewController,
              let questionCellItem = questionItem as? QuestionCellItem else { return }
        wireframe?.presentDetailModule(withQuestion: questionCellItem.question, fromViewController: view)
    }
    
    func willDisplayCell(withIndexPath indexPath: IndexPath) {
        if indexPath.row == currentQuestionsCount - 1 {
            if shouldRequestMoreQuestions {
                if !isLoading {
                    currentItems.append(LoaderCellItem())
                    view?.displayQuestionsItems(questionItems: self.currentItems)
                    isLoading = true
                    requestQuestions(isNewText: false)
                }
            } else {
                shouldRequestMoreQuestions = true
            }
        }
    }
    
    func requestQuestions(isNewText: Bool = true) {
        guard let hasMore = interactor?.hasMore else { return }
        if (isNewText) || (!isNewText && hasMore) {
            interactor?.fetchQuestions(text: currentText, isNewText: isNewText, completion: { [weak self] result in
                switch result {
                case .success(let questionsResponse):
                    self?.interactor?.setQuestionsResponse(questionsResponse: questionsResponse.decodedObject)
                    self?.manageQuestionResponse(questionsResponse: questionsResponse.decodedObject, isNewText: isNewText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    func manageQuestionResponse(questionsResponse: QuestionsResponse, isNewText: Bool) {
        let newItems = questionsResponse.items.map { QuestionCellItem(question: $0) }
        if isNewText {
            currentItems.removeAll()
        } else {
            currentItems.removeLast()
        }
        self.currentItems.append(contentsOf: newItems)
        self.isLoading = false
        self.view?.displayQuestionsItems(questionItems: self.currentItems)
    }
    
    // MARK: Interactor --> Presenter
    // add if needed..
    
    // MARK: Private Methods
    @objc private func fireTimer() {
        requestQuestions()
    }
}
