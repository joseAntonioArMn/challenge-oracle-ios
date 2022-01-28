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
    var title: String { get }
    func viewDidLoad()
    func didSelectDetailItem(detailItem: DetailItem)
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
    var title: String {
        return interactor?.moduleTitle ?? ""
    }
    
    func viewDidLoad() {
        view?.setUpUI()
        view?.setUpTableView()
        view?.displayDetailItems(detailItems: buildDetailItems())
    }
    
    func didSelectDetailItem(detailItem: DetailItem) {
        guard let _ = detailItem as? DetailUserItem,
              let link = interactor?.userLink else { return }
        wireframe?.goToLink(link: link)
    }
    
    // MARK: Interactor --> Presenter
    // add if needed..
    
    // MARK: Private Methods
    private func buildDetailItems() -> [DetailItem] {
        guard let question = interactor?.currentQuesion, let user = interactor?.owner else { return [] }
        let userItem = DetailUserItem(user: user)
        let questionItem = DetailQuestionItem(question: question)
        let detailItems: [DetailItem] = [userItem, questionItem]
        return detailItems
    }
}
