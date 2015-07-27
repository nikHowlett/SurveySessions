//
//  ViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

//
//  ViewController.swift
//  surveysbeacons2
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright © 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData
extension UIColor {
    
    class func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = NSScanner(string: hex)
        
        if hex.hasPrefix("#") {
            // skip '#' character
            scanner.scanLocation = 1
        }
        scanner.scanHexInt(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
} 
class ViewController: UIViewController {
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#33CC00", alpha: 1)
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    @IBOutlet weak var corporateAccountField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var thisEmp: [UCBEmployee] = [UCBEmployee]()
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    private func saveEmployee(name: String, corporateAccount: String, presenter: Bool) {
        if managedObjectContext != nil {
            let entity = NSEntityDescription.entityForName("UCBEmployee", inManagedObjectContext: managedObjectContext!)
            let ucb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as! thirdSurvey.UCBEmployee
            ucb.name = name
            let ucbs = ucb.name
            ucb.corporateAccount = corporateAccount
            ucb.presenter = presenter
            employees.append(ucb)
            var error: NSError? = nil
            managedObjectContext!.save(nil)
        } else {
            print("Could not get managed object context")
        }
    }
    
    func textFieldDidChange() {
        if corporateAccountField.text!.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
    @IBAction func edidintg(sender: AnyObject) {
        print("\(corporateAccountField.text!)")
        textFieldDidChange()
    }
    
    var employees : [UCBEmployee] = [UCBEmployee]()
    
    func createArrayOfEmployees() {
        self.saveEmployee("Nik Howlett", corporateAccount: "T701395", presenter: true)
        self.saveEmployee("Steve Davis", corporateAccount: "U026686", presenter: true)
        self.saveEmployee("Phillip Weeks", corporateAccount: "U045581", presenter: true)
        self.saveEmployee("Scott Barnes", corporateAccount: "U028805", presenter: true)
        self.saveEmployee("Adrienne Brown", corporateAccount: "U026219", presenter: false)
        self.saveEmployee("Adrienne Brown", corporateAccount: "U049816", presenter: false)
        self.saveEmployee("Kemir Baker", corporateAccount: "U026219", presenter: false)
        self.saveEmployee("Shawn Dunkerton Jr", corporateAccount: "U053156", presenter: false)
        self.saveEmployee("Jason Moody", corporateAccount: "U021570", presenter: false)
        self.saveEmployee("Becky Craft", corporateAccount: "U035427", presenter: false)
        self.saveEmployee("Miguel Louzan", corporateAccount: "U048382", presenter: false)
        self.saveEmployee("Herman De Prins", corporateAccount: "U044070", presenter: false)
       
        /* Here is the list of Attendees on the server:
        
        U026686 - Steve Davis
        U045581 - Phillip Weeks
        U028805 - Scott Barnes
        U026219 - Adrienne Brown
        U049816 - Adrienne Brown
        U026219 - Kemir Baker
        T701395 - Nikhil Howlett
        U053156 - Shawn Dunkerton Jr
        U021570 - Jason Moody
        U035427 - Becky Craft
        U048382 - Miguel Louzan
        U044070 - Herman De Prins
        
        
        Here is a list of the Presenters for each session:
        
        1 - U026686
        2 - U045581
        3 - U028805
        4 - U026686
        5 - U045581
        6 - T701395
        7 - U026686
        */
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login" {
            print("logging in")
            if let happinessViewController = segue.destinationViewController as? MeetingChoiceController {
                happinessViewController.currentUcbEmployee = thisEmp[thisEmp.count-1]
                print(thisEmp[0].name)
                print("Emp count: \(thisEmp.count)")
            }
        }
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        corporateAccountField.resignFirstResponder()
    }
    
    func equalIgnoringCase(a:String, b:String) -> Bool {
        return a.lowercaseString == b.lowercaseString
    }
    
    func tellmeifthiscorpidisgood(sdf: String) {
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(sdf)&a=gi"
        print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var serverResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            var serverResponseStr = serverResponse as String
            if serverResponseStr != "null" {
                let alertController = UIAlertController(title: "Corporate ID Not Found!", message:
                    "Remember to include first character in the Corporate ID.  Please make sure you have entered it correctly and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                
            }
            /*if let range = serverResponseStr!.rangeOfString("&") {
                var just = serverResponseStr!.substringToIndex(range.startIndex)
                var kust = just.substringFromIndex(
            }*/
            /*justnum2 = (thissesh!.substringFromIndex(range.startIndex))
            var BITCH = " "
            var justnum3 = justnum2.substringFromIndex(BITCH.endIndex)
            justnum = justnum3.toInt()!
            } */
            /* Enter U#
            App requests user info from server (u=U026686&a=gi)
            returns user name (if user is a session presenter a list of session numbers is returned)
            n=Steve Davis&s=4+1+7
            */
            
        }
        task.resume()
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var isValidCorpID = false
        var thisi = 0
        if employees.count == 0 {
            let userEnteredCorpId = corporateAccountField.text!
            tellmeifthiscorpidisgood(userEnteredCorpId)
            
        } else {
            for (var i = 0; i < employees.count; i++) {
                let thisidelol = employees[i].corporateAccount
                let thisside = corporateAccountField.text!
                print(thisidelol)
                print(thisside)
                if (equalIgnoringCase(thisidelol, b: thisside)) {
                    isValidCorpID = true
                    thisi = i
                    thisEmp == [employees[i]]
                    print("Emp count: \(thisEmp.count)")
                } else if (thisside == thisidelol) {
                    isValidCorpID = true
                    thisi = i
                    thisEmp == [employees[i]]
                    print("Emp count: \(thisEmp.count)")
                }
            }
        }
        if isValidCorpID {
            let ghi = employees[thisi]
            thisEmp.append(ghi)
            print("Emp count: \(thisEmp.count)")
            self.performSegueWithIdentifier("login", sender: self)
        } else {
            //present alert view saying not a valid coporate id
            let alertController = UIAlertController(title: "Corporate ID Not Found!", message:
                "Remember to include first character in the Corporate ID.  Please make sure you have entered it correctly and try again.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        getUserName()
    }
    
    func getUserName() {
        /*  App requests user info from server (u=U026686&a=gi) */
        var thiscorpid = thisEmp[thisEmp.count-1].corporateAccount
        let superfirst = "http://172.17.8.66:8080/DocuSign2/aPollingServlet"
        let firstpart = "?u=\(thiscorpid)&a=gi"
        print("\(superfirst)\(firstpart)")
        let url = NSURL(string: "\(superfirst)\(firstpart)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
        }
        task.resume()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "UCBEmployee")
        employees = []
        if (employees.count == 0) {
            employees = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as! [UCBEmployee]
            if (employees.count == 0) {
            createArrayOfEmployees()
        }
        thisEmp = []
        self.loginButton(false)
        //print(employees.count)
    }
    
}

}