//
//  RoomType.swift
//  Africa registration
//
//  Created by Igor Shelginskiy on 9/27/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var room = [
        RoomType(id: 0, name: "One bed room", shortName: "1B", price: 50),
        RoomType(id: 1, name: "Two beds room", shortName: "2B", price: 75),
        RoomType(id: 2, name: "Lux", shortName: "1L", price: 150)
    ]
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}
