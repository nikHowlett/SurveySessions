//
//  thirdQuestionInterfaceController.swift
//  surveysbeacons2
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright © 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation


class thirdQuestionInterfaceController: WKInterfaceController {

    @IBOutlet var thisALabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    @IBAction func f(value: Float) {
        var Nub = Int(value * 1)
        var janet: String = ""
        if Nub == 0 {
            janet = "Unengaging"
        } else if Nub == 1 {
            janet = "Uninteresting"
        } else if Nub == 2 {
            janet = "Sub-Par"
        } else if Nub == 3 {
            janet = "Good"
        } else if Nub == 4 {
            janet = "Very Good"
        } else if Nub == 5 {
            janet = "Extremely Engaging"
        }
        thisALabel.setText(janet)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
