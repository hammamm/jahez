//
//  Moya.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation
import Moya

extension TargetType{
    var baseURL: URL { URL(string: "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/")! }
    var headers: [String : String]? { nil }
    
    func request<T: Decodable,E: Codable>(viewToShowActivity: BaseView? = nil, completion: @escaping Response<T,E>) {
        NetworkService.getDataFromRequest(target: self, viewToShowActivity: viewToShowActivity, completion: completion)
    }
}

enum MoyaNetworkResponse {
    case success(Data)
    case failure(MoyaError)
}

extension MoyaError{
    var errorObject: NSError? {
        switch self {
            case .imageMapping: return nil
            case .jsonMapping: return nil
            case .stringMapping: return nil
            case .objectMapping(let error, _): return error as NSError
            case .encodableMapping(let error): return error as NSError
            case .statusCode: return nil
            case .underlying(let error, _): return error as NSError
            case .requestMapping: return nil
            case .parameterEncoding(let error): return error as NSError
        }
    }
}

extension Task{
    func getParametersNames() -> [String]? {
        switch self {
            case .requestJSONEncodable(let json), .requestCustomJSONEncodable(let json, _):
                do {
                    return try json.toDictionary().getKeys
                } catch {
                    return nil
                }
            case .requestParameters(let parameters, _), .downloadParameters(let parameters, _, _):
                return parameters.getKeys
            case .requestCompositeData(let bodyData, let urlParameters):
                return (bodyData.getKeys() ?? []) + urlParameters.getKeys
            case .requestCompositeParameters(let bodyParameters,_, let urlParameters):
                return bodyParameters.getKeys + urlParameters.getKeys
            case .uploadMultipart(let data):
                return data.map({ $0.name })
            case .uploadCompositeMultipart(let data, let urlParameters):
                return data.map({ $0.name }) + urlParameters.getKeys
            case .requestData(let data):
                return data.getKeys() ?? []
            case .uploadFile, .downloadDestination, .requestPlain: return nil
        }
    }
}
