//
//  EndPointsTests.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import XCTest
@testable import ChallengeOracle

class EndPointsTests: XCTestCase {
        
    func testSearchQuestionsEndPoint() {
        let endpoint: UserEndpoints = .searchQuestion(text: "pyTHon", page: 10)
        XCTAssertEqual(endpoint.url.absoluteString, "https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=python&pagesize=10&page=10")
    }
    
    func testQuestionDetailEndPoint() {
        let endpoint: UserEndpoints = .questionDetail(id: 12345)
        XCTAssertEqual(endpoint.url.absoluteString, "https://api.stackexchange.com/2.2/questions/12345?site=stackoverflow")
    }

}
