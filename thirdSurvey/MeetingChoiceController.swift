//
//  MeetingChoiceController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData

class MeetingChoiceController: UIViewController {

    var sessions: [Session] = [Session]()
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var thisIsAPicker: UIPickerView!
    var currentUcbEmployee: UCBEmployee?
    var currentSession: Session?
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sessions.count
    }
    
    /*func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = sessions[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)! , NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }*/
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = sessions[row].name
        currentSession = sessions[row]
        //let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 17.0) , NSForegroundColorAttributeName:UIColor.blackColor()])
        let attributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 20.0)! , NSForegroundColorAttributeName:UIColor.whiteColor()]
        //let brown = NSAttributedString(string: "Brown", attributes: attributes)
        let myTit = NSAttributedString(string: titleData, attributes: attributes)
        pickerLabel.attributedText = myTit
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currentSession = sessions[row]
        return sessions[row].name
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    private func saveSession(name: String, location: String, presenter: String, time: NSDate) {
        if managedObjectContext != nil {
            let entity = NSEntityDescription.entityForName("Session", inManagedObjectContext: managedObjectContext!)
            let ucb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! thirdSurvey.Session
            ucb.name = name
            let ucbs = ucb.name
            ucb.location = location
            ucb.presenter = presenter
            ucb.time = time
            var error: NSError? = nil
            managedObjectContext!.save(nil)
            sessions.append(ucb)
        } else {
            print("Could not get managed object context")
        }
        
    }
    
    @IBAction func Continue(sender: AnyObject) {
        self.performSegueWithIdentifier("confirm", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "confirm" {
            if let happinessViewController = segue.destinationViewController as? MeetingConfirmationController {
                happinessViewController.currentUcbEmployee = currentUcbEmployee
                happinessViewController.currentSession = currentSession
            }
        }
    }
    
    func createArrayofSessions() {
        let now = NSDate()
        self.saveSession("Session 1", location: "UCB", presenter: "U026686", time: now)
        self.saveSession("Session 2", location: "UCB", presenter: "U045581", time: now)
        self.saveSession("Session 3", location: "UCB", presenter: "U028805", time: now)
        self.saveSession("Session 4", location: "UCB", presenter: "U026686", time: now)
        self.saveSession("Session 5", location: "UCB", presenter: "U045581", time: now)
        self.saveSession("Session 6", location: "UCB", presenter: "T701395", time: now)
        self.saveSession("Session 7", location: "UCB", presenter: "U026686", time: now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Session"
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.thisIsAPicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        self.view.backgroundColor = ucbmedicalvideocolor
        let namesofar = currentUcbEmployee?.name
        sessions = []
        createArrayofSessions()
        if let range = namesofar!.rangeOfString(" ") {
            let justfirstanme = namesofar!.substringToIndex(range.startIndex)
            greetingLabel.text = "Welcome \(justfirstanme)!"
        }
        print("after instantiated, \(sessions.count)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/* //
//  MeetingChoiceController.swift
//  surveysbeacons2
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright © 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData

class MeetingChoiceController: UIViewController {

var sessions: [Session] = [Session]()
@IBOutlet weak var greetingLabel: UILabel!
@IBOutlet weak var thisIsAPicker: UIPickerView!
var currentUcbEmployee: UCBEmployee?
var currentSession: Session?

override func viewDidLoad() {
super.viewDidLoad()
self.title = "Choose Session"
let ucbmedicalvideocolor = uicolorFromHex(0x062134)
self.thisIsAPicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
self.view.backgroundColor = ucbmedicalvideocolor
let namesofar = currentUcbEmployee?.name
sessions = []
createArrayofSessions()
if let range = namesofar!.rangeOfString(" ") {
let justfirstanme = namesofar!.substringToIndex(range.startIndex)
greetingLabel.text = "Welcome \(justfirstanme)!"
}
print("after instantiated, \(sessions.count)")
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
return 1
}

func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
return sessions.count
}

func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
currentSession = sessions[row]
return sessions[row].name
}

func uicolorFromHex(rgbValue:UInt32)->UIColor{
let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
let blue = CGFloat(rgbValue & 0xFF)/256.0

return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}

func createArrayofSessions() {
let now = NSDate()
self.saveSession("Session 1", location: "UCB", presenter: "U026686", time: now)
self.saveSession("Session 2", location: "UCB", presenter: "U045581", time: now)
self.saveSession("Session 3", location: "UCB", presenter: "U028805", time: now)
self.saveSession("Session 4", location: "UCB", presenter: "U026686", time: now)
self.saveSession("Session 5", location: "UCB", presenter: "U045581", time: now)
self.saveSession("Session 6", location: "UCB", presenter: "T701395", time: now)
self.saveSession("Session 7", location: "UCB", presenter: "U026686", time: now)
}

/* 1 - U026686
2 - U045581
3 - U028805
4 - U026686
5 - U045581
6 - T701395
7 - U026686
*/

lazy var managedObjectContext : NSManagedObjectContext? = {
let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
return managedContext
} else {
return nil
}
}()

private func saveSession(name: String, location: String, presenter: String, time: NSDate) {
if managedObjectContext != nil {
let entity = NSEntityDescription.entityForName("Session", inManagedObjectContext: managedObjectContext!)
let ucb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! surveysbeacons2.Session
//as! SurveySession.UCBEmployee
ucb.name = name
let ucbs = ucb.name
ucb.location = location
ucb.presenter = presenter
ucb.time = time
var error: NSError? = nil
do {
try managedObjectContext!.save()
sessions.append(ucb)
print("\(ucbs)")
} catch let error1 as NSError {
error = error1
print("Could not save \(error), \(error?.userInfo)")
}
} else {
print("Could not get managed object context")
}

}

@IBAction func Continue(sender: AnyObject) {
self.performSegueWithIdentifier("confirm", sender: self)
}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
if segue.identifier == "confirm" {
if let happinessViewController = segue.destinationViewController as? MeetingConfirmationController {
happinessViewController.currentUcbEmployee = currentUcbEmployee
happinessViewController.currentSession = currentSession
}
}
}
}
*/