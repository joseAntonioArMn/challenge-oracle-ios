//
//  HTTP.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum ParameterEncoding: Equatable {
    case json
}

enum HTTPMethod: String, Equatable, Codable {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

struct HTTPRequest {
    var method: HTTPMethod
    var headers: [String: String]
    var parameters: Encodable?
    var parameterEncoding: ParameterEncoding?
    var timeout: TimeInterval?
    var url: URL

    init(url: URL,
         parameters: Encodable? = nil,
         parameterEncoding: ParameterEncoding? = nil,
         headers: [String: String] = [:],
         method: HTTPMethod = .get,
         timeout: TimeInterval? = nil) {
        self.url = url
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
        self.headers = headers
        self.method = method
        self.timeout = timeout
    }
}

struct HTTPResponse {
    let request: HTTPRequest
    let response: HTTPURLResponse
    let body: Data?
    let error: Error?

    var isSuccess: Bool { return 200 ..< 300 ~= response.statusCode }

    init(request: HTTPRequest, response: HTTPURLResponse, body: Data? = nil, error: Error? = nil) {
        self.request = request
        self.response = response
        self.body = body
        self.error = error
    }
}
