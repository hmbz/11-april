//
//  profileViewController.swift
//  OgreSpace
//
//  Created by admin on 7/2/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects

class profileViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileImgHeight: NSLayoutConstraint!
    @IBOutlet weak var firstNameTextField: HoshiTextField!
    @IBOutlet weak var lastNameTextField: HoshiTextField!
    @IBOutlet weak var countryTextField: HoshiTextField!
    @IBOutlet weak var cityTextField: HoshiTextField!
    @IBOutlet weak var stateTextField: HoshiTextField!
    @IBOutlet weak var zipCodeTextField: HoshiTextField!
    @IBOutlet weak var addressTextField: HoshiTextField!
    @IBOutlet weak var phoneNoTextField: HoshiTextField!
    @IBOutlet weak var updateBtn: UIButton!
  @IBOutlet weak var profilSlider: UIImageView!
  @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
  
    //MARK:- Variable
    
    lazy var imageUrl = ""
    
    
    //MARK:- View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        topMenu()
        setUpView()
        ProfileApiCall()
      //  profileImageHeight.constant = view.frame.width / 2
    }
    
    //MARK:- Action
    @objc func updateBtnTapped(sender: UIButton){
        let id = drawerService.instance.profileArray.id
        UpdateProfileApiCall(id: id!)
    }
    

    //MARK:- Private Functions
    private func setUpView() {
        
        //Applying animation on views
        updateBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
        
        //Applying Button Action
        updateBtn.addTarget(self, action: #selector(updateBtnTapped(sender:)), for: .touchUpInside)
    }
    
    private func ProfileApiCall(){
        
        drawerService.instance.getUserProfile{ (success) in
            if success{
                let status = drawerService.instance.status
                if status == 404{
                    print("404")
                    
                }
                else if status == 202{
                    print("202")
                    
                }
                else if status == 200{
                    print("200")
                   let instance = drawerService.instance.profileArray
                    self.firstNameTextField.text = instance.Fname
                    self.lastNameTextField.text = instance.Lname
                    self.addressTextField.text = instance.address
                    self.countryTextField.text = instance.country
                    self.stateTextField.text = instance.states
                    self.phoneNoTextField.text = instance.Mobile
                    self.cityTextField.text = instance.City
                    let nameImage = instance.Pic
                    let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
                    self.profileImg.sd_setImage(with: URL(string: imageUrlEncoded!), placeholderImage: UIImage(named: "man"))
                }
                else{
                    print("Error!")
                    
                }
            }
            else{
                let status = drawerService.instance.status
                print(status)
                
            }
        }
        
        
    }
    
    private func UpdateProfileApiCall(id: Int){
        let body:[String:Any] = [
            "Fname":firstNameTextField.text!,
            "Lname":lastNameTextField.text!,
            "Mobile":phoneNoTextField.text!,
            "Country":countryTextField.text!,
            "State":stateTextField.text!,
            "City":cityTextField.text!,
            "Zip":zipCodeTextField.text!,
            "Address":addressTextField.text!,
            "Pic": imageUrl
            ]
        print(body)
        drawerService.instance.updateUserProfile(Id: id, param: body){ (success) in
            if success{
                let status = drawerService.instance.status
                if status == 404{
                    print("404")
                    
                }
                else if status == 202{
                    print("202")
                    
                }
                else if status == 200{
                    print("200")
                }
                else{
                    print("Error!")
                    
                }
            }
            else{
                let status = drawerService.instance.status
                print(status)
                
            }
        }
        
        
    }
    
    //MARK:- Top Bar Setting
    // setting variable for top bar View
    lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
    
    private func topMenu() {
        self.navigationItem.titleView = titleview
        titleview.titleLbl.text = "Profile"
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
