//
//  ContactUsViewController.swift
//  OgreSpace
//
//  Created by admin on 7/4/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
//
//  //MARK:- Outlets
//  @IBOutlet weak var feedBack: UIImageView!
//  @IBOutlet weak var nameTxtField: UITextField!
//  @IBOutlet weak var emailTxtField: UITextField!
//  @IBOutlet weak var phoneTxtField: UITextField!
//  @IBOutlet weak var subjectTxtField: UITextField!
//  @IBOutlet weak var Message: UITextView!
//  @IBOutlet weak var heightImage: NSLayoutConstraint!
//  @IBOutlet weak var sendMessageBtn: UIButton!
//
//  //MARK:- Properties
//  var getString = [String :Any]()
//  var flag:Bool?
  
  //MARK:- Properties
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
//
//  //MARK:- View Life Cycle
  override func viewDidLoad() {
//
      super.viewDidLoad()
//    setupViews()
//    phoneTxtField.delegate = self
//    sendMessageBtn.shadow(cornerRadius: 20)
//    Message.delegate = self
//    let firstName = UserDefaults.standard.string(forKey: userFname)
//    let lastName = UserDefaults.standard.string(forKey: userLname)
//    nameTxtField.text = firstName! + " " + lastName!
//    topMenuView()
//    //    let prefix = UILabel()
//    //    prefix.text = "  +1 ("
//    //    prefix.font = UIFont.boldSystemFont(ofSize: 25)
//    //    prefix.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    //    // set font, color etc.
//    //    prefix.sizeToFit()
//    //    phoneTxtField.leftView = prefix
//    //    phoneTxtField.leftViewMode = .always
    topBAr()
  }
//
  func topBAr () {
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "What is OgreSpace"
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
  

//  // MARKS:- for convert phone ()
//  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//    if textField == nameTxtField {
//      if string.count == 0 {
//        return true
//      }
//      let currentText = textField.text ?? ""
//      let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//      return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ") &&
//        prospectiveText.count <= 64
//    }
//    else if textField == phoneTxtField {
//      let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//      phoneTxtField.text = formattedNumber(number: newString)
//      return false
//    }else if textField == subjectTxtField {
//      if string.count == 0 {
//        return true
//      }
//      let currentText = textField.text ?? ""
//      let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//      return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ") &&
//        prospectiveText.count <= 100
//    } else if textField == Message {
//      if string.count == 0 {
//        return true
//      }
//      let currentText = textField.text ?? ""
//      let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//      return prospectiveText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ") &&
//        prospectiveText.count <= 300
//    }
//
//    else {
//      return true
//    }
//  }
//
//  //MARK:- Shake effects
//  @IBAction func SendMessage(_ sender: Any) {
//    if (emailTxtField.text?.isEmpty)! {
//      sendMessageBtn.shake()
//      emailTxtField.becomeFirstResponder()
//    }else if (phoneTxtField.text?.isEmpty)!{
//      sendMessageBtn.shake()
//      phoneTxtField.becomeFirstResponder()
//    }
//    else if (subjectTxtField.text?.isEmpty)! {
//      sendMessageBtn.shake()
//
//      subjectTxtField.becomeFirstResponder()
//    }else if Message.text == "Type Message" {
//      sendMessageBtn.shake()
//      Message.becomeFirstResponder()
//    }else if Message.text.isEmpty {
//      sendMessageBtn.shake()
//      Message.becomeFirstResponder()
//      showSwiftMessageWithParams(theme: .info, title: "Feedback", body: "Enter Message")
//
//    }else if Message.text.count < 30{
//      self.Message.becomeFirstResponder()
//      showSwiftMessageWithParams(theme: .info, title: "Feedback", body: "Message length should be greater than 30 and less than 300 characters")
//    }
//      //
//      //    else if Message.text == "Type Message" || Message.text.isEmpty || Message.text.count < 30{
//      //
//      //      sendMessageBtn.shake()
//      //      Message.becomeFirstResponder()
//      //
//      //    }
//    else  {
//      signUpAPICall()
//    }
//  }
//
//  //MARK:- Private Functions
//  private func setupViews(){
//
//    Message.layer.borderWidth = 1
//    Message.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//    Message.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    nameTxtField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    emailTxtField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    phoneTxtField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    subjectTxtField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    Message.delegate = self
//
//    delegateTf()
//  }
//
//  @objc private func backBtn(){
//    dismiss(animated: true, completion: nil)
//  }
//
//  private func signUpAPICall(){
//    let body : [String:Any] = [
//      "name": nameTxtField.text!,
//      "email": emailTxtField.text!,
//      "phone":  phoneTxtField.text!,
//      "subject": subjectTxtField.text!,
//      "message": Message.text!
//    ]
//    print(body)
//    FeadBackService.instance.contactUS(param: body) { (success, message) in
//      if success{
//        let status = FeadBackService.instance.status
//        if status == 500{
//          print("500")
//        }
//        else if status == 404{
//          print("404")
//        }
//        else if status == 400{
//          print("400")
//        }
//        else if status == 200 || status == 201 || status == 202 {
//          print("200")
//          print("your Message is succefully send")
//          print("Stattus Message =", FeadBackService.instance.statusMsg)
//          self.nameTxtField.text = ""
//          self.emailTxtField.text = ""
//          self.phoneTxtField.text = ""
//          self.Message.text = ""
//          self.subjectTxtField.text = ""
//
//        }
//        else{
//          print("Error")
//          showSwiftMessageWithParams(theme: .error, title: "Feedback", body: "Something went wrong")
//        }
//      }
//      else{
//        let status = FeadBackService.instance.status
//        print(status)
//      }
//    }
//  }
//
//  private func delegateTf() {
//
//    emailTxtField.delegate = self
//    phoneTxtField.delegate = self
//    subjectTxtField.delegate = self
//    Message.delegate = self
//    nameTxtField.delegate = self
//
//  }
//
//  private func formattedNumber(number: String) -> String {
//    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//    let mask = "+X (XXX) XXX-XXXX"
//
//    var result = ""
//    var index = cleanPhoneNumber.startIndex
//    for ch in mask where index < cleanPhoneNumber.endIndex {
//      if ch == "X" {
//        result.append(cleanPhoneNumber[index])
//        index = cleanPhoneNumber.index(after: index)
//      } else {
//        result.append(ch)
//      }
//    }
//    return result
//  }
  
}

//MARK:- Extensions
//extension ContactUsViewController : UITextFieldDelegate, UITextViewDelegate {
//
//  func isValidEmail(email:String) -> Bool {
//    let emailRegEx = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+"
//    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//    return emailTest.evaluate(with: email)
//  }
//
//  func validTextFieldData(textField:UITextField){//
//    DispatchQueue.main.async {
//      self.flag = true
//      textField.resignFirstResponder()
//      textField.next?.becomeFirstResponder()
//    }
//  }
//
//  func unValidTextFieldData(textField:UITextField){
//    DispatchQueue.main.async {
//      self.flag = false
//      textField.becomeFirstResponder()
//    }
//  }
//  func unValidTextViewData(textField:UITextView){
//    DispatchQueue.main.async {
//      self.flag = false
//      textField.becomeFirstResponder()
//    }
//  }
//
//  func textFieldDidEndEditing(_ textField: UITextField) {
//
//    if textField == self.nameTxtField{
//
//      if (textField.text?.isEmpty)!{
//
//        print("Username Must 2 - 64 characters ")
//        textField.becomeFirstResponder
//      }
//
//      else{
//
//        if nameTxtField.text!.count <= 64 && nameTxtField.text!.count >= 2{
//
//        }
//        else{
//          unValidTextFieldData(textField:nameTxtField)
//          showSwiftMessageWithParams(theme: .info, title: "User Name", body: "Username must be between 2 to 64 characters")
//        }
//      }
//    }
//    else if textField == self.subjectTxtField{
//
//      if (textField.text?.isEmpty)!{
//        print("Username Must 6 - 64 characters ")
//        textField.becomeFirstResponder
//
//      }
//      else{
//        if subjectTxtField.text!.count <= 100 && subjectTxtField.text!.count >= 6{
//        }
//        else{
//          unValidTextFieldData(textField:subjectTxtField)
//          showSwiftMessageWithParams(theme: .info, title: "Feedback", body: "Subject must be 6 to 100 characters")
//        }
//      }
//    }else if textField == self.emailTxtField{
//      if (textField.text?.isEmpty)!{
//        print("email empty ")
//        textField.becomeFirstResponder
//      }
//      else{
//        if isValidEmail(email: emailTxtField.text!){
//        }
//        else{
//          unValidTextFieldData(textField:emailTxtField)
//          showSwiftMessageWithParams(theme: .info, title: "Feedback", body: "Invalid email format")
//        }
//      }
//    } else   if phoneTxtField.text!.count < 11 {
//      unValidTextFieldData(textField:phoneTxtField)
//      showSwiftMessageWithParams(theme: .info, title: "Feedback ", body: "Enter valid phone number")
//    }else{
//
//    }
//
//  }
//  //Hamza Amin
//
//
//
//  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    if textView == Message{
//
//      // Combine the textView text and the replacement text to
//      // create the updated text string
//      let currentText:String = textView.text
//      //          let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: text)
//      let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//      // If updated text view will be empty, add the placeholder
//      // and set the cursor to the beginning of the text view
//      if updatedText.isEmpty {
//
//        textView.text = "How can we become partners"
//        textView.textColor = UIColor.lightGray
//
//        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      }
//
//        // Else if the text view's placeholder is showing and the
//        // length of the replacement string is greater than 0, set
//        // the text color to black then set its text to the
//        // replacement string
//      else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//        textView.textColor = UIColor.black
//        textView.text = text
//
//      }
//
//        // For every other case, the text should change with the usual
//        // behavior...
//      else {
//        //      return updatedText.containsOnlyCharactersIn(matchCharacters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz12345678910,. ") && updatedText.count <= 300
//        return true
//      }
//
//      // ...otherwise return false since the updates have already
//      // been made
//      return false
//
//    }else{
//
//      return true
//
//    }
//
//  }
//
//  func textViewDidEndEditing(_ textView: UITextView) {
//    if textView == self.Message{
//
//      if (textView.text?.isEmpty)!{
//        print("Username Must 6 - 64 characters ")
//        textView.becomeFirstResponder
//        Message.text = "How can we become partners"
//        Message.textColor = UIColor.lightGray
//        Message.layer.borderColor = UIColor.black.cgColor
//
//      }
//      else{
//        if  Message.text!.count <= 300 && Message.text!.count >= 30 {
//        }
//        else{
//          unValidTextViewData(textField: Message)
//          showSwiftMessageWithParams(theme: .info, title: "Become a Partner", body: "Message length should be greater than 30 and less than 300 characters")
//        }
//      }
//    }
//  }
//
//}

//extension ContactUsViewController  {
//  
//  //MARK:- TextView Delegate
//  func textViewDidBeginEditing(_ textView: UITextView) {
//    //    Message.text = ""
//    
//    
//    if Message.textColor == UIColor.lightGray {
//      Message.text = nil
//      Message.textColor = UIColor.black
//      Message.layer.borderColor = UIColor.red.cgColor
//      
//    }
//  }
//  
//}
