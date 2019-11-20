//
//  PaymentMethodViewController.swift
//  OgreSpace
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PaymentMethodViewController: UIViewController {
  
  @IBOutlet weak var savedCardTableView: UITableView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var paymentSegmentControl: UISegmentedControl!
  @IBOutlet weak var enrollAsAutopayBtn: UISwitch!
  @IBOutlet weak var setAsDefaultSwitchBtn: UISwitch!
  @IBOutlet weak var paymentCardDetailsCollectionView: UICollectionView!
  @IBOutlet weak var addBtn: UIButton!
  
  @IBOutlet weak var nickNameTf: SkyFloatingLabelTextField!
  @IBOutlet weak var cardHolderTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var streetAddressTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var countryTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var zipCodeTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var expiryDateTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var cvvNoTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var creditCardTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var discoverCardBtn: UIButton!
  @IBOutlet weak var visaCardBtn: UIButton!
  @IBOutlet weak var masterCardBtn: UIButton!
  @IBOutlet weak var shadowUIView: UIView!
  
  @IBOutlet weak var cardImageView: UIImageView!
  lazy var cardType = "Master"
  let expiryDatePicker = MonthYearPickerView()
  let cardImages: [String] = ["Master_1-15","Visa-15","Discover_1-15"]
  let fieldsValueArray: [String] = ["Card Holder","Card Number","CVV","Expiry Date","Set As Default","Delete"]
  let secondValueArray: [String] = ["Set As Default","Delete"]
  var flag:Bool?
  var setAsDefault: Bool =  false
  var enrollAsAutopay: Bool = false
  let buttonDelete   = UIButton(type: UIButton.ButtonType.custom) as UIButton
  let buttonToggel   = UIButton(type: UIButton.ButtonType.custom) as UIButton
  
  var selectedCardType: String? {
    didSet{
      reformatAsCardNumber(textField: creditCardTextField)
    }
  }
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  override func viewDidLoad() {
    super.viewDidLoad()
    creditCardTextField.delegate = self
    topMenu()
    setUpViews()
    //    creditCardTextField.addTarget(self, action: #selector(self.reformatAsCardNumber(textField, for: UIControlEvents.editingChanged)
    creditCardTextField.addTarget(self, action: #selector(self.reformatAsCardNumber(textField:)), for: UIControl.Event.editingChanged)
    cvvNoTextField.delegate = self
    expiryDateTextField.delegate = self
    zipCodeTextField.delegate = self
    createDatePicker()
    savedCardTableView.isHidden = true
    paymentMethodAPI{(success) in
      DispatchQueue.main.async {
        //        self.paymentCardDetailsCollectionView.reloadData()
        self.savedCardTableView.reloadData()
      }
    }
    //        let imageViewForLogo = UIImageView(image:#imageLiteral(resourceName: "Home Screen LogosB"))
    //        navigationItem.titleView = imageViewForLogo
    //        imageViewForLogo.contentMode = .scaleAspectFit
    // Do any additional setup after loading the view.
  }
  //  override func viewDidDisappear(_ animated: Bool) {
  //    paymentCardDetailSerivce.instance.paymentCardDetailArray.removeAll()
  //  }
  @IBAction func cardSegmentControl(_ sender: Any) {
    let getIndex = paymentSegmentControl.selectedSegmentIndex
    print(getIndex)
    switch getIndex {
    case 0:
      savedCardTableView.isHidden = true
      contentView.isHidden = false
    case 1 :
      savedCardTableView.isHidden = false
      contentView.isHidden = true
      
      paymentMethodAPI{(success) in
        
        DispatchQueue.main.async {
          
          self.savedCardTableView.reloadData()
        }
        
      }
      
    default:
      print("No Index")
    }
  }
  private func topMenu() {
    
    self.navigationItem.titleView = titleview
    
    titleview.titleLbl.text = "Payment Method"
    
    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    
    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    
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
    
    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    
    appDelegate.window?.rootViewController = initialViewController
    
    appDelegate.window?.makeKeyAndVisible()
    
  }
  
  
  
  // invite button functionality
  
//  @objc override func inviteBtnTapped(sender: UIButton) {
//    
//    
//    let shareString : String = "Hi, I want to invite you to download and start using the FREE OgreSpace App for Listings, Demographics, AI-Driven Insights. OgreSpace - The Next Generation Commercial Real Estate Universe."
//    
//    let urlAppStore = URL.init(string: "https://apps.apple.com/us/app/ogrespace/id1470936840")!
//    
//    let items =  [shareString, urlAppStore] as [ Any ]
//    
//    let activityVC = UIActivityViewController(activityItems: items, applicationActivities: [])
//    
//    activityVC.popoverPresentationController?.sourceView = self.view
//    
//    if let popoverController = activityVC.popoverPresentationController{
//      
//      
//      
//      popoverController.barButtonItem = sender as? UIBarButtonItem
//      
//      popoverController.permittedArrowDirections = .up
//      
//      
//      
//      
//      //      popoverController.sourceView = sender as! UIView
//      
//      //      popoverController.sourceRect = (tableView.cellForRow(at: indexPath)?.bounds)!
//      
//    }
//    
//    self.present(activityVC, animated:true , completion: nil)
//    
//  }
  
  
  
  // setting the topbar View Height
  
  override func viewLayoutMarginsDidChange() {
    
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    
    print("titleview width = \(titleview.frame.width)")
    
  }
  func setUpViews(){
    cvvNoTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    creditCardTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    expiryDateTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    cityTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    zipCodeTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    stateTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    countryTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    streetAddressTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    cardHolderTextField.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    nickNameTf.tintColor = #colorLiteral(red: 0.6745098039, green: 0.05882352941, blue: 0.01176470588, alpha: 1)
    shadowUIView.layer.shadowOpacity = 1
    shadowUIView.layer.shadowRadius = 2
    //        var shadowOffsetHeight: Int = 3
    shadowUIView.layer.shadowOffset = CGSize(width: 0, height: 1)
    shadowUIView.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    shadowUIView.layer.cornerRadius = 6
    masterCardBtn.makeRoundedCorners(cornerRadius: 12)
    visaCardBtn.makeRoundedCorners(cornerRadius: 12)
    discoverCardBtn.makeRoundedCorners(cornerRadius: 12)
    addBtn.makeRoundedCorners(cornerRadius: 12)
    masterCardBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    visaCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    discoverCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    visaCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    discoverCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    cardImageView.image = UIImage(named: cardImages[0])
  }
  func paymentMethodAPI(completion: @escaping CompletionHandler){
    paymentCardDetailSerivce.instance.paymentCardDetailMethod{(success) in
      DispatchQueue.main.async {
        //        self.paymentCardDetailsCollectionView.reloadData()
        
        self.savedCardTableView.reloadData()
      }
    }
  }
  
  @objc func reformatAsCardNumber(textField:UITextField){
    let formatter = CreditCardFormatter()
    var isAmex = false
    if selectedCardType == "AMEX" {
      isAmex = true
    }
    
    formatter.formatToCreditCardNumber(isAmex: isAmex, textField: textField, withPreviousTextContent: textField.text, andPreviousCursorPosition: textField.selectedTextRange)
  }
  
  @IBAction func masterCardBtnTapped(_ sender: UIButton) {
    cardType = "Master"
    masterCardBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    masterCardBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    visaCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    visaCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    discoverCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    discoverCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    cardImageView.image = UIImage(named: cardImages[0])
    //    if sender.isSelected == true {
    //      cardHolderTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.editingDidBegin)
    ////      isValidMaster(name: creditCardTextField.text!)
    //    }
  }
  
  @IBAction func visaCardBtnTapped(_ sender: Any) {
    cardType = "Visa"
    visaCardBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    visaCardBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    masterCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    masterCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    discoverCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    discoverCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    cardImageView.image = UIImage(named: cardImages[1])
  }
  
  @IBAction func enrollAsAutopay(_ sender: Any) {
    if enrollAsAutopayBtn.isOn == true {
      enrollAsAutopay = true
      
    }
    else {
      enrollAsAutopay = false
    }
  }
  @IBAction func setAsDefaultBtnTapped(_ sender: Any) {
    if setAsDefaultSwitchBtn.isOn == true {
      setAsDefault = true
    }
    else {
      
      setAsDefault = false
      
    }
  }
  @IBAction func paymentCreditCardAddBtn(_ sender: Any) {
    creditCardPostAPI()
  }
  
  func isStringAnInt(string: String) -> Bool {
    return Int(string) != nil
  }
  // @objc func textFieldDidBeginEditing(_ textField: UITextField) {
  //
  //    if isValidVisa(name: creditCardTextField.text!){
  //    }else if isValidMaster(name: creditCardTextField.text!){
  //    }else if isValidDiscovery(name: creditCardTextField.text!) {
  //    }
  //    else{
  //      unValidTextFieldData(textField:creditCardTextField)
  //      self.view.makeToast(" Expiry Date Will be in MM/YYYY", duration: 2.0, position: .center)
  //    }
  //
  //  }
  func creditCardPostAPI(){
    let body:[String:Any] = [
    
      "name": cardHolderTextField.text!,
      "number": creditCardTextField.text!,
      "cvc": cvvNoTextField.text!,
      "expDate": expiryDateTextField.text!,
      "street_address": streetAddressTextField.text!,
      "zipcode": zipCodeTextField.text!,
      "city": cityTextField.text!,
      "state": stateTextField.text!,
      "country": countryTextField.text!,
      "card_type": "Visa",
      "autopay": enrollAsAutopay,
      "nickname": nickNameTf.text!
     
    ]
    print(body,"parameters")
    paymentCardDetailSerivce.instance.paymentCardDetailPostMethod(param: body) { (success) in
      if success{
        let status = paymentCardDetailSerivce.instance.status
        print("status", status)
        if status == 200{

          let myAlert = UIAlertController(title: "Success", message: "Your Password has been Changed", preferredStyle: UIAlertController.Style.alert )
          let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)

          })
          myAlert.addAction(ok)
          self.present(myAlert, animated: true, completion: nil)
        }else{

          let myAlert = UIAlertController(title: "Dear User", message: "Credit Card is added", preferredStyle: UIAlertController.Style.alert )
          let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)

          })
          myAlert.addAction(ok)
          self.present(myAlert, animated: true, completion: nil)
        }
      }else{
        let myAlert = UIAlertController(title: "Sorry", message: "Server Is Under Maintenance!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
          self.dismiss(animated: true, completion: nil)

        })
        myAlert.addAction(ok)
        self.present(myAlert, animated: true, completion: nil)

      }

    }
    paymentMethodAPI{(success) in
      DispatchQueue.main.async {
        //        self.paymentCardDetailsCollectionView.reloadData()
        self.savedCardTableView.reloadData()
      }
    }
  }
  func createDatePicker() {
    expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
      let string = String(format: "%02d/%d", month, year)
      NSLog(string) // should show something like 05/2015
      self.expiryDateTextField.text = string
    }
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(duedone))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolbar.setItems([spaceButton1, spaceButton2,doneButton], animated: false)
    expiryDateTextField.inputAccessoryView = toolbar
    expiryDateTextField.inputView = expiryDatePicker
    
    
  }
  
  @objc func duedone() {
    
    //    expiryDateTextField.text = dateFormatter.string(from: expiryDatePicker.months)
    self.view.endEditing(true)
    
    let datePickerr = expiryDateTextField.text
    print(datePickerr!)
    
    //        dueDatePicker.isUserInteractionEnabled = false
    expiryDatePicker.isUserInteractionEnabled = true
    let postedDate = expiryDateTextField.text
    
  }
  @IBAction func discoverBtnTapped(_ sender: Any) {
    cardType = "Discover"
    discoverCardBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    discoverCardBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    visaCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    visaCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    masterCardBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    masterCardBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    cardImageView.image = UIImage(named: cardImages[2])
  }
  @objc func setAsDefaultValue(_ sender: UIButton) {
    print(" setAsDefaultValue btn tapped")
  }
  @objc func deleteRecord(_ sender: UIButton) {
    print(" deleteRecord btn tapped")
  }
  @objc func deleteFromNotificationTbl(_ sender: UIButton) {
    let key = paymentCardDetailSerivce.instance.paymentCardDetailArray[sender.tag].detailID

//    let urlString = "https://apis.rfpgurus.com/payment/cardinfodelete/" + "\(key!)"
//    print(urlString)
//    paymentCardDetailSerivce.instance.paymentCardDetailArray.remove(at: sender.tag)
//    DeletePaymentCardServices.instance.deleteSpecificSavedPaymentCard(urlStr: urlString){(success) in
//      if (success){
//        self.paymentMethodAPI{(success) in
//          DispatchQueue.main.async {
//            //        self.paymentCardDetailsCollectionView.reloadData()
//            self.savedCardTableView.reloadData()
//          }
//        }
//        print("success fully deleted notification")
//        self.view.makeToast("Credit Card is deleted", duration: 2.0, position: .center)
//
//        DispatchQueue.main.async {
//          self.savedCardTableView.reloadData()
//
//        }
//        //
//      }
//      else{
//
//
//        self.view.makeToast("not deleted notification", duration: 2.0, position: .center)
//      }
//    }
  }
}
extension PaymentMethodViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return paymentCardDetailSerivce.instance.paymentCardDetailArray.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = savedCardTableView.dequeueReusableCell(withIdentifier: "paymentCardTableViewCell", for: indexPath) as! paymentCardTableViewCell
    let instance = paymentCardDetailSerivce.instance.paymentCardDetailArray[indexPath.row]
    cell.cardHolderLbl.text = instance.nickName
    cell.cardNumberLbl.text = instance.cardNumber
    cell.expiryDateLbl.text = instance.expiryCardDate
    cell.deleteBtn.tag = indexPath.row
    cell.deleteBtn.addTarget(self, action: #selector(deleteFromNotificationTbl(_:)), for: .touchUpInside)
    return cell
  }
  
  
  
}
extension PaymentMethodViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return paymentCardDetailSerivce.instance.paymentCardDetailArray.count
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    let cell = paymentCardDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodDetailCollectionViewCell", for: indexPath) as! PaymentMethodDetailCollectionViewCell
    //    let cell2 = paymentCardDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodDetailCollectionViewCell2", for: indexPath) as! PaymentMethodDetailCollectionViewCell
    //    cell2.fieldsLbl.text = secondValueArray[indexPath.row]
//    cell.fieldsLbl.text = fieldsValueArray[indexPath.row]
//
//    if indexPath.row == 0 {
//
//      cell.valueLbl.text = paymentCardDetailSerivce.instance.paymentCardDetailArray[indexPath.row].nickName
//
//    }
//
//    if indexPath.row == 1 {
//
//      cell.valueLbl.text = paymentCardDetailSerivce.instance.paymentCardDetailArray[indexPath.row].cardNumber
//
//    }
//    if indexPath.row == 2 {
//      cell.valueLbl.text = paymentCardDetailSerivce.instance.paymentCardDetailArray[indexPath.row].paymentCardCVV
//    }
//    if indexPath.row == 3 {
//      cell.valueLbl.text = paymentCardDetailSerivce.instance.paymentCardDetailArray[indexPath.row].expiryCardDate
//    }
//    if indexPath.row == 4 {
//      cell.valueLbl.text = nil
//      let image = UIImage(named: "Toggle On-15") as UIImage?
//      //        let button   = UIButton(type: UIButtonType.custom) as UIButton
//      //        button.frame = CGRect(x: 60, y: 10, width: 60, height: 60)
//      buttonToggel.setImage(image, for: .normal)
//      buttonToggel.addTarget(self, action: #selector(setAsDefaultValue(_:)), for: .touchUpInside)
//      //      button.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
//      //      let uiView:UIView = self.view.addSubview(button)
//      cell.valueLbl.addSubview(buttonToggel)
//
//
//    }
//    if indexPath.row == 5 {
//      cell.valueLbl.text = nil
//      let image = UIImage(named: "Delete-15") as UIImage?
//      //        let button   = UIButton(type: UIButtonType.custom) as UIButton
//      //        button.frame = CGRect(x: 60, y: 10, width: 60, height: 60)
//      buttonDelete.setImage(image, for: .normal)
//      buttonDelete.addTarget(self, action: #selector(deleteRecord(_:)), for: .touchUpInside)
//      //      button.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
//      //      let uiView:UIView = self.view.addSubview(button)
//      cell.valueLbl.addSubview(buttonDelete)
//
//    }
//
//    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad{
//      buttonDelete.frame = CGRect(x: 30, y: -30, width: 120, height: 120)
//      buttonToggel.frame = CGRect(x: 30, y: -30, width: 120, height: 120)
//    }
//    else {
//      buttonToggel.frame = CGRect(x: 60, y: 10, width: 60, height: 60)
//      buttonDelete.frame = CGRect(x: 60, y: 10, width: 60, height: 60)
//    }
    return UICollectionViewCell()
  }
  
  
}
extension PaymentMethodViewController: UITextFieldDelegate {
  func isValidExpiry(name:String) -> Bool{
    
    let expiryDate = "(0[1-9]|10|11|12)/20[0-9]{2}$"
    
    let nameTest = NSPredicate(format:"SELF MATCHES %@", expiryDate)
    
    return nameTest.evaluate(with: name)
    
  }
  
  func isValidVisa(name:String) -> Bool{
    
    let expiryDate = "^4[0-9]{12}(?:[0-9]{3})?$"
    
    //      ^(0[1-9]|1[0-2])\/?(([0-9]{4}|[0-9]{2})$)
    
    let nameTest = NSPredicate(format:"SELF MATCHES %@", expiryDate)
    
    return nameTest.evaluate(with: name)
    
  }
  
  func isValidDiscovery(name:String) -> Bool{
    
    let expiryDate = "^6(?:011|5[0-9]{2})[0-9]{12}$"
    
    //      ^(0[1-9]|1[0-2])\/?(([0-9]{4}|[0-9]{2})$)
    
    let nameTest = NSPredicate(format:"SELF MATCHES %@", expiryDate)
    
    return nameTest.evaluate(with: name)
    
  }
  
  func isValidMaster(name:String) -> Bool{
    
    let expiryDate = "^5[1-5][0-9]{14}$"
    
    //      ^(0[1-9]|1[0-2])\/?(([0-9]{4}|[0-9]{2})$)
    
    let nameTest = NSPredicate(format:"SELF MATCHES %@", expiryDate)
    
    return nameTest.evaluate(with: name)
    
  }
  
  func isValidCCV(name:String) -> Bool{
    
    let expiryDate = "^[0-9]{3,3}$"
    
    //      ^(0[1-9]|1[0-2])\/?(([0-9]{4}|[0-9]{2})$)
    
    let nameTest = NSPredicate(format:"SELF MATCHES %@", expiryDate)
    
    return nameTest.evaluate(with: name)
    
  }
  

  func textFieldDidEndEditing(_ textField: UITextField) {
    print(textField)
    if textField == self.expiryDateTextField{
      if (textField.text?.isEmpty)!{
        print("Please Enter Expiry Date of Card in MM/YYYY")
        textField.becomeFirstResponder()
      }
      else{
        if isValidExpiry(name: expiryDateTextField.text!){
        }
        //        else{
        //          unValidTextFieldData(textField:expiryDateTextField)
        //          self.view.makeToast(" Expiry Date Will be in MM/YYYY", duration: 2.0, position: .center)
        //        }
      }
    }
      
    else if textField == self.cvvNoTextField{
      if (textField.text?.isEmpty)!{
        print("Please Enter CCV Number")
        textField.becomeFirstResponder()
      }
      else{
        if isValidCCV(name: cvvNoTextField.text!){
        }
        else
        {
          unValidTextFieldData(textField:cvvNoTextField)
          self.view.makeToast("enter 3 digit CCV Number", duration: 2.0, position: .center)
        }
      }
    }
      
      
    else if textField == self.creditCardTextField{
      if (textField.text?.isEmpty)!{
        print("Please Enter CCV Number")
        textField.becomeFirstResponder()
      }
      else {
        if (creditCardTextField.text?.count)! < 16{
          
          print("Please Enter 16 Digit Credit Card Number")
          
          textField.becomeFirstResponder()
          
        }
          
        else{
          
          if self.cardType == "Visa" {
            
            let cardnumber = creditCardTextField.text
            
            let final = cardnumber?.replacingOccurrences(of: "-", with: "")
            
            if isValidVisa(name: final!){
              
              
              
            }
              
            else{
              
              unValidTextFieldData(textField:creditCardTextField)
              
              self.view.makeToast("Please Enter Right Visa Card Number", duration: 2.0, position: .center)
              
            }
            
          }
            
          else if self.cardType == "Master" {
            
            let cardnumber = creditCardTextField.text
            
            let final = cardnumber?.replacingOccurrences(of: "-", with: "")
            
            if isValidMaster(name: final!){
              
              
              
              
              
            }
              
            else{
              
              unValidTextFieldData(textField:creditCardTextField)
              
              self.view.makeToast("Please Enter Right Master Card Number", duration: 2.0, position: .center)
              
            }
            
          }
            
          else if self.cardType == "Discover" {
            
            let cardnumber = creditCardTextField.text
            
            let final = cardnumber?.replacingOccurrences(of: "-", with: "")
            
            if isValidDiscovery(name: final!) {
              
              
              
            }
              
              
              
            else{
              
              unValidTextFieldData(textField:creditCardTextField)
              
              self.view.makeToast("Please Enter Right Discover Card Number", duration: 2.0, position: .center)
              
            }
            
          }
          
        }
      }
    }
      //
      //     if textField == self.creditCardTextField{
      //      if (creditCardTextField.text?.isEmpty)!{
      //        print("Please Enter Credit Card Number")
      //        textField.becomeFirstResponder
      //      }
      //      else {
      //      if (creditCardTextField.text?.count)! < 14{
      //        print("Please Enter 16 Digit Credit Card Number")
      //        textField.becomeFirstResponder
      //      }
      //
      //
      //        if self.cardType == "Visa" {
      //
      //          let cardnumber = creditCardTextField.text
      //
      //          let final = cardnumber?.replacingOccurrences(of: "-", with: "")
      //
      //          if isValidVisa(name: final!){
      //
      //
      //
      //          }
      //
      //          else{
      //
      //            unValidTextFieldData(textField:creditCardTextField)
      //
      //            self.view.makeToast("Please Enter Right Visa Card Number", duration: 2.0, position: .center)
      //
      //          }
      //
      //        }
      //      }}
    else if textField == self.zipCodeTextField
    {
      let checkDigit = (zipCodeTextField.text!)
      let digit = Int(zipCodeTextField.text!)
      let flag:Bool = isStringAnInt(string:checkDigit)
      
      if textField == self.zipCodeTextField{
        if (textField.text?.isEmpty)!{
          print("zipcode  empty ")
          textField.becomeFirstResponder()
        }else if(flag == false){
          self.view.makeToast("Zip Code Cannot contain Alphabets", duration: 4.0, position: .center)
          
          DispatchQueue.main.async {
            textField.becomeFirstResponder()
          }
          
        }else if(checkDigit.count > 5 || checkDigit.count < 5) {
          self.view.makeToast("Zip Code Contains Only 5 Digits", duration: 4.0, position: .center)
          DispatchQueue.main.async {
            textField.becomeFirstResponder()
          }
        }else{
          
          DispatchQueue.main.async {
            //            self.fidgetSpinner.isHidden = false
            //            self.fidgetSpinner.loadGif(name: "name")
            //                        self.view.alpha = 0.5
//            zipcodeService.instance.zipCode(text: self.zipCodeTextField.text!, completion: { (success) in
//              if success{
//                print("success")
//
//                self.cityTextField.text = zipcodeService.instance.zipCodeModelInstance[0].city
//                self.stateTextField.text = zipcodeService.instance.zipCodeModelInstance[0].state
//                self.countryTextField.text = zipcodeService.instance.zipCodeModelInstance[0].country
//                textField.resignFirstResponder()
//                self.countryTextField.becomeFirstResponder()
//                //                self.fidgetSpinner.isHidden = true
//                self.view.alpha = 1
//
//              }else{
//                print("not success")
//                self.view.makeToast("Not Success", duration: 2.0, position: .center)
//                //                self.fidgetSpinner.isHidden = true
//                self.view.alpha = 1
//              }
//            })
          }
        }
      }
      
    }
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == expiryDateTextField {
      if string == "" {
        return true
      }
      let currentText = textField.text! as NSString
      let updatedText = currentText.replacingCharacters(in: range, with: string)
      textField.text = updatedText
      let numberOfCharacters = updatedText.count
      if numberOfCharacters == 2 {
        textField.text?.append("/")
      }
      return false
    }
    else if textField == cvvNoTextField {
      let maxLength = 3
      let currentString: NSString = textField.text! as NSString
      let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
      return newString.length <= maxLength
    }
    else if textField == zipCodeTextField {
      let maxLength = 5
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

