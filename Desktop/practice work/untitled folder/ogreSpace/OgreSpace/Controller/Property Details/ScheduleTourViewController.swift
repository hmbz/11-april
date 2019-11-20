//
//  ScheduleTourViewController.swift
//  OgreSpace
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class ScheduleTourViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  
  @IBOutlet weak var selectDateTextFiled: UITextField!
  @IBOutlet weak var tourTimeTextFiled: UITextField!
  @IBOutlet weak var durationTextFiled: UITextField!
  @IBOutlet weak var moveIndateTextFiled: UITextField!
  @IBOutlet weak var fullNameTextFiled: UITextField!
  @IBOutlet weak var emailTextFiled: UITextField!
  @IBOutlet weak var PhoneNumberTextFiled: UITextField!
  @IBOutlet weak var CompanyTextFiled: UITextField!
  @IBOutlet weak var messageTextFiled: UITextField!
  
  @IBOutlet weak var scheduleTourBtn: UIButton!
  
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
  let pickerDate = UIDatePicker()
  let pickerDateforMoved = UIDatePicker()
  let pickerTime = UIDatePicker()
  let pickerView = UIPickerView()
  
  var propertyId = ""
  
  var myPickerData = ["Not Sure","1 Month or more","3 Month or more","6 Month or more","1 Year or more",]
  
  var paramsDictionary = [String:Any]()
  
  override func viewDidLoad() {
    
    addTopBar()
    super.viewDidLoad()
    pickerView.delegate = self
    textFieldMode()
    selector()
    scheduleTourBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    
  }
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "Schedule a Tour"
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
    
    dismiss(animated: true, completion: nil)
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }
  
  func  selector() {
    // #selector for date
    pickerDate.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
    
    // Tap Gesture for Date picker
    let tapForDate = UITapGestureRecognizer(target: self, action: #selector(self.timeTapped(gestrureForTime:)))
    view.addGestureRecognizer(tapForDate)
    
    // #selector for time
    pickerTime.addTarget(self, action: #selector(self.timeChanged(timePicker:)), for: .valueChanged)
    
    // Tap Gesture for Time picker
    let tapForTime = UITapGestureRecognizer(target: self, action: #selector(self.timeTapped(gestrureForTime:)))
    view.addGestureRecognizer(tapForTime)
    
    
    // #selector for date
    pickerDateforMoved.addTarget(self, action: #selector(self.dateChangedforMovedIn(datePickerForMoved:)), for: .valueChanged)
    
    // Tap Gesture for Date picker
    let tapForMoveDate = UITapGestureRecognizer(target: self, action: #selector(self.timeTapped(gestrureForTime:)))
    view.addGestureRecognizer(tapForMoveDate)
    
  }
  
  
  // Tap Gesture methode for Date picker
  @objc func timeTapped(gestrureForTime : UITapGestureRecognizer) {
    view.endEditing(true)
  }
  // date formate
  @objc func dateChanged(datePicker: UIDatePicker)
  {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    selectDateTextFiled.text = dateFormat.string(from: pickerDate.date)
    
  }
  
  @objc func dateChangedforMovedIn(datePickerForMoved: UIDatePicker)
  {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    moveIndateTextFiled.text = dateFormat.string(from: pickerDateforMoved.date)
    
  }
  
  //Methode of UIDate Picker
  @objc func timeChanged(timePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.short
    tourTimeTextFiled.text = dateFormatter.string(from: pickerTime.date)
    
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
    durationTextFiled.text = myPickerData[row]
  }
  
  
  func textFieldMode()  {
    //Setting Picker View Data Displaye type/Mode
    pickerDate.datePickerMode = .date
    pickerTime.datePickerMode = .time
    pickerDateforMoved.datePickerMode = .date
    
    //selected / picked date and time to text filed
    selectDateTextFiled.inputView = pickerDate
    tourTimeTextFiled.inputView = pickerTime
    moveIndateTextFiled.inputView = pickerDateforMoved
    durationTextFiled.inputView = pickerView
    
  }
  
  
  @IBAction func requestBookingButton(_ sender: Any) {
    
    if selectDateTextFiled.text!.isEmpty {      print("Please select date")
      selectDateTextFiled.becomeFirstResponder()
      
    }
    else if  tourTimeTextFiled.text!.isEmpty  {
      print("Please select time")
      tourTimeTextFiled.becomeFirstResponder()
    }
    else if moveIndateTextFiled.text!.isEmpty {
      print("Please duaration")
      moveIndateTextFiled.becomeFirstResponder()
    }
    else if durationTextFiled.text!.isEmpty {
      print("Please select date")
      durationTextFiled.becomeFirstResponder()
    }
    else if fullNameTextFiled.text!.isEmpty {
      print("Please TypeFUll name")
      fullNameTextFiled.becomeFirstResponder()
    }
    else if emailTextFiled.text!.isEmpty {
      print("Please fill email address")
      emailTextFiled.becomeFirstResponder()
    }
    else if PhoneNumberTextFiled.text!.isEmpty {
      print("Please type Phone Number")
      PhoneNumberTextFiled.becomeFirstResponder()
    }
    else if CompanyTextFiled.text!.isEmpty {
      print("Please select compnay")
      CompanyTextFiled.becomeFirstResponder()
    }
    else if messageTextFiled.text!.isEmpty {
      print("Please Type message")
      messageTextFiled.becomeFirstResponder()
    }else
    {
      paramsDictionary = [
        "move_in_date_optional" : selectDateTextFiled.text!,
        "requested_time" : tourTimeTextFiled.text!,
        "Duration_optional": durationTextFiled.text!,
        "requested_date" : moveIndateTextFiled.text!,
        "request_sender_name": fullNameTextFiled.text!,
        "request_sender_email" :     emailTextFiled.text!,
        "request_sender_mobile" : PhoneNumberTextFiled.text!,
        "request_sender_company": CompanyTextFiled.text!,
        "message": messageTextFiled.text!,
        "query_type":"schedule a tour",
        "property": self.propertyId.isEmpty || self.propertyId == "" ? "193193" : self.propertyId
      ]
      
      DetailPageService.instance.getScheduleTour(params: paramsDictionary){ (success) in
        
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
      dump(paramsDictionary)
    }
  }

}
