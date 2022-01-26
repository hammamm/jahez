//
//  Model+Error.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

struct ModelError<T: Codable> : Codable {
    let status: Int?
    let msg: T
    let data: [String?]?
    let error: String?
    
    func getError(_ keys: [String]?) -> String {
        if let msg = msg as? MultiError{
            return msg.getErrorMessage(keys) ?? errorDescription()
        }else{
            return "Something wrong"
        }
    }

    init(msg: T) {
        self.msg = msg
        status = nil
        data = nil
        error = nil
    }
}

extension ModelError: Error, LocalizedError {
        
    func errorDescription(_ key: String? = nil) -> String {
        // cast the laravel error wich some time return a message of object no string
        if let key = key {
            if let object = msg as? [String: Any], let errorMessage = object[key] as? [String]{
                return errorMessage.first ?? localizedDescription
            }else if let object = msg as? [String: Any], let errorMessage = object[key] as? String{
                return errorMessage
            }else{
                return localizedDescription
            }
        }else{
            if let errorMessage = msg as? String{
                return errorMessage
            }else{
                return localizedDescription
            }
        }
    }
}
