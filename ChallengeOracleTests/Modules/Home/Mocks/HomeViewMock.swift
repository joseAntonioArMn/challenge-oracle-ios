//
//  HomeViewMock.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit
@testable import ChallengeOracle

class HomeViewMock: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    var setUpUICalls = 0
    var setUpTableViewCalls = 0
    var setUpSearchControllerCalls = 0
    var displayQuestionsItemsCalls = 0
    
    func setUpUI() {
        setUpUICalls += 1
    }
    
    func setUpTableView() {
        setUpTableViewCalls += 1
    }
    
    func setUpSearchController() {
        setUpSearchControllerCalls += 1
    }
    
    func displayQuestionsItems(questionItems: [QuestionItem]) {
        displayQuestionsItemsCalls += 1
    }
    
    
}
