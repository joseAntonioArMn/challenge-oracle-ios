//
//  HTTPLoader.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum HTTPLoaderError: Error {
    case unknown
    case requestFailed
    case badURL
    case timeout
}

typealias HTTPResult = Result<HTTPResponse, HTTPLoaderError>

protocol HTTPLoader {
    var nextLoader: HTTPLoader? { get }
    func load(task: HTTPTask)
    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) -> HTTPTask
}

extension HTTPLoader {
    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) -> HTTPTask {
        let task = HTTPTask(request: request, completion: completion)
        load(task: task)
        return task
    }
}

extension HTTPLoaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknwon HttpLoader Error"
        case .requestFailed:
            return "HTTPLoader request has failed"
        case .badURL:
            return "HTTPLoader bad URL found"
        case .timeout:
            return "HTTPLoader request timed out"
        }
    }
}
