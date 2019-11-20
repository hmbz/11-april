//
//  CameraOwnViewController.swift
//  Sell4Bids
//
//  Created by admin on 12/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import AVFoundation



class CameraOwnViewController: UIViewController,  UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ActivityLoading: UIActivityIndicatorView!
  
  
  var CameraController = UIImagePickerController()
  var delegate : GetImageDelegate?
//  var ImageDelegate : getImageDelegate?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loading Camera"
        CameraController.delegate = self
        CameraController.sourceType = .camera
        self.present(CameraController, animated: true, completion: nil)
    }
   
    
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
       
       
       
}
    
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
    print("called camera")
    
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      
      print("No image found")
      return
    }
    self.presentedViewController?.dismiss(animated: true, completion: nil)
    
    self.ImageView.image = image
    self.delegate?.getCapturedImg(img: image)
    
    
    self.title = "Captured Image"
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.dismiss(animated: false, completion: nil)
    }
  }
  
//  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//
//
//    }
  

}

protocol GetImageDelegate : class {
    func getCapturedImg(img : UIImage)
}
