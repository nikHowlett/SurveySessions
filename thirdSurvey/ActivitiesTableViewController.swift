//
//  ActivitiesTableViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/24/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesTableViewController: UITableViewController {
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext : NSManagedObjectContext? = appDelegate.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    var activities : [Activity] = [Activity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Activity")
        activities = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [Activity]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath) as! UITableViewCell
        let thisActivity : Activity = activities[indexPath.row] as Activity
        cell.textLabel?.text = thisActivity.title
        cell.detailTextLabel?.text = thisActivity.Message
        return cell
    }
    
    func surveyAtIndexPath(indexPath: NSIndexPath) -> Activity
    {
        let productLine = activities[indexPath.section]
        return activities[indexPath.row] as Activity
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Peetail":
                print("playtime")
               /* let productDetailVC = segue.destinationViewController as! shmetail
                if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                    productDetailVC.surveyitem = surveyAtIndexPath(indexPath)
                }*/
            default: break
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
