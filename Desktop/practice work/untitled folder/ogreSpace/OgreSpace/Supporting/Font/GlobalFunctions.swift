//
//  GlobalFunctions.swift
//  OgreSpace
//
//  Created by admin on 10/26/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import UIKit


func setRootViewController(storyboardName: String, VCIdentifier: String){
  
  let appdelegate = UIApplication.shared.delegate as! AppDelegate
  let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
  let homeViewController = storyboard.instantiateViewController(withIdentifier: VCIdentifier)
  appdelegate.window!.rootViewController = homeViewController
  appdelegate.window?.makeKeyAndVisible()
  
}


//func inviteToOgreSpace(vc: UIViewController, sender: UIButton){
//  
//  
//  let urlAppStore = URL.init(string: "https://apps.apple.com/us/app/ogrespace/id1470936840")!
//  
//  let items =  [shareString, urlAppStore] as [ Any ]
//  
//  let activityVC = UIActivityViewController(activityItems: items, applicationActivities: [])
//  
//  activityVC.popoverPresentationController?.sourceView = vc.view
//  
//  if let popoverController = activityVC.popoverPresentationController{
//    
////    popoverController.barButtonItem = sender
//    
//    popoverController.permittedArrowDirections = .up
//  
//    
//  }
//  
//  vc.present(activityVC, animated:true , completion: nil)
//  
//}
