//
//  Dictionary+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

extension Dictionary {
    
    /// Converting the dictionary to string
    ///
    /// - Author: Hammam Abdulaziz
    var json: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? "Not a valid JSON"
        } catch {
            return "Not a valid JSON"
        }
    }
}

extension Dictionary where Key == String {
    var getKeys: [String]{
        var keys: [String] = []
        for (key,_) in self{
            keys.append(key)
        }
        return keys
    }
}
