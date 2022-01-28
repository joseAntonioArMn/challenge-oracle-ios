//
//  HomeRouterMock.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit
@testable import ChallengeOracle

class HomeRouterMock: HomeWireframeProtocol {
    var presentDetailModuleCalls = 0
    
    static func getHomeModule() -> UIViewController {
        return UIViewController()
    }
    
    func presentDetailModule(withQuestion question: Question, fromViewController viewController: UIViewController) {
        presentDetailModuleCalls += 1
    }
    
    
}
