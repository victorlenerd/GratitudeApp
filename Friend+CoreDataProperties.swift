//
//  Friend+CoreDataProperties.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var name: String?

}
