//
//  MeetingChoiceController.swift
//  SurveySession
//
//  Created by MAC-ATL019922 on 7/17/15.
//  Copyright © 2015 nikhowlett. All rights reserved.
//

import UIKit

class MeetingChoiceController: UIViewController {

    var meetingsArray = ["Meeting 1","Meeting 2","Meeting 3","Meeting 4"]

    @IBOutlet weak var thisIsAPicker: UIPickerView!
    
    override func viewDidLoad() {
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        //thePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //Acertainpicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //Acertainpicker.setValue(UIColor.greenColor(), forKeyPath: "textColor")
        //acertainpicker.selectedTextColor = UIColor.whiteColor()
        self.thisIsAPicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //self.thisIsAPicker.
        self.view.backgroundColor = ucbmedicalvideocolor
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meetingsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return meetingsArray[row]
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
