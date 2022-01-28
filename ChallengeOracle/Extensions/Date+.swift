//
//  Date+.swift
//  ChallengeOracle
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

extension Date {
    init(seconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    func getFormattedDate(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
