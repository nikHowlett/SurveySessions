//
//  thirdQuestion.swift
//  SurveySession
//
//  Created by MAC-ATL019922 on 7/17/15.
//  Copyright © 2015 nikhowlett. All rights reserved.
//

import WatchKit
import Foundation

class thirdQuestion: WKInterfaceController {
        
    var painnumber = 3
    var janet = "Good"
    var Nub = 1
    
    @IBOutlet var thisALabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        //if let diang = context as? sendables {
        //  println("this worked \(diang.dataName)")
        //}
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    @IBAction func sendthatshit() {
        let date = NSDate()
        let vrun = "I would say I am \(Nub) out of ten tired."
        let total = "\(date) \(janet)"
        let dict: Dictionary = ["message": total]
        print("datahasbeensent", appendNewline: false)
        WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in print("Data has been sent to target: parent iOS app - UCB Pharma", appendNewline: false)
        })
    }
    /*
    @IBAction func SubmitData() {
    var imcompilingshit = "\(date) \(michaelnorris)"
    let dict: Dictionary = ["message": imcompilingshit]
    WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in println("Data has been sent to target: parent iOS app - UCB Pharma")
    })
    }
    */
    /*var userInfo = [
    "scheduleLocalNotification": true,
    "category": "someCategory",
    "alertTitle": "How was your sleep:",
    "alertBody": "How was your sleep",
    "fireDate": NSDate(timeIntervalSinceNow: 6),
    "applicationIconBadgeNumber": 1,
    "soundName": UILocalNotificationDefaultSoundName
    ]
    
    // Register notifications in iOS
    WKInterfaceController.openParentApplication(userInfo) {
    (replyInfo, error) -> Void in
    // Callback here if needed
    }
    */
    /*@IBAction func painslider(value: Float) {
    Nub = Int(value * 1)
    janet = "Tiredness: \(Nub)"
    painlabel.setText
    //this is a test(janet)
    }
    @IBAction func painslider(value: Float) {
        Nub = Int(value * 1)
        janet = "Tiredness: \(Nub)"
        painlabel.setText(janet)
    }*/
    
    @IBAction func SlideGagement(value: Float) {
        Nub = Int(value * 1)
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
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        /*if segueIdentifier == "sch" {
        println("the pain has been sent")
        return sendables(dataname: "I would say I am \(Nub) out of ten tired.")
        }*/
        let date = NSDate()
        let vrun = "I would say I am \(Nub) out of ten tired."
        let total = "\(date) \(janet)"
        let dict: Dictionary = ["message": total]
        print("datahasbeensent", appendNewline: false)
        WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in print("Data has been sent to target: parent iOS app - UCB Pharma", appendNewline: false)
        })
        //println("the pain has not been sent!")
        return sendables(dataname: "I am not experiencing any pain currently.")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
