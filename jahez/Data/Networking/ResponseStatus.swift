//
//  ResponseStatus.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit
import Moya

typealias Response<T: Decodable,E: Codable> = (ResponseStatus<T,E>) -> Void

enum ResponseStatus<T: Decodable,E: Codable> {
    case success(T)
    case failure(E,[String]?)
    case networkError(NSError?)
    
    func getObject(_ delegate: BaseView, callAgain: Completion?, successCompletion: (T) -> Void) {
        switch self {
            case .success(let object):
                successCompletion(object)
            case .failure: break
//                if let error = error as? ModelError<MultiError>{
//                    delegate.didFailWithError(error.getError(params))
//                }
            case .networkError: break
//                if delegate.didFailWithNetworkError(error) {
//                    NetworkQueue.enqueue(NetworkObject({
//                        callAgain()
//                    }))
//                }
        }
    }
}


