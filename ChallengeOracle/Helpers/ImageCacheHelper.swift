//
//  ImageCacheHelper.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

class ImageCacheHelper {
    static var shared: ImageCacheHelper = ImageCacheHelper()
    
    var images = NSCache<NSString, NSData>()
    
    private init() {}
}
