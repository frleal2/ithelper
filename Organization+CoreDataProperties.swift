//
//  Organization+CoreDataProperties.swift
//  itHelper2.0
//
//  Created by Felipe on 2/23/20.
//  Copyright © 2020 division. All rights reserved.
//
//

import Foundation
import CoreData


extension Organization: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Organization> {
        return NSFetchRequest<Organization>(entityName: "Organization")
    }

    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var favorites: Bool
    @NSManaged public var logo: Data
    @NSManaged public var name: String
    @NSManaged public var state: String
    @NSManaged public var type: String
    @NSManaged public var zip: Int16
    @NSManaged public var contact: NSSet
    
    public var wrappedName: String{
        return name
    }
    
    public var contactArray: [Contact]{
        let set = contact as? Set<Contact> ?? []
        
        return set.sorted {
            $0.wrappedFirstName < $1.wrappedFirstName
        }
    }

}

// MARK: Generated accessors for contact
extension Organization {

    @objc(addContactObject:)
    @NSManaged public func addToContact(_ value: Contact)

    @objc(removeContactObject:)
    @NSManaged public func removeFromContact(_ value: Contact)

    @objc(addContact:)
    @NSManaged public func addToContact(_ values: NSSet)

    @objc(removeContact:)
    @NSManaged public func removeFromContact(_ values: NSSet)

}
