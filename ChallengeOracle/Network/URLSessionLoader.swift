//
//  URLSessionLoader.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import os

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol   {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class NetworkLoader: HTTPLoader {
    let nextLoader: HTTPLoader?

    init() {
        //More loaders if needed..
        nextLoader = URLSessionLoader()
    }

    func load(task: HTTPTask) {
        nextLoader?.load(task: task)
    }
}

class URLSessionLoader: HTTPLoader {

    var nextLoader: HTTPLoader?

    let session: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.session = urlSession
    }

    func load(task: HTTPTask) {
        var urlRequest = URLRequest(url: task.request.url, timeoutInterval: task.request.timeout ?? 60)

        urlRequest.allHTTPHeaderFields = task.request.headers
        urlRequest.httpMethod = task.request.method.rawValue

        if let parameterEncoding = task.request.parameterEncoding, let parameters = task.request.parameters {
            switch parameterEncoding {
            case .json:
                urlRequest.httpBody = try? parameters.toJSONData()
                urlRequest.allHTTPHeaderFields?["Content-Type"] = "application/json"
            }
        }

        let urlSessionTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let urlResponse = response as? HTTPURLResponse else {
                if let error = error {
                    if error._code == NSURLErrorTimedOut {
                        task.completion(.failure(.timeout))
                        return
                    }
                }
                task.completion(.failure(.requestFailed))
                return
            }

            task.completion(.success(HTTPResponse(request: task.request, response: urlResponse, body: data, error: error)))
        }

        urlSessionTask.resume()

        task.setCancelHandler {
            urlSessionTask.cancel()
        }
    }
}
