//
//  Session.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import Foundation
import CoreData

@objc(Session)
class Session: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var presenter: String
    @NSManaged var time: NSDate
    
}
