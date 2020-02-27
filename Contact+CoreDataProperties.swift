//
//  Contact+CoreDataProperties.swift
//  itHelper2.0
//
//  Created by Felipe on 2/23/20.
//  Copyright © 2020 division. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var phone: String
    @NSManaged public var email: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var organization: Organization
    
    public var wrappedFirstName: String {
        return firstName
    }

}
