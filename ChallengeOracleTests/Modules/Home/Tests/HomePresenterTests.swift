//
//  HomePresenterTests.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import XCTest
@testable import ChallengeOracle

class HomePresenterTests: XCTestCase {

    typealias PresenterType = HomePresenterProtocol & HomeInteractorOutputProtocol
    var presenter: PresenterType?
    var view: HomeViewMock?
    var interactor: HomeInteractorMock?
    var router: HomeRouterMock?
    
    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
        interactor = HomeInteractorMock()
        view = HomeViewMock()
        router = HomeRouterMock()
        presenter?.view = view
        presenter?.interactor = interactor
        presenter?.wireframe = router
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
        view = nil
        super.tearDown()
    }
    
    func testTitle() {
        XCTAssertEqual(presenter?.title, "Defined Title")
    }
    
    func testViewDidLoad() {
        presenter?.viewDidLoad()
        XCTAssertEqual(1, view?.setUpUICalls)
        XCTAssertEqual(1, view?.setUpTableViewCalls)
        XCTAssertEqual(1, view?.setUpSearchControllerCalls)
    }
    
    func testDidEenterTextInSearchBarFiltering() {
        presenter?.didEnterTextInSearchBar(text: "java", isFiltering: true)
        XCTAssertEqual("java", presenter?.currentText)
        XCTAssertEqual(0, presenter?.currentItems.count)
    }
    
    func testDidEenterTextInSearchBarNotFiltering() {
        presenter?.didEnterTextInSearchBar(text: "java", isFiltering: false)
        XCTAssertEqual(1, view?.displayQuestionsItemsCalls)
    }
    
    func testDidSelectQuestionItem() {
        let owner = Owner(name: "", id: 0, reputation: 0, type: "", imageURL: "", link: "")
        let question = Question(title: "", tags: [], creationDate: 0, owner: owner, viewsCount: 0, answersCount: 0, score: 0, id: 0)
        let item = QuestionCellItem(question: question)
        presenter?.didSelectQuestionItem(questionItem: item)
        XCTAssertEqual(1, router?.presentDetailModuleCalls)
    }
    
    func testDidSelectQuestionItemNotSelectable() {
        let item = LoaderCellItem()
        presenter?.didSelectQuestionItem(questionItem: item)
        XCTAssertEqual(0, router?.presentDetailModuleCalls)
    }
    
    func testWillDisplayLastCell() {
        let owner = Owner(name: "", id: 0, reputation: 0, type: "", imageURL: "", link: "")
        let question = Question(title: "", tags: [], creationDate: 0, owner: owner, viewsCount: 0, answersCount: 0, score: 0, id: 0)
        let item = QuestionCellItem(question: question)
        presenter?.currentItems = [item, item, item, item, item, item, item, item, item, item]
        /// Called two times to simulate table view..
        presenter?.willDisplayCell(withIndexPath: IndexPath(row: 9, section: 0))
        presenter?.willDisplayCell(withIndexPath: IndexPath(row: 9, section: 0))
        XCTAssertEqual(11, presenter?.currentItems.count)
        XCTAssertEqual(1, interactor?.fetchQuestionsCalls)
    }
    
    func testManageQuestionResponseNewText() {
        let owner = Owner(name: "", id: 0, reputation: 0, type: "", imageURL: "", link: "")
        let question = Question(title: "", tags: [], creationDate: 0, owner: owner, viewsCount: 0, answersCount: 0, score: 0, id: 0)
        let array = [question, question, question, question, question, question, question, question, question, question]
        let response = QuestionsResponse(items: array, hasMore: true, quotaMax: 0, quotaRemaining: 0)
        let item = QuestionCellItem(question: question)
        presenter?.currentItems = [item, item, item, item, item]
        presenter?.manageQuestionResponse(questionsResponse: response, isNewText: true)
        XCTAssertEqual(10, presenter?.currentItems.count)
        XCTAssertEqual(1, view?.displayQuestionsItemsCalls)
    }
    
    func testManageQuestionResponseNotNewText() {
        let owner = Owner(name: "", id: 0, reputation: 0, type: "", imageURL: "", link: "")
        let question = Question(title: "", tags: [], creationDate: 0, owner: owner, viewsCount: 0, answersCount: 0, score: 0, id: 0)
        let loader = LoaderCellItem()
        let array = [question, question, question, question, question, question, question, question, question, question]
        let response = QuestionsResponse(items: array, hasMore: true, quotaMax: 0, quotaRemaining: 0)
        let item = QuestionCellItem(question: question)
        presenter?.currentItems = [item, item, item, item, item, loader]
        presenter?.manageQuestionResponse(questionsResponse: response, isNewText: false)
        XCTAssertEqual(15, presenter?.currentItems.count)
        XCTAssertEqual(1, view?.displayQuestionsItemsCalls)
    }
    
    func testTags() {
        let owner = Owner(name: "", id: 0, reputation: 0, type: "", imageURL: "", link: "")
        let question = Question(title: "", tags: ["swift", "python", "oracle"], creationDate: 0, owner: owner, viewsCount: 0, answersCount: 0, score: 0, id: 0)
        XCTAssertEqual("swift, python, oracle", question.tagsString)
    }
}
