//
//  MyChats+CoreDataProperties.swift
//  ChatApp
//
//  Created by Admin on 12/02/24.
//
//

import Foundation
import CoreData


extension MyChats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyChats> {
        return NSFetchRequest<MyChats>(entityName: "MyChats")
    }

    @NSManaged public var message: String?
    @NSManaged public var isUser: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isPined: Bool

}

extension MyChats : Identifiable {

}
