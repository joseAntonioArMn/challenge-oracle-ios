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
    func displayQuestionsItems(questionItems: [QuestionItem])
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
    private var questionItems: [QuestionItem] = []
    
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
        questionsTableView.register(LoaderTableViewCell.nib, forCellReuseIdentifier: LoaderTableViewCell.identifier)
    }
    
    func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    func displayQuestionsItems(questionItems: [QuestionItem]) {
        self.questionItems = questionItems
        DispatchQueue.main.async { [weak self] in
            self?.questionsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let questionItem = questionItems[indexPath.row]
        switch questionItem.type {
        case .question:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell,
               let questionCellItem = questionItem as? QuestionCellItem {
                cell.setUp(withQuestion: questionCellItem.question)
                return cell
            }
        case .loader:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LoaderTableViewCell.identifier, for: indexPath) as? LoaderTableViewCell,
               let _ = questionItem as? LoaderCellItem {
                cell.setUp()
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionItem = questionItems[indexPath.row]
        presenter?.didSelectQuestionItem(questionItem: questionItem)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayCell(withIndexPath: indexPath)
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
