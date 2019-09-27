//
//  Registration.swift
//  Africa registration
//
//  Created by Igor Shelginskiy on 9/27/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emaiAdress: String
    
    var checkInDate: Date
    var checkOutdate: Date
    
    var numberOfAdult: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
    
    init(firstName: String = String(), lastName: String = String(), emailAdress: String = String(), checkInDate: Date = Date(), checkOutDate: Date = Date(), numberOfAdult: Int = Int(),numberOfChildren: Int = Int(), wifi: Bool = Bool(), roomType: RoomType = RoomType(id: Int(), name: String(), shortName: String(), price: Int())
         ) {
        self.firstName = firstName
        self.lastName = lastName
        self.emaiAdress = emailAdress
        self.checkInDate = checkInDate
        self.checkOutdate = checkOutDate
        self.numberOfAdult = numberOfAdult
        self.numberOfChildren = numberOfChildren
        self.roomType = roomType
        self.wifi = wifi
    }
}


 
