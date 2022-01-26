//
//  NetworkService.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import UIKit
import Moya

class NetworkService {
    
    static func getDataFromRequest<T: Decodable,E: Codable>(target: TargetType, viewToShowActivity: BaseView?, completion: @escaping Response<T,E>) {
        NetworkService.request(target: target, networkActivityClosure: { activityType in
            if let view = viewToShowActivity {
                view.loading(activityType == .began)
            }
        }) { result in
            switch result {
                case .success(let data):
                    var statusObject: StatusCodeModel?
                    do {
                        // if there is status code in the api so need to check it before success otherwise go to success direct
                        statusObject = try JSONDecoder().decode(StatusCodeModel.self, from: data)
                    }catch{
                        statusObject = StatusCodeModel()
                    }
                    guard statusObject?.code == 200 || statusObject?.code == 0 else {
                        // if code 200 so go to success otherwise go to error
                        do {
                            let error = try JSONDecoder().decode(E.self, from: data)
                            completion(.failure(error, target.task.getParametersNames()))
                        } catch let error {
                            completion(.failure(ModelError(msg: error.localizedDescription) as! E, target.task.getParametersNames()))
                        }
                        // here if i want to handle some errors api like delete current user info
                        return
                    }
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(object))
                    } catch let error {
                        completion(.failure(ModelError(msg: error.localizedDescription) as! E, target.task.getParametersNames()))
                    }
                case .failure(let error):
                    completion(.networkError(error.errorObject))
            }
        }
    }

    private static func request(target: TargetType, networkActivityClosure: @escaping ((NetworkActivityChangeType) -> Void), completion: @escaping (MoyaNetworkResponse) -> Void) {
        MoyaProvider<MultiTarget>(plugins: [
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
            NetworkActivityPlugin(networkActivityClosure: { change, target in
                networkActivityClosure(change)
            })
        ]).request(.target(target), callbackQueue: .main, completion: { result in
            switch result{
                case .success(let object):
                    completion(.success(object.data))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
