//
//  AddListingStep3ViewController.swift
//  OgreSpace
//
//  Created by admin on 7/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class AddListingStep3ViewController: UIViewController, UINavigationControllerDelegate {
  
  //MARK: IBOutlets
  
  @IBOutlet weak var imageSelectionView: UIView!
  @IBOutlet weak var imageDisplayView: UIView!
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var selectPhotosImageView: UIImageView!
  @IBOutlet weak var selectedImagesCollectionView: UICollectionView!
  @IBOutlet weak var addMorePhotosPopUpView: DesignableView!
  @IBOutlet weak var dimView: UIView!
  @IBOutlet weak var imageDisplayViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var zipCodeTextTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var doneBtn: UIButton!
  
  @IBOutlet weak var zipCodeTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var countryTextField: UITextField!
  @IBOutlet weak var stateTextField: UITextField!
  
  @IBOutlet weak var propertyAddressTextField: UITextField!
  
  
  
  //MARK: Properties
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  var selectedImagesArray = [UIImage]()
  var step1and2ParametersDictionary = [String: Any]()
  var parametersDictionary = [String: Any]()
  
  
  //MARK: View Life Cycle
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    imageDisplayView.isHidden = true
    selectedImagesCollectionView.delegate = self
    selectedImagesCollectionView.dataSource = self
    dimView.isHidden = true
    let tapGesturePostImg = UITapGestureRecognizer.init(target: self, action: #selector(self.showExtraImgView))
    selectPhotosImageView.addGestureRecognizer(tapGesturePostImg)
    backBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    doneBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    addTopBar()
    
  }
  
  
  //MARK: Actions
  
  @IBAction func backButtonTapped(_ sender: Any) {
    
    self.navigationController?.popViewController(animated: true)
    
  }
  
  
  @IBAction func donebuttonTapped(_ sender: Any) {
    
    if zipCodeTextField.text!.isEmpty {
      
      zipCodeTextField.shake()
      self.view.makeToast("Please enter your zip code", duration: 3.0, position: .top)
      
    }else if cityTextField.text!.isEmpty {
      
      cityTextField.shake()
      self.view.makeToast("Please enter your city name", duration: 3.0, position: .top)
      
    }else if stateTextField.text!.isEmpty {
      
      stateTextField.shake()
      self.view.makeToast("Please enter your state name", duration: 3.0, position: .top)
      
    }else if countryTextField.text!.isEmpty {
      
      countryTextField.shake()
      self.view.makeToast("Please enter your country name", duration: 3.0, position: .top)
      
    }else if selectedImagesArray.isEmpty {
      
      self.view.makeToast("Please add photos of your property", duration: 3.0, position: .top)
      
    }else {
      
      parametersDictionary = [
        "zipcode": zipCodeTextField.text!,
        "city": cityTextField.text!,
        "state": stateTextField.text!,
        "country": countryTextField.text!,
        "address": propertyAddressTextField.text!
      ]
      parametersDictionary.merge(dict: step1and2ParametersDictionary)
      uploadImagesToServer(){(success, responseArray) in
        
        if success{
          self.parametersDictionary["pic_url"] = responseArray
          AddListingService.instance.addListing(params: self.parametersDictionary){ (success) in
            if success {
              self.view.makeToast("Listing added successfully", duration: 3.0, position: .top)
            }else {
              
              self.view.makeToast("Listing could not be added", duration: 3.0, position: .top)
            
            }
            
          }
          
        }else {
          
          self.view.makeToast("Listing could not be added", duration: 3.0, position: .top)
            
          }
      
      }
      
//      AddListingService.instance.upload(imagesArray: selectedImagesArray){ (success, responseUrl) in
//
//        if success{
//
//          print("Hurrayy")
//          self.parametersDictionary["pic_url"] = responseUrl
//          AddListingService.instance.addListing(params: self.parametersDictionary){ (success) in
//
//            if success {
//
//              self.view.makeToast("Listing added successfully", duration: 3.0, position: .top)
//
//            }else {
//
//              self.view.makeToast("Listing could not be added", duration: 3.0, position: .top)
//
//            }
//
//          }
//          //          imagesStoragePathArray.append(responseUrl)
//
//        }else {
//
//          print("image not uploaded")
//
//        }
//
//      }
      
    }
    
  }
  
  
  @IBAction func takePhotoButtonTapped(_ sender: Any) {
    
    performSegue(withIdentifier: "fromAddListingToCamera", sender: nil)
    self.dismiss(animated: true, completion: nil)
    toggleAddPhotosView(flag: false)
    
  }
  
  @IBAction func deleteImageTapped(_ sender: Any) {
    
    if selectedImagesArray.count > 0  {
      
      if selectedImagesArray.count != 0 {
        
        mainImageView.image = selectedImagesArray.last!
        selectedImagesArray.remove(at: selectedImagesArray.count - 1)
        print("ImageList Array closed Button == \(selectedImagesArray)")
        
      }
      
      selectedImagesCollectionView.reloadData()
      print("ImageList Array closed Button Reload")
    }
    
    if self.selectedImagesArray.count <= 0 {
      
      print("ImageList Array closed Button Internal")
      self.toggleImageSelectionAndDisplay(flag: false)
      
    }
    
  }
  @IBAction func selectPhotoButtonTapped(_ sender: Any) {
    
    let bsImagePicker = BSImagePickerViewController()
    bsImagePicker.maxNumberOfSelections = 5
    bsImagePicker.takePhotos = true
    bs_presentImagePickerController(bsImagePicker, animated: true,
                                    select: { (asset: PHAsset) -> Void in
                                      print("Selected: \(asset)")
    }, deselect: { (asset: PHAsset) -> Void in
      print("Deselected: \(asset)")
    }, cancel: { (assets: [PHAsset]) -> Void in
      print("Cancel: \(assets)")
    }, finish: { (assets: [PHAsset]) -> Void in
      print("Finish: \(assets)")
      print(assets.count)
      self.getAssetThumbnail(asset: assets)
      //      for i in 0..<assets.count {
      //
      //        self.SelectedAssets.append(assets[i])
      //        print(self.SelectedAssets)
      //      }
    }, completion: nil)
    
    toggleAddPhotosView(flag: false)
    
  }
  
  //MARK: Private Functions
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "Add Listing"
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
    
    self.navigationController?.popViewController(animated: true)
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }
  
  private func uploadImagesToServer(completion: @escaping (Bool, [String]) -> ()){

    var imagesStoragePathArray = [String]()
    for item in selectedImagesArray {
      
      AddListingService.instance.upload(image: item){ (success, responseUrl) in
        
        if success{
          
          print("Hurrayy")
          imagesStoragePathArray.append(responseUrl)
          if imagesStoragePathArray.count == self.selectedImagesArray.count{
            
            completion(true, imagesStoragePathArray)
            
          }else {
            
    
            
          }
          
        }else {
          
          print("image not uploaded")
          completion(false, imagesStoragePathArray)
          
        }
        
      }
      
    }

  }
  
  @objc private func showExtraImgView (_ sender: UITapGestureRecognizer? = nil) {
    if selectedImagesArray.count >= 14 {
      showSwiftMessageWithParams(theme: .error, title: "Error", body: "You can add max 14 images.")
    }else {
      
      toggleAddPhotosView(flag: true)
      
    }
    
  }
  
  func getAssetThumbnail(asset: [PHAsset]) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    
    for assets in asset {
      manager.requestImage(for: assets, targetSize: CGSize(width: 200.0, height: 200.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        thumbnail = result!
        
        if self.selectedImagesArray.count >= 14 {
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "You can add max 14 images")
          return
        }
        else{
          self.selectedImagesArray.append(thumbnail)
          print("ImageList_Count_getAssetThumbnail  == \(self.selectedImagesArray.count)")
          
          DispatchQueue.main.async {
            self.toggleImageSelectionAndDisplay(flag: true)
            //            if self.selectedImagesArray.count > 0 {
            //              self.TakePhotoHeightConstrant.constant = 0
            //              self.TakePhotoView.isHidden = true
            //              self.ImageCustomViewHeight.constant = 200
            //              self.TopConstraintValue.constant = 10
            //              self.Scrollview.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
            //              self.CollectionViewHeight.constant = 80
            //
            //              self.CloseBtn.constant = 30
            //
            //            }
            
            self.mainImageView.image = self.selectedImagesArray.last!
            self.selectedImagesCollectionView.reloadData()
            print("thumbnail == \(thumbnail)")
            
          }
        }
        
      })
    }
    return thumbnail
  }
  
  
  private func toggleImageSelectionAndDisplay(flag: Bool){
    
    if flag {
      
      imageDisplayView.isHidden = false
      //      imageDisplayViewHeightConstraint.constant = 236
      zipCodeTextTopConstraint.constant = 86
      
    }else {
      
      imageDisplayView.isHidden = true
      zipCodeTextTopConstraint.constant = 8
      
    }
    //    imageDisplayView.isHidden = !imageDisplayView.isHidden
    
  }
  
  private func toggleAddPhotosView(flag: Bool){
    
    if flag {
      
      addMorePhotosPopUpView.isHidden = false
      dimView.isHidden = false
      
    }else {
      
      addMorePhotosPopUpView.isHidden = true
      dimView.isHidden = true
      
    }
    
  }
  
  //MARK:- Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fromAddListingToCamera" {
      if let navigationController = segue.destination as? UINavigationController {
        let childViewController = navigationController.topViewController as? CameraOwnViewController
        childViewController?.delegate = self
      }
      
    }
  }
  
  
}


//MARK: UICollectionView Extension
extension AddListingStep3ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedImagesArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedAssetsCollectionViewCell", for: indexPath) as! SelectedAssetsCollectionViewCell
    cell.selectedAssetImageView.image = self.selectedImagesArray[indexPath.row]
    
    return cell
    
  }
  
  
  
  
  
}

//MARK: GetImageDelegate Extension

extension AddListingStep3ViewController : GetImageDelegate {
  func getCapturedImg(img: UIImage) {
    print("Called Delegate Camera")
    
    if selectedImagesArray.count >= 14 {
      showSwiftMessageWithParams(theme: .error, title: "Error", body: "Maximum Image Selection limit is 14")
      return
    }
    else{
      print("image detail == \(img.description)")
      //      limitcount += 1
      mainImageView.image = img
      self.selectedImagesArray.append(img)
      print("Imagelist Count == \(self.selectedImagesArray.count)")
      toggleImageSelectionAndDisplay(flag: true)
      self.selectedImagesCollectionView.reloadData()
      
      
      
      
    }
  }
  
  
}
