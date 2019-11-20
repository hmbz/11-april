//
//  AppDelegate.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Keyboard setting
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.enableAutoToolbar = false
     IQKeyboardManager.shared.shouldResignOnTouchOutside = true
      
      UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        
        // setting up the custom navigation color
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
      
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
      configureForGoogleSignIn()
      registerForPushNotifications()

//      GIDSignIn.sharedInstance().clientID = "466775169844-jjkaksot1ua6b9ka4p8q46e84oal09fv.apps.googleusercontent.com"
//      GIDSignIn.sharedInstance().delegate = self as? GIDSignInDelegate  // If AppDelegate conforms to GIDSignInDelegate
      
//      let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
//      let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
//
////     registerForPushNotifications(application)
//      application.registerUserNotificationSettings(pushNotificationSettings)
//      application.registerForRemoteNotifications()
      
        return true
    }
  
//  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//    let appId: String = Settings.appID
//    if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
//      return ApplicationDelegate.shared.application(app, open: url, options: options)
//    }
//    return false
//  }
  
  fileprivate func configureForGoogleSignIn() {
    
//    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().clientID = "466775169844-jjkaksot1ua6b9ka4p8q46e84oal09fv.apps.googleusercontent.com"
  }

  func application(_ app: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
  {
    if #available(iOS 9.0, *) {
      
      let appId: String = Settings.appID
      if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
        
      }
      
      return GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,  annotation: [:])
      
    }
    
    return true
    
  }
  
//  public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//    
//    
//    
//    return  GIDSignIn.sharedInstance().handle(url,sourceApplication: sourceApplication, annotation: annotation)
//    
//  }
  
  //Google
//  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//    
//    
////    return GIDSignIn.sharedInstance().handle(url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//    
//    let appId: String = Settings.appID
//    if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
//      return ApplicationDelegate.shared.application(app, open: url, options: options)
//    
//    }
//    
////    FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation:options[UIApplicationOpenURLOptionsKey.annotation])
//    
//    
//    return GIDSignIn.sharedInstance().handle(url,
//                                             sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                                             annotation: options[UIApplication.OpenURLOptionsKey.annotation])
//  }
  //Google
  
  func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
              withError error: NSError!) {
    // Perform any operations when the user disconnects from app here.
    // ...
  }
  
  func registerForPushNotifications() {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) {
        [weak self] granted, error in
        
        print("Permission granted: \(granted)")
        guard granted else { return }
        self?.getNotificationSettings()
    }
  }
  
  func getNotificationSettings() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      print("Notification settings: \(settings)")
      guard settings.authorizationStatus == .authorized else { return }
      DispatchQueue.main.async {
        UIApplication.shared.registerForRemoteNotifications()
      }
    }
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register: \(error)")
  }
//  private func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//    print("DEVICE TOKEN = \(deviceToken)")
//  }
//
//  private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//    print(error)
//  }
//
//  private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//    print(userInfo)
//  }
  
  
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
