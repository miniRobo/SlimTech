//
//  Settings+CoreDataProperties.swift
//  SlimTech
//
//  Created by Dawsen Richins on 3/30/17.
//  Copyright © 2017 Droplet. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings");
    }

    @NSManaged public var percentCap: Double
    @NSManaged public var dailyUsage: String?

}
