//
//  Extensions.swift
//  OgreSpace
//
//  Created by admin on 8/8/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
  mutating func merge(dict: [Key: Value]){
    for (k, v) in dict {
      updateValue(v, forKey: k)
    }
  }
}


extension UIViewController {
    
    @objc func inviteBtnTapped(sender: UIButton) {

        let items =  [shareString, urlAppStore] as [ Any ]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: [])
        activityVC.popoverPresentationController?.sourceView = self.view
        if let popoverController = activityVC.popoverPresentationController{
            popoverController.permittedArrowDirections = .up
        }
        self.present(activityVC, animated:true , completion: nil)
    }
}
