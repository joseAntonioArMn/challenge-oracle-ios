//
//  DetailPresenter.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var wireframe: DetailWireframeProtocol? { get set }
    
    /// View --> Presenter
}

protocol DetailInteractorOutputProtocol: AnyObject {
    /// Interactor --> Presenter
}

class DetailPresenter: DetailPresenterProtocol, DetailInteractorOutputProtocol {
    
    // MARK: VIPER Properties
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var wireframe: DetailWireframeProtocol?
    
    // MARK: View --> Presenter
    
    // MARK: Interactor --> Presenter
}
