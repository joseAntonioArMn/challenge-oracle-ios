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
    
    // MARK: Private Properties
    private var questions: [Question] = []
    
    // MARK: Outlets
    @IBOutlet weak var questionsTableView: UITableView! {
        didSet {
            questionsTableView.dataSource = self
            questionsTableView.delegate = self
            questionsTableView.separatorColor = UIColor.clear
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

// MARK:  - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
