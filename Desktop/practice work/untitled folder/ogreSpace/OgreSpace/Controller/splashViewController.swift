//
//  splashViewController.swift
//  OgreSpace
//
//  Created by Ehtisham on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class splashViewController: UIViewController {
  //MARK:- Properties
  @IBOutlet weak var splashImage: UIImageView!
  
  //MARK:- Variable
  
  //MARK:- View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if Env.iPad {
      self.splashImage.loadGif(name: "12.9")
    }else {
      self.splashImage.loadGif(name: "5.5")
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
      self.loginStatusChecking ()
    }
  }
  
  //MARK:- function
  private func loginStatusChecking () {
    let status = UserDefaults.standard.bool(forKey: SessionManager.keys.isUserLoggedIn)
//    print(status)
    if status{
      //Create your HomeViewController and make it the rootViewController
      setRootViewController(storyboardName: "Main", VCIdentifier: "TabBarViewController")

    }
    else {
      
      setRootViewController(storyboardName: "Main", VCIdentifier: "SliderNavController")

    }
    
  }
  
}

