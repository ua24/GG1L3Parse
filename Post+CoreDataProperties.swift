//
//  Post+CoreDataProperties.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/19/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var photo: NSData?
    @NSManaged public var text: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for comments
extension Post {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
