//
//  ViewController.swift
//  SurveySession
//
//  Created by MAC-ATL019922 on 7/17/15.
//  Copyright © 2015 nikhowlett. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

class ViewController: UIViewController {
        
    //MARK: Outlets for UI Elements.
    @IBOutlet weak var corporateAccountField: UITextField!
    //@IBOutlet weak var back2: UIImageView!
    //@IBOutlet weak var ucbBackgroundImages: UIImageView!
    //@IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private var idx: Int = 0
    
    private let backGroundArray = [UIImage(named: "Alun.jpg"),UIImage(named:"Atsumi.jpg"), UIImage(named: "neil2.png"), UIImage(named: "Cover3.png"), UIImage(named: "keyvisual_static.jpg"), UIImage(named: "neil3.png")]

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
        
    }
    
    @IBAction func edidintg(sender: AnyObject) {
        print("\(corporateAccountField.text!)")
        textFieldDidChange()
    }
    @IBAction func Valuhan(sender: AnyObject) {
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ucbmedicalvideocolor = uicolorFromHex(0x062134)
        self.view.backgroundColor = ucbmedicalvideocolor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        //firstnameTextField.addTarget(self, action: "textDidChanged:", forControlEvents:.EditingChanged)
        //corporateAccountField.addTarget(self, action: Selector("textFieldDidChange:"), forControlEvents:.EditingChanged)
        /* UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut | .Repeat | .Autoreverse,
        animations: { () -> Void in
       /* */
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
            //self.corporateAccountField.alpha = 1.0
            //self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 1.0
            }, completion: nil)*/
        // Do any additional setup after loading the view, typically from a nib.
        //let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark)) as UIVisualEffectView
        //visualEffectView.frame = self.view.frame
        //visualEffectView.alpha = 0.5
        //ucbBackgroundImages.image = UIImage(named: "neil2.png")
        //ucbBackgroundImages.addSubview(visualEffectView)
        //back2.image = UIImage(named: "neil2.png")
        //back2.addSubview(visualEffectView)
        //NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "changeImage", userInfo: nil, repeats: true)
        self.loginButton(false)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx++
        }
        let toImage = backGroundArray[idx];
        //UIView.transitionWithView(self.ucbBackgroundImages, duration: 10, options: .TransitionCrossDissolve, animations: {self.ucbBackgroundImages.image = toImage}, completion: nil)
        //UIView.transitionWithView(self.back2, duration: 10, options: .TransitionCrossDissolve, animations: {self.back2.image = toImage}, completion: nil)
        
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        corporateAccountField.resignFirstResponder()
        //passwordField.resignFirstResponder()
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

}

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


