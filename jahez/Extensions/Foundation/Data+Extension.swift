//
//  Data+Extension.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

extension Data{
    func getObject() -> String {
        do{
            let jsonData = try JSONSerialization.jsonObject(with: self, options: [])
            if let dictionary = jsonData as? [String: Any]{
                return dictionary.json
            }else if let array = jsonData as? [[String: Any]]{
                return array.enumerated().reduce("", { $0 + "\n index=\($1.0) \n \($1.1.json)"})
            }else{
                return String(bytes: self, encoding: .utf8) ?? "no data found"
            }
        } catch {
            return String(bytes: self, encoding: .utf8) ?? "no data found"
        }
    }
    
    func getKeys() -> [String]? {
        do{
            let jsonData = try JSONSerialization.jsonObject(with: self, options: [])
            let dictionary = jsonData as? [String: Any]
            return dictionary?.getKeys
        } catch {
            return nil
        }
    }
}
