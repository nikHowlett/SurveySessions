//
//  emojis.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/23/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//


import WatchKit
import Foundation
 /* 😄😀😊😐😑😕😒😔😞😟😞😪😥😓😣😩😫😭 */
class emojis: WKInterfaceController {
    
    @IBOutlet weak var thisALabel: WKInterfaceLabel!
    
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
    
    @IBAction func f(value: Float) {
        self.Nub = Int(value * 1)
        var janet: String = ""
        if Nub == 0 {
            janet = "😣"
        } else if Nub == 1 {
            janet = "😟"
        } else if Nub == 2 {
            janet = "😐"
        } else if Nub == 3 {
            janet = "😊"
        } else if Nub == 4 {
            janet = "😀"
        } else if Nub == 5 {
            janet = "😄👍"
        }
        thisALabel.setText(janet)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        let bub = "\(Nub)"
        let dict: Dictionary = ["message": "\(lastpart)\(bub)"]
        print("datahasbeensent", appendNewline: false)
        WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in print("Data has been sent to target: parent iOS app - UCB Pharma", appendNewline: false)
        })
        return sendables(dataname: "\(lastpart)\(bub)")
    }
    
    /*
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
    */
}
