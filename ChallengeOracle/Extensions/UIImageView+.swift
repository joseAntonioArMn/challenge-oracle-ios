//
//  UIImageView+.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func findImage(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        if let imageData = ImageCacheHelper.shared.images.object(forKey: url.absoluteString as NSString) {
            self.image = UIImage(data: imageData as Data)
        } else {
            fetchImage(fromURL: url)
        }
    }
    
    private func fetchImage(fromURL url: URL) {
        let networkClient: NetworkClientType = NetworkClient()
        networkClient.downloadImage(url: url) {[weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
}
