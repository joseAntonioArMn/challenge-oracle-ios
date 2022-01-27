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
    func setUpUI()
    func setUpTableView()
    func setUpSearchController()
    func displayQuestions(questions: [Question])
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    // MARK: VIPER Properties
    var presenter: HomePresenterProtocol?
    
    // MARK: Private Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: Private Properties
    private var questions: [Question] = []
    
    // MARK: Outlets
    @IBOutlet weak var questionsTableView: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: Presenter --> View
    func setUpUI() {
        self.title = presenter?.title
    }
    
    func setUpTableView() {
        questionsTableView.tableHeaderView = searchController.searchBar
        questionsTableView.dataSource = self
        questionsTableView.delegate = self
        questionsTableView.separatorColor = UIColor.clear
        questionsTableView.register(QuestionTableViewCell.nib, forCellReuseIdentifier: QuestionTableViewCell.identifier)
    }
    
    func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    func displayQuestions(questions: [Question]) {
        self.questions = questions
        DispatchQueue.main.async { [weak self] in
            self?.questionsTableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell {
            let question = questions[indexPath.row]
            cell.setUp(withQuestion: question)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else { return }
        presenter?.didEnterTextInSearchBar(text: text, isFiltering: isFiltering)
    }
}
