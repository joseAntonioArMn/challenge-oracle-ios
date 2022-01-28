//
//  QuestionTableViewCell.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answersImageView: UIImageView!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var viewsImageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var buttonImageView: UIImageView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tagsLabel.font = UIFont.boldSystemFont(ofSize: 13)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        scoreLabel.font = UIFont.systemFont(ofSize: 16)
        answersLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        
        titleLabel.textColor = .black
        tagsLabel.textColor = .link
        dateLabel.textColor = .darkGray
        scoreLabel.textColor = .link
        answersLabel.textColor = .link
        viewsLabel.textColor = .link
        
        titleLabel.numberOfLines = 0
        tagsLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        separatorView.backgroundColor = .lightGray
    }
    
    // MARK: Public Methods
    func setUp(withQuestion question: Question, isSelectable: Bool = true) {
        titleLabel.text = question.title
        tagsLabel.text = "\(question.tags)"
        dateLabel.text = "\(question.creationDate)"
        scoreLabel.text = "\(question.score)"
        answersLabel.text = "\(question.answersCount)"
        viewsLabel.text = "\(question.viewsCount)"
        buttonImageView.isHidden = !isSelectable
        separatorView.isHidden = !isSelectable
    }
    
}
