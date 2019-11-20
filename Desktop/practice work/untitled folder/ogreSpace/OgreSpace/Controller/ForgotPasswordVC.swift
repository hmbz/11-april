//
//  ForgotPasswordVC.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects

class ForgotPasswordVC: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var fidgetSpinner: UIImageView!
    
    //MARK:- Variables
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topMenu()
        emailTextField.delegate = self
        submitBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
        submitBtn.addTarget(self, action: #selector(resetPassBtnTapped(sender:)), for:.touchUpInside)
        
    }
    
    //MARK:- Action
    
    @objc func resetPassBtnTapped(sender: UIButton){
        if emailTextField.text!.isEmpty {
            self.view.makeToast("Please enter email address",position:.top)
            self.emailTextField.becomeFirstResponder()
        }
        else{
            if isValidEmail(email: emailTextField.text!){
                forgotPasswordAPI()
            }
            else{
                unValidTextFieldData(textField:emailTextField)
                self.view.makeToast("Enter valid email", duration: 2.0, position: .top)
            }
        }
    }
    
    
    //MARK:- Top Bar Setting
    // setting variable for top bar View
    lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
    
    private func topMenu() {
        self.navigationItem.titleView = titleview
        
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
       dismiss(animated: true, completion: nil)
    }
    // going back directly towards the home
    @objc func homeBtnTapped(sender: UIButton) {
        print("Home Button Tapped")
       dismiss(animated: true, completion: nil)
    }
    
    // setting the topbar View Height
    override func viewLayoutMarginsDidChange() {
        titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
        print("titleview width = \(titleview.frame.width)")
    }
    
    //MARK:- Network call function
    private func forgotPasswordAPI(){
        self.fidgetSpinner.isHidden = false
        self.fidgetSpinner.loadGif(name: "name")
        self.shadowView.isHidden = false
        let body = [
            "email":emailTextField.text!
        ]
        mainService.instance.forgotPass(param: body) { (success) in
            if success{
                let status = mainService.instance.status
                if status == 404{
                    print("404")
                    self.fidgetSpinner.isHidden = true
                    self.shadowView.isHidden = true
                    showSwiftMessageWithParams(theme: .info, title: "Forgot Password", body:
                        mainService.instance.message)
                    self.emailTextField.text = ""
                }
                else if status == 202{
                    print("202")
                    self.fidgetSpinner.isHidden = true
                    self.shadowView.isHidden = true
                    showSwiftMessageWithParams(theme: .info, title: "Forgot Password", body:
                        mainService.instance.message)
                    self.emailTextField.text = ""
                }
                else if status == 200{
                    print("200")
                    showSwiftMessageWithParams(theme: .success, title: "Forgot Password", body: mainService.instance.message)
                    self.emailTextField.text = ""
                    self.fidgetSpinner.isHidden = true
                    self.shadowView.isHidden = true
                }
                else{
                    print("Error!")
                    self.fidgetSpinner.isHidden = true
                    self.shadowView.isHidden = true
                }
            }
            else{
                let status = mainService.instance.status
                print(status)
                showSwiftMessageWithParams(theme: .error, title: "Reset Password", body: "Error from server")
                self.fidgetSpinner.isHidden = true
                self.shadowView.isHidden = true
            }
        }
        
        
    }
    
    
    
    
}
// MARK:- TextField Validation and Delgation
extension ForgotPasswordVC: UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField{
            if (textField.text?.isEmpty)!{
                print("email empty ")
                textField.becomeFirstResponder()
            }
            else{
                if isValidEmail(email: emailTextField.text!){
                }
                else{
                    unValidTextFieldData(textField:emailTextField)
                    self.view.makeToast("Enter valid email", duration: 2.0, position: .top)
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            if string.count == 0 {
                return true
            }
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.@1234567890") &&
                prospectiveText.count <= 30
        }
        else{
            return true
        }
    }
    
}
