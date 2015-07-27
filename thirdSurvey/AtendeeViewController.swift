//
//  AtendeeViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import Foundation

class AtendeeViewController: UIViewController {

    var timer = NSTimer()
    var currentUcbEmployee: UCBEmployee?
    var currentSession: Session?
    var magikString: String?
    @IBOutlet weak var thisALabel: UILabel!
    @IBOutlet weak var currentServerActivity: UILabel!
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    @IBOutlet weak var wd: UILabel!
    /*
    User answers polling questions
    If polling action is returned user is prompted to answer questions.
    The answers are returned to the server (u=U026686&a=s&s=3&ans=y+n+4)
    */
    func handleWatchKitNotification(notification: NSNotification) {
        if let userInfo = notification.object as? [String : String] {
            //save survey results!
            print("Watchnotification received")
            magikString = userInfo["message"]!
            let thisCorpacc = currentUcbEmployee?.corporateAccount
            let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
            let thissesh = currentSession?.name
            let tooter = "Session "
            var justnum = 0
            var justnum2 = ""
            if let range = thissesh!.rangeOfString(" ") {
                justnum2 = (thissesh!.substringFromIndex(range.startIndex))
                var BITCH = " "
                var justnum3 = justnum2.substringFromIndex(BITCH.endIndex)
                justnum = justnum3.toInt()!
            }
            let seshnumb = justnum
            wd.text = magikString!
            let firstpart = "?u=\(thisCorpacc!)&a=s&s=\(seshnumb)&ans=\(magikString!)"
            print("\(superfirst)\(firstpart)")
            let url = NSURL(string: "\(superfirst)\(firstpart)")
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
                print("Saved survey results!")
            }
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Attendant Interface"
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        self.thisALabel.text = currentSession!.name
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        /*var timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "checkServer", userInfo: nil, repeats: true)*/
        //timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "checkServer", userInfo: nil, repeats: true)
        /*dispatch_async(dispatch_get_main_queue()) {
            self.checkServer()
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "checkServer", userInfo: nil, repeats: true)
        }*/
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("handleWatchKitNotification:"),
            name: "WatchKitReq",
            object: nil)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let aVariable: () = appDelegate.checkServe()
        var dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            //self.checkServer()
            print("Dispatch Timer")
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "checkServer", userInfo: nil, repeats: true)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkServer() {
        //check for an update
        /* The app checks for actions
        Periodically (every 2 mins) the app will request actions from the server (u=U026686&a=q)
        If a polling request exists for the user the server will return the session (s=3+5&a=p)
        */
        print("checkServer called in AttendantViewController.swift")
        let thisCorpacc = currentUcbEmployee?.corporateAccount
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(thisCorpacc!)&a=q"
        //print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        //let url = NSURL(string: "http://www.something.com/")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var serverResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print("RAW: \(serverResponse)")
            var serverResponseStr = serverResponse as! String
            self.currentServerActivity.text! = "\(serverResponseStr)"
            let stringArray = serverResponseStr.componentsSeparatedByCharactersInSet(
                NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let newString = NSArray(array: stringArray).componentsJoinedByString("")
            let newStrinx = NSArray(array: stringArray).componentsJoinedByString("") as NSString
            print("INTS: \(newString)")
            for (var i = 0; i < stringArray.count ; i++) {
                //var litt = newString.
                //var lit = "\(newStrinx.characterAtIndex(i))".toInt()!
                var thisone = stringArray[i]
                let thissesh = self.currentSession?.name
                let tooter = "Session "
                var justnum = 0
                var justnum2 = ""
                if let range = thissesh!.rangeOfString(" ") {
                    justnum2 = (thissesh!.substringFromIndex(range.startIndex))
                    var BITCH = " "
                    var justnum3 = justnum2.substringFromIndex(BITCH.endIndex)
                    justnum = justnum3.toInt()!
                }
                let seshnumb = justnum
                if newString.rangeOfString("\(seshnumb)") != nil{
                    print("OVERIDE")
                    self.notifysomeone()
                    i = stringArray.count
                } else if thisone == "" {
                    print("no survey/poll awaits @ this index")
                } else if thisone.toInt()! == justnum {
                    self.currentServerActivity.text! = "\(serverResponseStr)"
                    self.notifysomeone()
                    print("aight get ready for a survey")
                }
            }
        }
        task.resume()
    }
    
    func errors() {
        checkServer()
    }
    
    func notifysomeone() {
        let localNotification = UILocalNotification()
        localNotification.soundName = "beep-01a.wav"
        localNotification.alertTitle = "Survey has been sent to this session!"
        localNotification.alertBody = "Please fill in the Apple Watch Survey! Thank you!"
        localNotification.alertAction = "Take Survey"
        localNotification.category = "surveySession"
        //print(seconds, appendNewline: false)
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 2)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    /* func thispersonisattending() {
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

    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(120.0, target: self, selector: Selector(sayHello()), userInfo: nil, repeats: true)
    var timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("function"), userInfo: nil, repeats: true)
    func scheduledTimerWithTimeInterval(ti: 120, target aTarget: self, selector aSelector: "onUpdate1:", userInfo: nil, repeats yesOrNo: true) -> NSTimer {
    
    }
    func updateImage(sender: AnyObject) {
    
    timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "sayHello", userInfo: nil, repeats: true)
    
    }
    func scheduledTimerWithTimeInterval(120, aTarget: self, aSelector: "sayHello:", userInfo: nil, repeats: true) -> NSTimer {
    
    }
    var timer1 = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "onUpdate1:", userInfo: nil, repeats: true)
    func sayHello()
    {
    NSLog("hello World")
    }
    /*if let range = serverResponseStr.rangeOfString("=") {
    var somenumbers = serverResponseStr.substringFromIndex(range.startIndex)
    print("Somenumbers = \(somenumbers)")
    if let rang = somenumbers.rangeOfString("&") {
    var evenlessnumbers = somenumbers.substringToIndex(rang.startIndex)
    print("evenlessnumbers = \(evenlessnumbers)")
    if let ran = evenlessnumbers.rangeOfString("+") {
    for (var i = 0; i < evenlessnumbers.count;i++) {
    var thischar = evenlessnumbers[i]
    if (thischar
    }
    }
    }
    }*/
    */
    
    @IBAction func viewActivityLog(sender: AnyObject) {
        self.performSegueWithIdentifier("activityLog", sender: self)
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
