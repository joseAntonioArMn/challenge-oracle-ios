//
//  UserEndpoints.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

enum UserEndpoints {
    case searchQuestion(text: String, page: Int)
    case questionDetail(id: Int)

    var url: URL {
        var host = "https://api.stackexchange.com"
        
        switch self {
        case .searchQuestion(let text, let page):
            host.append("/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=\(text.lowercased())&pagesize=10&page=\(page)")
        case .questionDetail(let id):
            host.append("/2.2/questions/\(id)?site=stackoverflow") // Not needed..
        }

        guard let percentString = host.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: percentString) else {
            fatalError()
        }
        return url
    }
}
