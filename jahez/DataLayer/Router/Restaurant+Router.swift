//
//  Restaurant+Router.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation
import Moya

extension Router{
    enum RestaurantRouter: TargetType{
        case getRestaurants
        
        var path: String{
            switch self {
                case .getRestaurants: return "restaurants.json"
            }
        }
        
        var method: Moya.Method{
            switch self {
                case .getRestaurants: return .get
            }
        }
        
        var task: Task{
            switch self {
                case .getRestaurants: return .requestPlain
            }
        }
    }
}
