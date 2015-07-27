//
//  Activity.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/24/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import Foundation
import CoreData

@objc(Activity)
class Activity: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var Message: String
    
}

