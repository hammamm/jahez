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

extension Encodable {
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}

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
