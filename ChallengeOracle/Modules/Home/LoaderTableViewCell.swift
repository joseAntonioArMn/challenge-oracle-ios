//
//  LoaderTableViewCell.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import UIKit

class LoaderTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp() {
        loaderView.startAnimating()
    }
    
}
