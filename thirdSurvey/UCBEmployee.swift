//
//  UCBEmployee.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import Foundation
import CoreData

@objc(UCBEmployee)
class UCBEmployee: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var corporateAccount: String
    @NSManaged var presenter: Bool
    
}