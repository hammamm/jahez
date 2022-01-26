//
//  MultiError+Model.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

enum MultiError: Codable {
    case laravel([String:[String]]), string(String)
    
    init(from decoder: Decoder) throws {
        if let laravel = try? decoder.singleValueContainer().decode([String:[String]].self) {
            self = .laravel(laravel)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    enum QuantumError:Error {
        case missingValue
    }
    
    func getErrorMessage(_ keys: [String]? = nil) -> String? {
        // cast the laravel error wich some time return a message of object no string
        switch self {
        case .laravel(let value):
            // get the paramters and check if there is error just reutrn it
            for key in keys ?? []{
                if let errorMessage = value[key]{
                    return errorMessage.first
                }
            }
            return nil
        case .string(let value): return value
        }
    }
}
