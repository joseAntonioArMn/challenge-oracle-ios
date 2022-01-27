//
//  DetailViewController.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    /// Presenter --> View
}

class DetailViewController: UIViewController, DetailViewProtocol {
    
    // MARK: VIPER Properties
    var presenter: DetailPresenterProtocol?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DETAIL LOADED!")
    }

}
