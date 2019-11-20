//
//  TermsOfUseViewController.swift
//  OgreSpace
//
//  Created by admin on 7/4/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class TermsOfUseViewController: UIViewController {
//  
//  //MARK:- Outlets
//  @IBOutlet weak var roundLbl: UILabel!
//  @IBOutlet weak var ShadowLbl: UILabel!
//  @IBOutlet weak var termsTextView: UITextView!
//  

  //MARK:- Properties
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
//  
//  //MARK:- View Life Cycle
  override func viewDidLoad() {
    
    super.viewDidLoad()
  topBAr()
}
  func topBAr () {
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "What is OgreSpace"
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
