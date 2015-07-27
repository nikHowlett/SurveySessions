//
//  3InterfaceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation


class thirdInterfaceController: WKInterfaceController {

    //@IBOutlet weak var thisALabel: WKInterfaceLabel!
    @IBOutlet weak var thisAlabeel: WKInterfaceLabel!
    
    var lastpart: String = ""
    
    var janet = "Good"
    
    var Nub = 3
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let diang = context as? sendables {
            lastpart = diang.dataName
            print(lastpart)
        }
    }
    
    @IBAction func fun(value: Float) {
        self.Nub = Int(value * 1)
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
        thisAlabeel.setText(janet)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        let bub = "\(Nub)"
        return sendables(dataname: "\(bub)+")
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
