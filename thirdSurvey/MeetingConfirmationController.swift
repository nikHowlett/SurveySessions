//
//  MeetingConfirmationController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

//
//  MeetingConfirmationController.swift
//  surveysbeacons2
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright © 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit

class MeetingConfirmationController: UIViewController {
    
    var currentUcbEmployee: UCBEmployee?
    @IBOutlet weak var confirmationLabel: UILabel!
    var currentSession: Session?
    var magikString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Confirm Session"
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        let thisSessionName = currentSession?.name
        let thisSessionTime = "\(currentSession!.time)"
        let thisSessionTimeShort = thisSessionTime.substringToIndex(advance(thisSessionTime.startIndex, 19))
        let thisSessionLoco = currentSession?.location
        magikString = "\(thisSessionName!) which will take place at \(thisSessionTimeShort) at \(thisSessionLoco!)."
        confirmationLabel.text = magikString
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func itsRight(sender: AnyObject) {
        if currentUcbEmployee?.presenter == true {
            let thisPresenter = currentSession?.presenter
            let thisCorp = currentUcbEmployee?.corporateAccount
            if (thisPresenter == thisCorp) {
                self.performSegueWithIdentifier("presenter", sender: self)
            } else {
                thispersonisattending()
                self.performSegueWithIdentifier("aintnopresenter", sender: self)
            }
        } else {
            thispersonisattending()
            self.performSegueWithIdentifier("aintnopresenter", sender: self)
        }
    }
    
    func thispersonisattending() {
        let thisCorpacc = currentUcbEmployee?.corporateAccount
        let thissesh = currentSession?.name
        let tooter = "Session "
        var justnum = 0
        var justnum2 = ""
        //print("thissesh: \(thissesh!)")
        if let range = thissesh!.rangeOfString(" ") {
            justnum2 = (thissesh!.substringFromIndex(range.startIndex))
            var BITCH = " "
            var justnum3 = justnum2.substringFromIndex(BITCH.endIndex)
            //print("justnum3: \(justnum3)")
            //print("justnum2: \(justnum2)")
            justnum = justnum3.toInt()!
        }
        let seshnumb = justnum
        //attend session format: ?u=U026686&s=3&a=a
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(thisCorpacc!)&s=\(seshnumb)&a=a"
        print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
        }
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presenter" {
            if let happinessViewController = segue.destinationViewController as? PresenterViewController {
                happinessViewController.currentUcbEmployee = currentUcbEmployee
                happinessViewController.currentSession = currentSession
            }
        } else if segue.identifier == "aintnopresenter" {
            if let happinessViewController = segue.destinationViewController as? AtendeeViewController {
                happinessViewController.currentUcbEmployee = currentUcbEmployee
                happinessViewController.currentSession = currentSession
            }
        }
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
}

