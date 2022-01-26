//
//  StatusCode+Model.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

struct StatusCodeModel: Codable {
    private var statusCode: Int?
    private var status: Int?
    
    var code: Int{
        statusCode ?? status ?? 0
    }
}
