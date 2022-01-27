//
//  HTTPTask.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

class HTTPTask {
    var request: HTTPRequest
    var completion: (HTTPResult) -> Void
    private var cancelHandler: (() -> Void)?

    init(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        self.request = request
        self.completion = completion
    }

    func cancel() {
        cancelHandler?()
    }

    func setCancelHandler(_ cancelHandler: @escaping () -> Void) {
        self.cancelHandler = cancelHandler
    }
}
