//
//  topBarView.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class topBarView: UIView {

    //MARK:- Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
    }

}
