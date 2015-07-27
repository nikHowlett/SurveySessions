//
//  1InterfaceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation


class firstInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        if segueIdentifier == "1y" {
            return sendables(dataname: "y+")
        } else if segueIdentifier == "1n" {
            return sendables(dataname: "n+")
        } else {
            return sendables(dataname: "n+")
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
