//
//  NetworkClientMock.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
@testable import ChallengeOracle

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    private let resumeClosure: () -> Void
    private var cancelClosure: (() -> Void)?
    
    init(resumeClosure: @escaping () -> Void) {
        self.resumeClosure = resumeClosure
    }
    
    func resume() {
        resumeClosure()
    }
    
    func cancel() {}
}

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskProtocol {
        let data = self.data
        let error = self.error
        let response = self.response
        
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

enum URLResponseMock {
    case success
    case clientError
    case serverError
    
    var response: HTTPURLResponse? {
        switch self {
        case .success:
            return HTTPURLResponse(url: URL(string: "https://api.stackexchange.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        case .clientError:
            return HTTPURLResponse(url: URL(string: "https://api.stackexchange.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        case .serverError:
            return HTTPURLResponse(url: URL(string: "https://api.stackexchange.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        }
    }
}
