//
//  SignUpViewController.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects

class SignUpViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var userNameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var confirmPassTextField: HoshiTextField!
    @IBOutlet weak var privacySwitch: UISwitch!
    @IBOutlet weak var signUpBtn: UIButton!
//    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var passHideBtn: UIButton!
    @IBOutlet weak var confirmPassHideBtn: UIButton!
    @IBOutlet weak var privacyTextView: UITextView!
    
    //MARK:- Variable
    let privacyText = "By clicking on the Signup button, you understand and agree with the Terms of Use and Privacy Policy."
    
    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHyperLabel()
        applyDelgateOnTextFields()
        setupViews()
        addTopMenu()
    }
    
    
    //MARK:- Actions
    @objc func showPass(sender: UIButton){
        if (sender.isSelected == true){
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.isSelected = false
            passwordTextField.isSecureTextEntry = false
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            sender.isSelected = true
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func showConfirmPass(sender: UIButton){
        if (sender.isSelected == true){
            sender.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            sender.isSelected = false
            confirmPassTextField.isSecureTextEntry = false
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            sender.isSelected = true
            confirmPassTextField.isSecureTextEntry = true
        }
    }
    @objc func SignUpBtnTapped(_ sender: UIButton) {
       if userNameTextField.text?.isEmpty == true || userNameTextField.text!.count < 3{
            if userNameTextField.text!.isEmpty {
                self.view.makeToast("Please enter your username", duration: 2.0, position: .center)
            }
            else {
                self.view.makeToast("Username must be between 3 and 64 characters", duration: 2.0, position: .center)
            }
            
            userNameTextField.becomeFirstResponder()
            signUpBtn.shake()
        }
        else if emailTextField.text!.isEmpty {
            self.view.makeToast("Please enter your email address", duration: 2.0, position: .center)
            emailTextField.becomeFirstResponder()
            signUpBtn.shake()
        }
        else if passwordTextField.text!.isEmpty{
            self.view.makeToast("Please enter password.", duration: 2.0, position: .center)
            passwordTextField.becomeFirstResponder()
            signUpBtn.shake()
        }else if confirmPassTextField.text!.isEmpty{
            self.view.makeToast("Please re-enter password.", duration: 2.0, position: .center)
            confirmPassTextField.becomeFirstResponder()
            signUpBtn.shake()
        }
        else if passwordTextField.text! != confirmPassTextField.text! {
            self.view.makeToast("Password do not match ", duration: 2.0, position: .center)
            confirmPassHideBtn.becomeFirstResponder()
            signUpBtn.shake()
        }
        else if privacySwitch.isOn == false {
            self.view.makeToast(" Please accept Terms of Use and Privacy Policy", duration: 2.0, position: .top)
        }
        else{
          signUpAPICall()
        }
        
    }
    
    
  @IBAction func signInBtnTapped(_ sender: Any) {
    
    self.navigationController?.popViewController(animated: true)
    
  }
  //MARK:- Private functions
    private func setupHyperLabel() {
        let str = self.privacyText
        let ipad = Env.iPad
        let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ipad ? 15 : 10)]
        let string = NSMutableAttributedString(attributedString: NSAttributedString(string: str, attributes: myAttribute))
        let attributedString = string
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://www.cramfrenzy.com/terms" , range: NSRange(location: 68, length: 13))
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://www.cramfrenzy.com/privacy-policy" , range: NSRange(location: 84, length: 15))
        privacyTextView.attributedText = attributedString
    }
    
    private func applyDelgateOnTextFields() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
    }
    
    private func setupViews() {
        
        //Applying the Animation
        signUpBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
        
        //Applying the button actions
        passHideBtn.addTarget(self, action: #selector(showPass(sender:)), for: .touchUpInside)
        confirmPassHideBtn.addTarget(self, action: #selector(showConfirmPass(sender:)), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(SignUpBtnTapped(_:)), for: .touchUpInside)
      
      self.navigationController?.isNavigationBarHidden = false
      
    }
    
    private func signUpAPICall(){
        let body : [String:Any] = [
          "address":"",
           "city":"",
           "company": "",
           "country":"",
            "email":emailTextField.text!,
            "fname":"",
            "lname":"",
             "mobile":"",
             "password":passwordTextField.text!,
             "pic":"",
             "state":"",
             "user_role": "U",
            "username":userNameTextField.text!,
            "zip": ""
        ]
        print(body)
        mainService.instance.signUpUser(param: body) { (success) in
            if success{
                let status = mainService.instance.status
                if status == 500{
                    print("500")
                }
                else if status == 404{
                    print("404")
                    let message = mainService.instance.message
                    showSwiftMessageWithParams(theme: .info, title: "Sign Up", body: "\(message)")
                }
                else if status == 400{
                    print("400")
                }
                else if status == 200 || status == 201 || status == 202 {
                    print("200")
                    print("Status Message",mainService.instance.message)
                    
                    showSwiftMessageWithParams(theme: .success, title: "Sign Up", body: "Please confirm your email to continue", layout: .messageView, position: .center , completion: { (value) in
                      
                      setRootViewController(storyboardName: "Main", VCIdentifier: "LoginViewController")

                    })
                    showSwiftMessageWithParams(theme: .success, title: "Sign Up", body: "Please confirm your email to continue")
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
    
    private func UserAuthApiCall (username:String){
        let body = [
            "username": username
        ]
        print(body)
        mainService.instance.getUsernameAuthentication(param: body){ success in
            if success{
                let status = mainService.instance.status
                if status == 500{
                    print("500")
                }
                else if status == 400{
                    print("400")
                    
                }
                else if status == 404{
                    print("404")
                }
                else if status == 200{
                    print("200")
                    let message = mainService.instance.message
                    
                    if message.contains("Username Available") {
                        print("Successfully")
                    }else {
                      showSwiftMessageWithParams(theme: .info, title: "", body: message)
                        self.userNameTextField.becomeFirstResponder()
                    }
                    
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
    
    
    private func emailAuthApiCall (email:String){
        let body = [
            "email": email
        ]
        print(body)
        mainService.instance.getEmailAuthentication(param: body){ success in
            if success{
                let status = mainService.instance.status
                if status == 500{
                    print("500")
                }
                else if status == 400{
                    print("400")
                    
                }
                else if status == 404{
                    print("404")
                }
                else if status == 200{
                    print("200")
                    let message = mainService.instance.message
                    if message.contains("Email Available"){
                        print("\(message)")
                    }else {
                        showSwiftMessageWithParams(theme: .info, title: "", body: message)
                        self.emailTextField.becomeFirstResponder()
                    }
                    
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
    
    private func addTopMenu() {
        self.navigationItem.titleView = titleview
        titleview.titleLbl.text = "Sign Up"
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
      navigationController?.popViewController(animated: true)
    }
    // going back directly towards the home
    @objc func homeBtnTapped(sender: UIButton) {
        print("Home Button Tapped")
//        dismiss(animated: true, completion: nil)
    }
    
    // setting the topbar View Height
    override func viewLayoutMarginsDidChange() {
        titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
        print("titleview width = \(titleview.frame.width)")
    }
    
    
}
//MARK:- Validation & TextField Delegate
extension SignUpViewController : UITextFieldDelegate{
    // functions for Regular Expression
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.userNameTextField{
            if (textField.text?.isEmpty)!{
                self.view.makeToast("Please enter username", duration: 2.0, position: .top)
                textField.becomeFirstResponder()
            }
            else{
                if (userNameTextField.text?.count)! < 3 || (userNameTextField.text?.count)! > 64 {                    self.view.makeToast("Username must be between 3 and 64 characters", duration: 5.0, position: .top)
                    unValidTextFieldData(textField: userNameTextField)
                }
                else if isValidUserName(username: userNameTextField.text!){
                    self.UserAuthApiCall(username: userNameTextField.text!)
                }
                else{
                    unValidTextFieldData(textField:userNameTextField)
                    self.view.makeToast("Username must be between 3 and 64 characters", duration: 2.0, position: .top)
                }
            }
        }
        else if textField == self.emailTextField{
            if (textField.text?.isEmpty)!{
                self.view.makeToast("Please enter email address", duration: 2.0, position: .top)
                textField.becomeFirstResponder()
            }
            else{
                if isValidEmail(email: emailTextField.text!){
                    emailAuthApiCall(email: emailTextField.text!)
                }
                else{
                    unValidTextFieldData(textField:emailTextField)
                    self.view.makeToast("Invalid email format.", duration: 2.0, position: .top)
                }
            }
        }
        else if textField == self.passwordTextField{
            if (textField.text?.isEmpty)!{
                self.view.makeToast("Please enter 8 digit password", duration: 2.0, position: .top)
                textField.becomeFirstResponder()
            }else {
                if (passwordTextField.text?.count)! < 8 || (passwordTextField.text?.count)! > 32 {                    self.view.makeToast("Password must be 8 characters long and must include 1 upper case, 1 lower case, 1 number and 1 special character", duration: 5.0, position: .top)
                    unValidTextFieldData(textField: passwordTextField)
                }
                else if isValidPassword(password: passwordTextField.text!) {
                    
                }
                else {
                    unValidTextFieldData(textField: passwordTextField)
                    self.view.makeToast("Password must be 8 characters long and must include 1 upper case, 1 lower case, 1 number and 1 special character", duration: 5.0, position: .top)
                    passwordTextField.becomeFirstResponder()
                }
            }
        }
        else if textField == self.confirmPassTextField
        {
            if textField == self.confirmPassTextField{
                if (textField.text?.isEmpty)!{
                    self.view.makeToast("Please confirm your password", duration: 2.0, position: .top)
                    textField.becomeFirstResponder()
                }else{
                    if (confirmPassTextField.text?.count)! < 8 || (confirmPassTextField.text?.count)! > 32 {
                        self.view.makeToast("Password must be 8 characters long and must include 1 upper case, 1 lower case, 1 number and 1 special character", duration: 2.0, position: .center)
                        unValidTextFieldData(textField: confirmPassTextField)
                        confirmPassTextField.becomeFirstResponder()
                    }else {
                        validTextFieldData(textField: confirmPassTextField)
                    }
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameTextField {
            if string.count == 0 {
                return true
            }
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") &&
                prospectiveText.count <= 64
        }
        else if textField == emailTextField {
            if string.count == 0 {
                return true
            }
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 @.") &&
                prospectiveText.count <= 40
        }
        else if textField == passwordTextField {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if textField == confirmPassTextField {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else{
            return true
        }
    }
    
    
    
}
