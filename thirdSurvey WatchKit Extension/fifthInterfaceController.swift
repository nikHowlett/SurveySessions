//
//  fifthInterfaceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class fifthInterfaceController: WKInterfaceController {

    /*lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }*/

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    /*override func contextForSegueWithIdentifier(segueIdentifier: String,
        inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
            if segueIdentifier == "SessionDeets" {
                let thissesh = sessions[rowIndex]
                return thissesh
            }
            
            return nil
    }*/
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
