//
//  secondQuestion.swift
//  SurveySession
//
//  Created by MAC-ATL019922 on 7/17/15.
//  Copyright © 2015 nikhowlett. All rights reserved.
//

import WatchKit
import Foundation

class secondQuestion: WKInterfaceController {
    
    var diang: String = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let ciang = context as? sendables {
            print("this worked \(ciang.dataName)")
            diang = ciang.dataName
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        if segueIdentifier == "yesRelevant" {
            return sendables(dataname: "\(diang) Yes, this session was relevant to my position.")
        } else if segueIdentifier == "notRelevant" {
            return sendables(dataname: "\(diang) I did not find this session revelent to my position.")
        } else {
            return sendables(dataname: "\(diang) Inconclusive")
        }
    }
    
}
