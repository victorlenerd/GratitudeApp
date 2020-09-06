//
//  Note+CoreDataProperties.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-06.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var text: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var isPublic: Bool
    @NSManaged public var likes: Int64
    @NSManaged public var updateDate: Date?
    @NSManaged public var uuid: UUID?
    @NSManaged public var views: Int64
    @NSManaged public var ownerID: String?
    @NSManaged public var media: Data?

}
