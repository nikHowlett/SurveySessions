//
//  4InterfaceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import WatchKit
import Foundation
/*
User answers polling questions
If polling action is returned user is prompted to answer questions.
The answers are returned to the server (u=U026686&a=s&s=3&ans=y+n+4)
*/
class fourthInterfaceController: WKInterfaceController {

    var lastpart: String = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let diang = context as? sendables {
            lastpart = diang.dataName
            print(lastpart)
        }
        let dict: Dictionary = ["message": lastpart]
        /*WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in print("Data has been sent to target: parent iOS app - UCB Pharma", appendNewline: false)
        })*/
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    /*  //print(sliderValue)
    //var userInfo = ["justWokeUp": true,
    //"message": total]
    //print("dataisbeensent", appendNewline: false)
    //WKInterfaceController.openParentApplication(userInfo as [NSObject : AnyObject]) {
    //    (replyInfo, error) -> Void in println("ok trying watch notification style #2")
    //}
    //WKInterfaceController.openParentApplication(dict, reply: {(reply, error) -> Void in print("Data has been sent to target: parent iOS app - UCB Pharma", appendNewline: false)
    //})
    //print("the sleep is seeping into the sleet", appendNewline: false)
    //return sendables(dataname: "My sleep quality could be described as \(sliderValue) out of 10.")
    */
}
