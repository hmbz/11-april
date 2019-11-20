//
//  faqsViewController.swift
//  OgreSpace
//
//  Created by admin on 7/4/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class faqsViewController: UIViewController {
  
  //MARK:- Properties
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
    override func viewDidLoad() {
        super.viewDidLoad()
topBAr()
        // Do any additional setup after loading the view.
    }
    

  func topBAr () {
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "FAQS"
    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    titleview.homeBtn.layer.cornerRadius = 6
    titleview.homeBtn.layer.masksToBounds = true
    self.navigationItem.hidesBackButton = true
    
  }
  
  // performing back button functionality
  @objc func backbtnTapped(sender: UIButton){
    print("Back button tapped")
    // agar hum push view controller se navigation perform karwa rahe hon then back pe pop karwana ho ga ni to dismiss
    self.navigationController?.popViewController(animated: true)
  }
  // going back directly towards the home
  @objc func homeBtnTapped(sender: UIButton) {
    print("Home Button Tapped")
    self.navigationController?.popViewController(animated: true)
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }

}
