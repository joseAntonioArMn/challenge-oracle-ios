//
//  HomeViewController.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    /// Presenter --> View
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    // MARK: VIPER Properties
    var presenter: HomePresenterProtocol?

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HOME LOADED!")
    }

}
