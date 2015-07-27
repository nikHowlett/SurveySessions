//
//  2InterfaceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation


class secondInterfaceController: WKInterfaceController {
    
    var lastpart: String = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let diang = context as? sendables {
            lastpart = diang.dataName
            print(lastpart)
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        if segueIdentifier == "2y" {
            return sendables(dataname: "\(lastpart)y+")
        } else if segueIdentifier == "2n" {
            return sendables(dataname: "\(lastpart)n+")
        } else {
            return sendables(dataname: "\(lastpart)n+")
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
