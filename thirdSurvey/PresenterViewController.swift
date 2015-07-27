//
//  PresenterViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData

class PresenterViewController: UIViewController {

    var currentUcbEmployee: UCBEmployee?
    @IBOutlet weak var confirmationLabel: UILabel!
    var currentSession: Session?
    var currentResult: Results?
    
    @IBOutlet weak var viewresults2: UILabel!
    @IBOutlet weak var viewresults: UIButton!
    var magikString: String?
    
    var firstquesres: Int = 0
    var secquesres: Int = 0
    var thirdQuesres: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Presenter Interface"
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        self.confirmationLabel.text = currentSession!.name
        viewresults.hidden = true
        viewresults2.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewcurrentattendees(sender: AnyObject) {
        self.performSegueWithIdentifier("attenders", sender: self)
        print("finish this table")
    }
    
    @IBAction func sendACTIVITY(sender: AnyObject) {
        self.performSegueWithIdentifier("customact", sender: self)
    }
    
    @IBAction func sendSurvey(sender: AnyObject) {
        let alertController = UIAlertController(title: "Survey Sent!", message:
            "The server has been notified of your request. Please wait until all attendees have completed their surveys to collect results.", preferredStyle: UIAlertControllerStyle.Alert)
        //var extrawords for alert that are too lengthy:  to send a survey poll to the attendees on this list.
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        sendSurveyServer()
    }
    /*  If the "Poll Attendees" button is tapped the app will send a request to the server (u=U028805&a=p&s=3) */
    func sendSurveyServer() {
        let thisCorpacc = currentUcbEmployee?.corporateAccount
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
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(thisCorpacc!)&a=p&s=\(seshnumb)"
        print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
        }
        task.resume()
    }
    
    @IBAction func collectresults(sender: AnyObject) {
        let alertController = UIAlertController(title: "Collecting results", message:
            "Please wait one moment...", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        getResults()
        viewresults.hidden = false
        viewresults2.hidden = false
    }
    /*
    Presenter gets polling results
    After presenter has requested polling the presenter returns to the session page
    A request is sent to the server (u=U028805&a=r&s=3)
    The agregated answers are returned (50+25+4)
    which means:
    50% yes and 50% no for the first question
    25% yes and 75% no for the second question
    4 is the average for the third question
    (assumes first two questions are Yes/No and third question is 1-5)
    */
    func getResults() {
        let thisCorpacc = currentUcbEmployee?.corporateAccount
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
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(thisCorpacc!)&a=r&s=\(seshnumb)"
        print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            var serverResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            var serverResponseStr = serverResponse as String
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            let stringArray = serverResponseStr.componentsSeparatedByCharactersInSet(
                NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            for (var i = 0; i < stringArray.count ; i++) {
                var thisone = stringArray[i].toInt()!
                if i == 0 {
                    self.firstquesres == thisone
                } else if i == 1 {
                    self.secquesres == thisone
                } else if i == 2 {
                    self.thirdQuesres == thisone
                }
            }
            self.saveResults(self.firstquesres, q2: self.secquesres, q3: self.thirdQuesres)
            self.currentResult?.q1 = Double(self.firstquesres)
            self.currentResult?.q2 = Double(self.secquesres)
            self.currentResult?.q3 = Double(self.thirdQuesres)
        }
        task.resume()
    }
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    @IBAction func gotoResultsView(sender: AnyObject) {
        self.performSegueWithIdentifier("rez", sender: self)
    }
    
    func saveResults(q1: Int, q2: Int, q3: Int) {
        if managedObjectContext != nil {
            let entity = NSEntityDescription.entityForName("Results", inManagedObjectContext: managedObjectContext!)
            let ucb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! thirdSurvey.Results
            ucb.q1 = Double(q1)
            ucb.q2 = Double(q2)
            ucb.q3 = Double(q3)
            var error: NSError? = nil
            managedObjectContext!.save(nil)
        } else {
            print("Could not get managed object context")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "attenders" {
            if let happinessViewController = segue.destinationViewController as? AttTableViewController {
                /*happinessViewController.currentUcbEmployee = currentUcbEmployee
                happinessViewController.currentSession = currentSession*/
            }
        } else if segue.identifier == "rez" {
            if let happinessViewController = segue.destinationViewController as? resultsViewController {
                happinessViewController.currentUcbEmployee = currentUcbEmployee
                happinessViewController.currentSession = currentSession
                happinessViewController.currentResult = currentResult
            }
        }
    }
    /*
    @IBAction func dfdf(sender: AnyObject) {
    print("anything)")
    let url = NSURL(string: "http://172.17.8.66:8080/DocuSign2/aPollingServlet?u=T701395&a=gi")
    let extra = "?u=T701395&a=gi"
    let orig = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
    print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
    self.updater3.text = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
    }
    task.resume()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
