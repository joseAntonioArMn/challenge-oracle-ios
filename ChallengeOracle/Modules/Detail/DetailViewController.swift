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
    func setUpUI()
    func setUpTableView()
    func displayDetailItems(detailItems: [DetailItem])
}

class DetailViewController: UIViewController, DetailViewProtocol {
    
    // MARK: VIPER Properties
    var presenter: DetailPresenterProtocol?
    
    // MARK: Private Properties
    private var detailItems: [DetailItem] = []
    
    // MARK: Outlets
    @IBOutlet weak var detailsTableView: UITableView!
    
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
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.separatorColor = UIColor.clear
        detailsTableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
        detailsTableView.register(QuestionTableViewCell.nib, forCellReuseIdentifier: QuestionTableViewCell.identifier)
    }
    
    func displayDetailItems(detailItems: [DetailItem]) {
        self.detailItems = detailItems
        detailsTableView.reloadData()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailItem = detailItems[indexPath.row]
        switch detailItem.type {
        case .user:
            if let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell,
               let userItem = detailItem as? DetailUserItem {
                cell.setUp(withOwner: userItem.user)
                return cell
            }
        case .question:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell,
               let questionItem = detailItem as? DetailQuestionItem {
                cell.setUp(withQuestion: questionItem.question, isSelectable: false)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailItem = detailItems[indexPath.row]
        presenter?.didSelectDetailItem(detailItem: detailItem)
    }
}
