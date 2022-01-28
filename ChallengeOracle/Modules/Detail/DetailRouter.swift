//
//  DetailRouter.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol DetailWireframeProtocol: AnyObject {
    /// Presenter --> Wireframe
    static func presentDetailModule(withQuestion question: Question, fromViewController viewController: UIViewController)
    func goToLink(link: String)
}

class DetailWireframe: DetailWireframeProtocol {
    // MARK: Static Methods
    static func presentDetailModule(withQuestion question: Question, fromViewController viewController: UIViewController) {
        /// Generating VIPER elements
        let detailStoryboard = UIStoryboard(name: "DetailStoryboard", bundle: nil)
        let view = detailStoryboard.instantiateViewController(identifier: "DetailVC") as! DetailViewController
        let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
        let interactor: DetailInteractorInputProtocol = DetailInteractor(question: question)
        let wireframe: DetailWireframeProtocol = DetailWireframe()
        
        /// Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        /// Presenting
        viewController.navigationController?.pushViewController(view, animated: true)
    }
    
    // MARK: Presenter --> Router
    func goToLink(link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
