//
//  UserTableViewCell.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        reputationLabel.font = UIFont.systemFont(ofSize: 12)
        userImageView.layer.cornerRadius = 5.0
    }
    
    func setUp(withOwner owner: Owner) {
        nameLabel.text = owner.name
        reputationLabel.text = "\(owner.reputation)"
        userImageView.findImage(stringURL: owner.imageURL)
    }
    
}
