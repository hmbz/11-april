//
//  resetPassViewController.swift
//  OgreSpace
//
//  Created by admin on 7/2/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects

class resetPassViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var currentPassTextField: HoshiTextField!
    @IBOutlet weak var newPassTextField: HoshiTextField!
    @IBOutlet weak var confirmPassTextfield: HoshiTextField!
    @IBOutlet weak var currentShowBtn: UIButton!
    @IBOutlet weak var confirmShowBtn: UIButton!
    @IBOutlet weak var newShowBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
  
  //MARK:- Properties
  var msg: String?
  var flag:Bool?
  var iconClick = true
  
  //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        topMenu()
    }
    
    //MARK:- Actions
    @objc func currentshowPassTapped(sender: UIButton){
        if (sender.isSelected == true){
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.isSelected = false
            currentPassTextField.isSecureTextEntry = false
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            sender.isSelected = true
            currentPassTextField.isSecureTextEntry = true
        }
    }
    @objc func NewshowPassTapped(sender: UIButton){
        if (sender.isSelected == true){
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.isSelected = false
            newPassTextField.isSecureTextEntry = false
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            sender.isSelected = true
            newPassTextField.isSecureTextEntry = true
        }
    }
    @objc func ConfirmShowPassTapped(sender: UIButton){
        if (sender.isSelected == true){
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.isSelected = false
            confirmPassTextfield.isSecureTextEntry = false
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            sender.isSelected = true
            confirmPassTextfield.isSecureTextEntry = true
        }
    }
    
    //MARK:- Functions
    private func setUpViews() {
        
        //Applying Animation
        submitBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
        
        //Applying Button Actions
        currentShowBtn.addTarget(self, action: #selector(currentshowPassTapped(sender:)), for: .touchUpInside)
        newShowBtn.addTarget(self, action: #selector(NewshowPassTapped(sender:)), for: .touchUpInside)
        confirmShowBtn.addTarget(self, action: #selector(ConfirmShowPassTapped(sender:)), for: .touchUpInside)
        
        //Applying delegate
        confirmPassTextfield.delegate = self
        newPassTextField.delegate = self
        currentPassTextField.delegate = self
    }
  
  //............... geting token from Login Api Call.................//
  private func ChangePassAPICall(){
    
    let body:[String:Any] = [
    "currentPassword":currentPassTextField.text!,
      "newPassword":newPassTextField.text!,
      "newPassword2":confirmPassTextfield.text!
    ]
  
    drawerService.instance.changepass(param: body) { (success) in
      if success{
        let status = mainService.instance.status
       if status == 200{
          print("200")
//          let message = drawerService.instance.message
          showSwiftMessageWithParams(theme: .success, title: "Change Password", body: "Your password has been changed successfully")
        UserDefaults.standard.set(self.newPassTextField.text!, forKey: SessionManager.keys.password)
        self.currentPassTextField.text = ""
        self.newPassTextField.text = ""
        self.confirmPassTextfield.text = ""
        
          self.navigationController?.popViewController(animated: true)
        }
        else{
          print("Error")
        }
        
      }
      else{
        let status = mainService.instance.status
        print(status)
      }
    }
  }
  
  
  //MARK:- Top Bar Setting
  // setting variable for top bar View
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
  private func topMenu() {
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "Change Password"
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
  
  //MARK:- changePassword API
  
  //MARK : Functions of Actions
  @IBAction func submitActionTapped(_ sender: Any) {
    
    if (currentPassTextField.text?.isEmpty)! {
      submitBtn.shake()
      currentPassTextField.becomeFirstResponder()
      
    }
      
    else if (newPassTextField.text?.isEmpty)!{
      submitBtn.shake()
      newPassTextField.becomeFirstResponder()
      
    }
    else if (confirmPassTextfield.text?.isEmpty)!{
      submitBtn.shake()
      confirmPassTextfield.becomeFirstResponder()
    }
    else if currentPassTextField.text! == newPassTextField.text!
    {
      showSwiftMessageWithParams(theme: .info, title: "Change Password", body: "Current and new password cannot be same")
    }
    else if newPassTextField.text != confirmPassTextfield.text {
      submitBtn.shake()
      confirmPassTextfield.text = ""
      confirmPassTextfield.becomeFirstResponder()
      
      showSwiftMessageWithParams(theme: .info, title: "Change Password", body: "Your Password And Confirmed Password do not match ")
    }
    else if newPassTextField.text == confirmPassTextfield.text  {
         ChangePassAPICall()
      showSwiftMessageWithParams(theme: .success, title: "Change Password", body: "Your password has been changed successfully")
    }else {
      showSwiftMessageWithParams(theme: .error, title: "Change Password", body: "Something went Wrong")
    }
    
  }
  
}


//MARK : Validation
extension resetPassViewController: UITextFieldDelegate {

  //TODO:- Text Field Delegate Functions
    func textFieldDidEndEditing(_ textField: UITextField) {
      if textField == currentPassTextField {
        let currentPass = UserDefaults.standard.string(forKey: SessionManager.keys.password)
        if (textField.text?.isEmpty)!{
          print("password empty ")
          textField.becomeFirstResponder()
        }else if currentPassTextField.text == currentPass {
          print("Ok")
        }else {
          unValidTextFieldData(textField: currentPassTextField)
          self.view.makeToast("Your current password is wrong", position: .top)
        }
      }else if textField == self.newPassTextField{
            if (textField.text?.isEmpty)!{
                print("password empty ")
                textField.becomeFirstResponder()
            }else {
                if (newPassTextField.text?.count)! < 8 || (newPassTextField.text?.count)! > 32 {                    self.view.makeToast("Password minimum length should be 8 characters with 1 upper Case Letter!", duration: 4.0, position: .top)
                    unValidTextFieldData(textField: newPassTextField)
                }
                else if isValidPassword(password: newPassTextField.text!) {

                }
                else {
                    unValidTextFieldData(textField: newPassTextField)
                    self.view.makeToast("Password Must be  Atleast 1 alphabets,1 number & 1 symbol and atleast 8 digit password", duration: 4.0, position: .top)
                }
            }
        }
        else if textField == self.confirmPassTextfield
        {
            if textField == self.confirmPassTextfield{
                if (textField.text?.isEmpty)!{
                    print("confirm password empty ")
                    textField.becomeFirstResponder()
                }else{
                    if (confirmPassTextfield.text?.count)! < 8 || (confirmPassTextfield.text?.count)! > 32 {
                        self.view.makeToast("Password minimum length should be 8 characters!", duration: 2.0, position: .center)
                        unValidTextFieldData(textField: confirmPassTextfield)

                    }else {
                        validTextFieldData(textField: confirmPassTextfield)
                    }
                }
            }
        }
        else  if textField == self.confirmPassTextfield{
            if confirmPassTextfield.text == newPassTextField.text{
                validTextFieldData(textField: confirmPassTextfield)
            }else{
                unValidTextFieldData(textField:confirmPassTextfield)
                self.view.makeToast("Password and Confirm Password does not Match.", duration: 3.0, position: .center)
            }
        }
    }
}
