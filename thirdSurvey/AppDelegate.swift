//
//  AppDelegate.swift
//  thirdSurvey
//
//  Created by MAC-ATL019922 on 7/21/15.
//  Copyright (c) 2015 UCB+nikhowlett. All rights reserved.
//

import UIKit
import CoreData
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        NSNotificationCenter.defaultCenter().postNotificationName("WatchKitReq", object: userInfo)
    }
    
    var backgroundUpdateTask: UIBackgroundTaskIdentifier = 0

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))  // types are UIUserNotificationType members
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        //completionHandler(.NewData)
        print("BACKGROUND FETCH:")
        if let root : UINavigationController = self.window!.rootViewController! as? UINavigationController {
            //print("here we are")
            if let master : AtendeeViewController = root.topViewController as? AtendeeViewController {
                master.checkServer() } else { self.checkServe() }
        completionHandler(.NewData)
            print("BACKGROUND FETCH:") } else {
            completionHandler(UIBackgroundFetchResult.NewData) }
        //print("DOES THIS REGISTER222")
        /*var fetchStart:NSDate = NSDate()
        let viewController:ViewController = self.window?.rootViewController as! ViewController
        viewController.fetchNewDataWithCompletionHandler { (result:UIBackgroundFetchResult) -> Void in
            completionHandler(result)
            var fetchEnd:NSDate = NSDate()
            var timeElapsed:NSTimeInterval = fetchEnd.timeIntervalSinceDate(fetchStart)
            NSLog("Background Fetch Duration: %f seconds", timeElapsed)
        }*/
    }

    func endBackgroundUpdateTask() {
        UIApplication.sharedApplication().endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskInvalid
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        //AtendeeViewController.errors(checkserver())
        print("willresign")
        self.backgroundUpdateTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            self.endBackgroundUpdateTask()
        })
        /*var timer3 = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        var timer6 = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        var timer9 = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: "checkServe", userInfo: nil, repeats: true)*/
        var timer11 = NSTimer.scheduledTimerWithTimeInterval(120, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        /*if AtendeeViewController() == root.topViewController {
        let master : AtendeeViewController = root.topViewController as! AtendeeViewController
        //println("\(master.description)")
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            /*dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            master.checkServer()
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "self.checkServe", userInfo: nil, repeats: true)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            println("This is run on the main queue, after the previous code in outer block")
            })
            })*/
            backgroundThread(delay: 3.0, background: {
                print("in motion")
                master.checkServer()
                var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkServe", userInfo: nil, repeats: true)
            });

        } else */
        let root : UINavigationController = self.window!.rootViewController! as! UINavigationController
        if (AtendeeViewController().currentUcbEmployee != nil) {
            print("here we are")
            let master : AtendeeViewController = root.topViewController as! AtendeeViewController
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            /*dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            master.checkServer()
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "self.checkServe", userInfo: nil, repeats: true)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            println("This is run on the main queue, after the previous code in outer block")
            })
            })*/
            backgroundThread(delay: 30.0, background: {
                print("in motion")
                master.checkServer()
                var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkServe", userInfo: nil, repeats: true)
            });
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //AtendeeViewController.errors()
        //let root : UINavigationController = self.window!.rootViewController! as! UINavigationController
        print("didenterbackground")
        var timer3 = NSTimer.scheduledTimerWithTimeInterval(300, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        var timer6 = NSTimer.scheduledTimerWithTimeInterval(600, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        var timer9 = NSTimer.scheduledTimerWithTimeInterval(900, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        var timer11 = NSTimer.scheduledTimerWithTimeInterval(1200, target: self, selector: "checkServe", userInfo: nil, repeats: true)
        let root : UINavigationController = self.window!.rootViewController! as! UINavigationController
        /*if AtendeeViewController() == root.topViewController {
            let master : AtendeeViewController = root.topViewController as! AtendeeViewController
            //println("\(master.description)")
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            /*dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            master.checkServer()
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "self.checkServe", userInfo: nil, repeats: true)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            println("This is run on the main queue, after the previous code in outer block")
            })
            })*/
            backgroundThread(delay: 3.0, background: {
                print("in motion")
                master.checkServer()
                var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkServe", userInfo: nil, repeats: true)
            });
        } else */if (AtendeeViewController().currentUcbEmployee != nil) {
            print("here we are")
            let master : AtendeeViewController = root.topViewController as! AtendeeViewController
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            /*dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            master.checkServer()
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "self.checkServe", userInfo: nil, repeats: true)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            println("This is run on the main queue, after the previous code in outer block")
            })
            })*/
            backgroundThread(delay: 30.0, background: {
                print("in motion")
                master.checkServer()
                var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkServe", userInfo: nil, repeats: true)
            });
        }
    }
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    func checkServe() {
        print("CheckServe called from AppDelegate.swift")
        let root : UINavigationController = self.window!.rootViewController! as! UINavigationController
        if let master : AtendeeViewController = root.topViewController as? AtendeeViewController {
            master.checkServer() }
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        self.endBackgroundUpdateTask()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ucb.apps.dev.thirdSurvey" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("thirdSurvey", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("thirdSurvey.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

