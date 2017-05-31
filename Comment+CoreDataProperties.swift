//
//  Comment+CoreDataProperties.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/22/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var user: User?

}
