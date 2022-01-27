//
//  HomeRouter.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol HomeWireframeProtocol: AnyObject {
    static func getHomeModule() -> UIViewController
    /// Presenter --> Wireframe
}

class HomeWireframe: HomeWireframeProtocol {
    
    // MARK: Static Methods
    static func getHomeModule() -> UIViewController {
        /// Generating VIPER elements
        let homeStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = homeStoryboard.instantiateViewController(identifier: "HomeVC") as! HomeViewController
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        let wireframe: HomeWireframeProtocol = HomeWireframe()
        
        /// Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        /// Navigation
        let navigation = UINavigationController(rootViewController: view)
        
        return navigation
    }
    
    // MARK: Presenter --> Wireframe
}
