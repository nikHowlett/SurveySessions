//
//  resultsViewController.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/22/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData

class resultsViewController: UIViewController {

    var currentUcbEmployee: UCBEmployee?
    @IBOutlet weak var confirmationLabel: UILabel!
    var currentSession: Session?
    var currentResult: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results Viewer"
        // Do any additional setup after loading the view.
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
