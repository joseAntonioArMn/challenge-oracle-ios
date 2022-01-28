//
//  HomePresenterMock.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
@testable import ChallengeOracle

class HomePresenterMock: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireframe: HomeWireframeProtocol?
    
    var currentText: String = ""
    var currentItems: [QuestionItem] = []
    
    var title: String {
        return interactor?.moduleTitle ?? ""
    }
    
    var viewDidLoadCalls = 0
    var didEnterTextInSearchBarCalls = 0
    var didSelectQuestionItemCalls = 0
    var willDisplayCellCalls = 0
    var manageQuestionResponseCalls = 0
    
    func viewDidLoad() {
        viewDidLoadCalls += 1
    }
    
    func didEnterTextInSearchBar(text: String, isFiltering: Bool) {
        didEnterTextInSearchBarCalls += 1
    }
    
    func didSelectQuestionItem(questionItem: QuestionItem) {
        didSelectQuestionItemCalls += 1
    }
    
    func willDisplayCell(withIndexPath indexPath: IndexPath) {
        willDisplayCellCalls += 1
    }
    
    func manageQuestionResponse(questionsResponse: QuestionsResponse, isNewText: Bool) {
        manageQuestionResponseCalls += 1
    }
    
}
