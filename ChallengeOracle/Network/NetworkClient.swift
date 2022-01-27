//
//  NetworkClient.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit.UIImage

enum NetworkClientError: Error {
    case unknown
    case requestFailed(HTTPResponse)
    case failedToParse(Error)
    case timedOut
}

struct JSONResponse<Type> {
    let decodedObject: Type
    let response: HTTPResponse
}

protocol NetworkClientType {

    @discardableResult
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)  -> HTTPTask

    @discardableResult
    func request(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) -> HTTPTask

    @discardableResult
    func decodedJSONRequest<ReturnType>(type: ReturnType.Type, request: HTTPRequest, completion: @escaping (Result<JSONResponse<ReturnType>, NetworkClientError>) -> Void) -> HTTPTask where ReturnType: Decodable
}

class NetworkClient: NetworkClientType {

    let httpLoader: HTTPLoader

    init(loader: HTTPLoader = NetworkLoader()) {
        httpLoader = loader
    }

    @discardableResult
    func request(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) -> HTTPTask {
        return httpLoader.load(request: request, completion: completion)
    }

    @discardableResult
    func decodedJSONRequest<ReturnType>(type: ReturnType.Type,
                                        request: HTTPRequest,
                                        completion: @escaping (Result<JSONResponse<ReturnType>, NetworkClientError>) -> Void) -> HTTPTask where ReturnType : Decodable {
        let task = HTTPTask(request: request) { result in
            self.handleJSONResponse(type: type, result: result, completion: completion)
        }
        httpLoader.load(task: task)
        return task
    }

    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> HTTPTask {
        let request = HTTPRequest(url: url)
        return httpLoader.load(request: request) { (result) in
            switch result {
            case .success(let response):
                if let data = response.body {
                    ImageCacheHelper.shared.images.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    completion(UIImage(data: data))
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}

extension NetworkClient {
    func handleJSONResponse<ReturnType>(type: ReturnType.Type,
                                        result: HTTPResult,
                                        completion: @escaping (Result<JSONResponse<ReturnType>, NetworkClientError>) -> Void) where ReturnType: Decodable {
        switch result {
        case .success(let response):
            let decoder = JSONDecoder()
            if response.isSuccess, let data = response.body {
                do {
                    let parsedObject = try decoder.decode(type, from: data)
                    completion(.success(JSONResponse(decodedObject: parsedObject, response: response)))
                } catch(let error) {
                    completion(.failure(.failedToParse(error)))
                }
            } else {
                completion(.failure(.requestFailed(response)))
            }
        case .failure(let error):
            if error == .timeout {
                completion(.failure(.timedOut))
            } else {
                completion(.failure(.unknown))
            }
        }
    }
}
