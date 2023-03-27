//
//  StringExtension.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 24.03.2023.
//

import Foundation
import CryptoKit

extension String {
    func sha256() -> String {
        let inputData = Data(self.utf8)
        let hashed = SHA256.hash(data: inputData)
        let string = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return string
    }
    
    func getStringDifference(_ string: String) -> String? {
        if string.count > self.count {
            return nil
        }
        var returnedString: String?
        if let range = self.range(of: string) {
            returnedString = string.replacingCharacters(in: range, with: "")
        }
        return returnedString
    }
    
    func contaisSubstring(_ string: String) -> Bool {
        let lowercasedString = self.lowercased()
        if lowercasedString.range(of: "hey \(string.lowercased())") != nil {
            return true
        }
        return false
    }
}
