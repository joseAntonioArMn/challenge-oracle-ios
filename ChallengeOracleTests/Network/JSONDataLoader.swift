//
//  JSONDataLoader.swift
//  ChallengeOracleTests
//
//  Created by José Antonio Arellano Mendoza on 27/01/22.
//

import Foundation

class JSONDataLoader {
   func loadJSONData(file: String) -> Data? {
       if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
           let jsonfileURL = URL(fileURLWithPath: jsonFilePath)
           if let jsonData = try? Data(contentsOf: jsonfileURL) {
               return jsonData
           }
       }
       return nil
   }
}
