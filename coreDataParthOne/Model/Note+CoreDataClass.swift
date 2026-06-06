//
//  Note+CoreDataClass.swift
//  coreDataParthOne
//
//  Created by Максим Минаков on 06.06.2026.
//
//

public import Foundation
public import CoreData

public typealias NoteCoreDataClassSet = NSSet

@objc(Note)
public class Note: NSManagedObject { }

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var data: Date?

}

extension Note : Identifiable {

}

