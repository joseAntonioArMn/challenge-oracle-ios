//
//  HomeInteractorTests.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import XCTest
@testable import ChallengeOracle

class HomeInteractorTests: XCTestCase {

    var interactor: HomeInteractorInputProtocol?
    var presenter: HomePresenterMock?
    var session: URLSessionMock?
    
    override func setUp() {
        super.setUp()
        interactor = HomeInteractor()
        presenter = HomePresenterMock()
        interactor?.presenter = presenter
        session = URLSessionMock()
        let sessionLoader = URLSessionLoader(urlSession: session!)
        let networkClient = NetworkClient(loader: sessionLoader)
        interactor?.networkClient = networkClient
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
        super.tearDown()
    }
    
    func testHasMoreTrue() {
        let response = QuestionsResponse(items: [], hasMore: true, quotaMax: 0, quotaRemaining: 0)
        interactor?.setQuestionsResponse(questionsResponse: response)
        guard let hasMore = interactor?.hasMore else { return }
        XCTAssertTrue(hasMore)
    }
    
    func testHasMoreFalse() {
        let response = QuestionsResponse(items: [], hasMore: false, quotaMax: 0, quotaRemaining: 0)
        interactor?.setQuestionsResponse(questionsResponse: response)
        guard let hasMore = interactor?.hasMore else { return }
        XCTAssertFalse(hasMore)
    }
    
    func testFetchQuestionsSuccess() {
        guard let data = JSONDataLoader().loadJSONData(file: "SearchQuestionResponse") else { return }
        session?.data = data
        session?.response = URLResponseMock.success.response
        var successResponse = false
        let exp = expectation(description: "loading url")
        interactor?.fetchQuestions(text: "java", isNewText: true, completion: { result in
            switch result {
            case .success:
                successResponse = true
            case .failure:
                successResponse = false
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(successResponse)
    }
    
    func testFetchQuestionsClientError() {
        guard let data = JSONDataLoader().loadJSONData(file: "SearchQuestionResponse") else { return }
        session?.data = data
        session?.response = URLResponseMock.clientError.response
        var successResponse = false
        let exp = expectation(description: "loading url")
        interactor?.fetchQuestions(text: "java", isNewText: true, completion: { result in
            switch result {
            case .success:
                successResponse = true
            case .failure:
                successResponse = false
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(successResponse)
    }
    
    func testFetchQuestionsServerError() {
        guard let data = JSONDataLoader().loadJSONData(file: "SearchQuestionResponse") else { return }
        session?.data = data
        session?.response = URLResponseMock.serverError.response
        var successResponse = false
        let exp = expectation(description: "loading url")
        interactor?.fetchQuestions(text: "java", isNewText: true, completion: { result in
            switch result {
            case .success:
                successResponse = true
            case .failure:
                successResponse = false
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(successResponse)
    }
    
    func testFetchQuestionsJSONError() {
        guard let data = JSONDataLoader().loadJSONData(file: "EmptyJSON") else { return }
        session?.data = data
        session?.response = URLResponseMock.success.response
        var successResponse = false
        let exp = expectation(description: "loading url")
        interactor?.fetchQuestions(text: "java", isNewText: true, completion: { result in
            switch result {
            case .success:
                successResponse = true
            case .failure:
                successResponse = false
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(successResponse)
    }
    
    func testPageCounter() {
        for _ in 1...3 {
            interactor?.fetchQuestions(text: "", isNewText: false, completion: { _ in })
        }
        XCTAssertEqual(3, interactor?.pageCounter)
    }

}
