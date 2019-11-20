//
//  topSearchBarUIView.swift
//  NotesGenie
//
//  Created by admin on 11/12/18.
//  Copyright © 2018 BrainPlow. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var pizzaMEnu: UIButton!
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var notificationBtn: UIButton!
  
  @IBOutlet weak var filterBtn: UIButton!
  
  @IBOutlet weak var propertySearchBar: UISearchBar!
  
//  @IBOutlet weak var cartBtn: UIButton!
  
  
    override var intrinsicContentSize: CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width - 10, height: 40)
        }else {
            return CGSize(width: UIScreen.main.bounds.width - 8, height: 40)
        }
        
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
            if abs(constraint.constant) == 8 {
                constraint.isActive = false
            }
        }
    }
    
    
    
    
    
}
