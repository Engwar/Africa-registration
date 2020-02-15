//
//  CurrentClient+CoreDataProperties.swift
//  Africa registration
//
//  Created by Igor Shelginskiy on 2/16/20.
//  Copyright © 2020 Igor Shelginskiy. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrentClient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentClient> {
        return NSFetchRequest<CurrentClient>(entityName: "CurrentClient")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var wifi: Bool
    @NSManaged public var emailAdress: String?
    @NSManaged public var roomType: RoomType?
    @NSManaged public var numberOfChild: Int16
    @NSManaged public var numberOfAdults: Int16
    @NSManaged public var checkOutDate: Date?
    @NSManaged public var checkInDate: Date?
    @NSManaged public var lastName: String?

}
