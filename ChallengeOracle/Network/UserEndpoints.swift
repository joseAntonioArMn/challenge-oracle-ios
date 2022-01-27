//
//  UserEndpoints.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum UserEndpoints {
    case searchQuestion(text: String)
    case questionDetail

    var url: URL {
        var host = "https://api.stackexchange.com"
        
        switch self {
        case .searchQuestion(let text):
            host.append("/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=\(text)&pagesize=10")
        case .questionDetail:
            host.append("/2.2/questions/56433665?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10&filter=!9_bDDxJY5")
        }

        guard let url = URL(string: host) else {
            fatalError()
        }
        return url
    }
}
