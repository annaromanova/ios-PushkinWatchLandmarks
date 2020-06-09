//
//  ItemCD+CoreDataProperties.swift
//  Pushkin WatchLandmarks Extension
//
//  Created by RAS on 04.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import Foundation
import CoreData


extension ItemCD: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCD> {
        return NSFetchRequest<ItemCD>(entityName: "ItemCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var address: String?
    @NSManaged public var longitude: Float
    @NSManaged public var latitude: Float
    @NSManaged public var descript: String?
    @NSManaged public var site: URL?
    @NSManaged public var isVisited: Bool
    @NSManaged public var img: Data?
    
}
