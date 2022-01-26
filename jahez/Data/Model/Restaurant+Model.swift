//
//  Restaurant+Model.swift
//  jahez
//
//  Created by hammam abdulaziz on 23/06/1443 AH.
//

import Foundation

struct Restaurant: Codable {
    let id: Int
    let name, description, hours, image: String
    let rating: Float
    let distance: Double
    let hasOffer: Bool
}

extension Restaurant{
    static func getData(delegate: BaseView?,_ completion: @escaping Response<[Restaurant],ModelError<MultiError>>) -> Void {
        Router.RestaurantRouter.getRestaurants.request(viewToShowActivity: delegate, completion: completion)
    }
}
