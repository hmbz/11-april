//
//  SearchBarView.swift
//  OgreSpace
//
//  Created by MAC on 22/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

  //MARK:- Outlets
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var homeBtn: UIButton!
  @IBOutlet weak var inviteBtn: UIButton!
  @IBOutlet weak var searchBtn: UISearchBar!
  @IBOutlet weak var micBtn: UIButton!
  @IBOutlet weak var backBtnViewWidth: NSLayoutConstraint!
  
  // setting up view height
  //  override var intrinsicContentSize: CGSize {
  //    return CGSize(width: UIScreen.main.bounds.width, height: 40)
  //  }
  override var intrinsicContentSize: CGSize {
    if UIDevice.current.userInterfaceIdiom == .pad{
      return CGSize(width: UIScreen.main.bounds.width - 10, height: 40)
    }else {
      return CGSize(width: UIScreen.main.bounds.width - 8, height: 40)
    }
    
    //    return UILayoutFittingExpandedSize
    
  }
  
  
  override var frame: CGRect {
    get {
      return super.frame
    }
    set {
      super.frame = newValue.insetBy(dx: -newValue.minX, dy: 1)
    }
  }
  
  override func didMoveToSuperview() {
    if let superview = superview {
      frame = superview.bounds
      translatesAutoresizingMaskIntoConstraints = true
      autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    /// remove autolayout warning in iOS11
    superview?.constraints.forEach { constraint in
      if fabs(constraint.constant) == 8 {
        constraint.isActive = false
      }
    }
  }

}
