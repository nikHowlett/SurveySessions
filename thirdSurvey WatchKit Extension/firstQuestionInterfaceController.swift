//
//  firstQuestionInterfaceController.swift
//  surveysbeacons2
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright © 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation


class firstQuestionInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        if segueIdentifier == "wasUseful" {
            return sendables(dataname: "I found this session beneficial.")
        } else if segueIdentifier == "notUseful" {
            return sendables(dataname: "I did not find this session beneficial.")
        } else {
            return sendables(dataname: "Inconclusive")
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
    /* //
    //  firstQuestion.swift
    //  SurveySession
    //
    //  Created by MAC-ATL019922 on 7/17/15.
    //  Copyright © 2015 nikhowlett. All rights reserved.
    //
    
    import WatchKit
    import Foundation
    
    class firstQuestion: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
    if segueIdentifier == "wasUseful" {
    return sendables(dataname: "I found this session beneficial.")
    } else if segueIdentifier == "notUseful" {
    return sendables(dataname: "I did not find this session beneficial.")
    } else {
    return sendables(dataname: "Inconclusive")
    }
    }
    
    override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
    }
    }
*/
}
