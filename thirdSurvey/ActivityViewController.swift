//
//  ActivityViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/24/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var titleBox: UITextField!
    
    @IBOutlet weak var MessageBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Attendant Interface"
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendActivity(sender: AnyObject) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //ucb location Latitude:33.896888°
    //Longitude:-84.490772°
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
