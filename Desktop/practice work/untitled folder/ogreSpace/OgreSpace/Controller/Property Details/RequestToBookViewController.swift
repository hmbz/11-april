//
//  RequestToBookViewController.swift
//  OgreSpace
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class RequestToBookViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


  @IBOutlet weak var selectDateFiled: UITextField!
  @IBOutlet weak var selectDurationFiled: UITextField!
  @IBOutlet weak var NameFiled: UITextField!
  @IBOutlet weak var EmailFiled: UITextField!
  @IBOutlet weak var phoneNoFiled: UITextField!
  @IBOutlet weak var compnayNameFiled: UITextField!
  @IBOutlet weak var messageFiled: UITextField!
  
  @IBOutlet weak var requestToBookBtn: UIButton!
  @IBOutlet weak var bookBtnWidthConstraint: NSLayoutConstraint!
  
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  //  objects of UIDatePickerClass
  let pickerDate = UIDatePicker()
  let pickerView = UIPickerView()
  
  var myPickerData = ["Not Sure","1 Month or more","3 Month or more","6 Month or more","1 Year or more",]
  
  var dictionaryOfRequest = [String:Any]()
  var propertyId = ""
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    addTopBar()
    pickerView.delegate = self
    textFiledMode()
    selector()
    requestToBookBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
//    bookBtnWidthConstraint.constant = self.view.frame.width / 2
    print(propertyId)
    
    
  }
  
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "Request to Book"
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
  
  // Tap Gesture methode for Date picker
  @objc func timeTapped(gestrureForTime : UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  @objc func dateChanged(datePicker: UIDatePicker)
  {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    selectDateFiled.text = dateFormat.string(from: pickerDate.date)
  }
  
  func  selector() {
    // #selector for date
    pickerDate.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
    
    // Tap Gesture for Date picker
    let tapForDate = UITapGestureRecognizer(target: self, action: #selector(self.timeTapped(gestrureForTime:)))
    view.addGestureRecognizer(tapForDate)
  }
  
  // MARK: UIPickerView Delegation
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return myPickerData.count
  }
  
  func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return myPickerData[row]
  }
  
  func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectDurationFiled.text = myPickerData[row]
  }
  
  func textFiledMode()  {
    //Setting Picker View Data Displaye type/Mode
    pickerDate.datePickerMode = .date
    
    //selected / picked date and time to text filed
    selectDateFiled.inputView = pickerDate
    selectDurationFiled.inputView = pickerView
  }
  
  @IBAction func requstBookingButton(_ sender: Any) {
    
    if selectDateFiled.text!.isEmpty {
      print("Please select date")
      selectDateFiled.becomeFirstResponder()
    }
    else if  selectDurationFiled.text!.isEmpty  {
      print("Please select time")
      selectDurationFiled.becomeFirstResponder()
    }
    else if NameFiled.text!.isEmpty {
      print("Please duaration")
      NameFiled.becomeFirstResponder()
    }
    else if EmailFiled.text!.isEmpty {
      print("Please select date")
      EmailFiled.becomeFirstResponder()
    }
    else if phoneNoFiled.text!.isEmpty {
      print("Please TypeFUll name")
      phoneNoFiled.becomeFirstResponder()
    }
    else if compnayNameFiled.text!.isEmpty {
      print("Please fill email address")
      compnayNameFiled.becomeFirstResponder()
    }
    else if messageFiled.text!.isEmpty {
      print("Please select compnay")
      messageFiled.becomeFirstResponder()
    }
    else
    {
      dictionaryOfRequest = [
        "move_in_date_optional" : selectDateFiled.text!,
        "Duration_optional": selectDurationFiled.text!,
        "request_sender_name": NameFiled.text!,
        "request_sender_email" :     EmailFiled.text!,
        "request_sender_mobile" : phoneNoFiled.text!,
        "request_sender_company": compnayNameFiled.text!,
        "message": messageFiled.text!,
        "query_type": "request for book",
        "property": self.propertyId.isEmpty || self.propertyId == "" ? "193193" : self.propertyId
      ]

      DetailPageService.instance.getRequestToBook(params: dictionaryOfRequest){ (success) in
        
        if success{
          
          let message = DetailPageService.instance.responseMessage
          showSwiftMessageWithParams(theme: .success, title: "Success", body: "\(message)")
//         self.view.makeToast()
          
        }else{
          
          let message = DetailPageService.instance.responseMessage
          showSwiftMessageWithParams(theme: .error, title: "Something went wrong", body: "\(message)")
//          self.view.makeToast(DetailPageService.instance.responseMessage)
          
        }
        
      }
//      dump(dictionaryOfRequest)
    }
    
  }
}
