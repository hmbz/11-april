//
//  Env.swift
//  NotesGenie
//
//  Created by admin on 10/20/18.
//  Copyright © 2018 BrainPlow. All rights reserved.
//

import Foundation
import UIKit
class Env {
  static var iPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
}

struct Fonts {
  static let sizePhone :CGFloat = 20
  static let sizePad : CGFloat = 25
  static let standardPhone = UIFont.systemFont(ofSize: sizePhone)
  static let standardPad = UIFont.systemFont(ofSize: sizePad)
  static let boldPhone = UIFont.boldSystemFont(ofSize: Fonts.sizePhone)
  static let boldPad = UIFont.boldSystemFont(ofSize: Fonts.sizePad)
  
  ///UIFont.boldSystemFont(ofSize: sizePhone + 5)
  static let h1Phone = UIFont.boldSystemFont(ofSize: sizePhone + 5)
  static let h1Pad = UIFont.boldSystemFont(ofSize: sizePad + 5)
  
  ///boldSystemFont(ofSize: sizePhone )
  static let h2Phone = UIFont.boldSystemFont(ofSize: sizePhone )
  static let h2Pad = UIFont.boldSystemFont(ofSize: sizePad )
  
}
