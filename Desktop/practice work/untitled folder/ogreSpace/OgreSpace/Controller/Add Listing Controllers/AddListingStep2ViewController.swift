//
//  AddListingStep2ViewController.swift
//  OgreSpace
//
//  Created by admin on 7/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddListingStep2ViewController: UIViewController {
  
    //MARK:- IBOutlets
  
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var areaTextField: UITextField!
  @IBOutlet weak var priceTypeTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var contactTextField: UITextField!
  @IBOutlet weak var serviceTextView: UITextView!
  @IBOutlet weak var servicesTableView: UITableView!
  @IBOutlet weak var servicesView: UIView!
  @IBOutlet weak var servicesTVBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var nextBtn: UIButton!
  
  
  
    //MARK:- Properties
  
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  let priceTypePicker = UIPickerView()
  let priceTypeArray = ["per person per year", "per month", "per year"]
  lazy var overviewArray = [OverviewModel]()
  
  lazy var selectedOverviewsArray = [String]()
  lazy var selectedOverviewIdsArray = [Int]()
  lazy var step1Params = [String: Any]()
  
    //MARK:- View Life Cycle
  
    override func viewDidLoad() {
      
      super.viewDidLoad()
      setUpViews()

    }
  
  //MARK: Setup Views
  
  private func setUpViews(){
    
    addTopBar()
    addPriceTypePicker()
    serviceTextView.delegate = self
    priceTypeTextField.delegate = self
    servicesTVBottomConstraint.constant = -350
    servicesTableView.delegate = self
    servicesTableView.dataSource = self
    getServices()
    servicesTableView.backgroundColor = .clear
    makeServicesViewBlurr()
    backBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    nextBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    
  }
  
    //MARK:- Actions
  
  @IBAction func serviceSelectionDoneButton(_ sender: Any) {
    
//    let addListingSB = UIStoryboard(name: "AddListing", bundle: nil)
//    let overviewVC = addListingSB.instantiateViewController(withIdentifier: "PropertyOverviewViewController") as! PropertyOverviewViewController
//    overviewVC.selectedOverviewArray = selectedOverviewsArray
//    let navController = UINavigationController(rootViewController: overviewVC)
//    present(navController, animated: true)
    self.toggleServicesTableView(flag: false)
    
  }
  
  @IBAction func serviceSelectionCancelButton(_ sender: Any) {
    
    self.toggleServicesTableView(flag: false)
    
  }
  
  @IBAction func BackBtnTapped(_ sender: Any) {
  
  self.navigationController?.popViewController(animated: true)
  
  }
  
  @IBAction func NextBtnTapped(_ sender: Any) {
  
    if priceTextField.text!.isEmpty {
      
      priceTextField.shake()
      self.view.makeToast("Please enter listing price ", duration: 3.0, position: .top)
      
    }else if areaTextField.text!.isEmpty {
      
      areaTextField.shake()
      self.view.makeToast("Please enter listing area", duration: 3.0, position: .top)
      
    }else if priceTypeTextField.text!.isEmpty {
      
      priceTypeTextField.shake()
      self.view.makeToast("Please enter price type", duration: 3.0, position: .top)
      
    }else if descriptionTextField.text!.isEmpty {
      
      descriptionTextField.shake()
      self.view.makeToast("Please enter listing description", duration: 3.0, position: .top)
      
    }else if contactTextField.text!.isEmpty {
      
      contactTextField.shake()
      self.view.makeToast("Please enter contact number", duration: 3.0, position: .top)
      
    }else if serviceTextView.text!.isEmpty {
      
      self.view.makeToast("Please enter at least one service", duration: 3.0, position: .top)
      
    }else {
      
      var step1and2ParamsDict: [String: Any] = [
        
        "price": priceTextField.text!,
        "property_area": areaTextField.text!,
        "price_type": priceTypeTextField.text!,
        "overview": descriptionTextField.text!,
        "contact_no": contactTextField.text!,
        "mapped_services": selectedOverviewIdsArray
        
      ]
      step1and2ParamsDict.merge(dict: step1Params)
      let overviewVC = storyboard?.instantiateViewController(withIdentifier: "PropertyOverviewViewController") as! PropertyOverviewViewController
      overviewVC.selectedOverviewArray = selectedOverviewsArray
//      vc.step1and2ParametersDictionary = step1and2ParamsDict

      navigationController?.pushViewController(overviewVC, animated: true)
      
    }
  
  }
  
  //MARK:- Private Functions
  
  
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
  
  private func makeServicesViewBlurr(){
    
    let blurView = UIVisualEffectView()
    // Make its frame equal the main view frame so that every pixel is under blurred
    blurView.frame = servicesView.frame
    // Choose the style of the blur effect to regular.
    // You can choose dark, light, or extraLight if you wants
    blurView.effect = UIBlurEffect(style: .dark)
    // Now add the blur view to the main view
    servicesView.addSubview(blurView)
    
  }
  
  
  private func addPriceTypePicker() {
    priceTypePicker.delegate = self
    priceTypePicker.dataSource = self
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnTapped))
    doneButton.tintColor =  _ColorLiteralType(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    toolbar.setItems([spaceButton1, spaceButton2,doneButton], animated: false)
    priceTypeTextField.inputAccessoryView = toolbar
    priceTypeTextField.inputView = priceTypePicker
    
  }
  
  @objc private func doneBtnTapped(textField : UITextField){
    
    priceTypeTextField.resignFirstResponder()
    
  }
  
  //MARK: API Calls
  
  func getServices() {
    
    Networking.instance.getApiCall(url: propertyOverviewUrl, header: nil){(responseData, error, statusCode) in
      
      if error == nil && statusCode == 200{
        
        guard let OverviewArray = responseData.array else {return}

        for item in OverviewArray {
          guard let overviewDict = item.dictionary else{
            return
          }
          guard let id = overviewDict["id"]?.int else {return}
          guard let overviewName = overviewDict["feature_name"]?.string else {return}
          let overviewLogo = overviewDict["logo_of_services_24px"]?.string ?? ""
//          let isSelected = serviceDict.value(forKey: "chck_bool") as? Bool ?? false
          let overviewObj = OverviewModel(overviewId: id, overviewName: overviewName, overviewIcon: overviewLogo, isChecked: false)
          self.overviewArray.append(overviewObj)
        }
        DispatchQueue.main.async {
          self.servicesTableView.reloadData()
        }
      }
      
    }
//    AddListingService.instance.getServices{(success) in
//      print("success")
//      DispatchQueue.main.async {
//        self.servicesTableView.reloadData()
//      }
//    }
  }

}

extension AddListingStep2ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
  
  //MARK:- UIPickerView Extension
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return priceTypeArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    let priceType = priceTypeArray[row]
    priceTypeTextField.text = priceType
    return priceType
    
  }
  
}

extension AddListingStep2ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.overviewArray.count
//    return AddListingService.instance.servicesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as! ServiceTableViewCell
    let overviewArray = self.overviewArray[indexPath.row]
    cell.serviceNameLabel.text = overviewArray.overviewName
    cell.backgroundColor = .clear
    cell.contentView.backgroundColor = .clear
    if  overviewArray.isChecked {
      
      cell.checkBoxButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
      selectedOverviewsArray.append(overviewArray.overviewName)
      selectedOverviewIdsArray.append(overviewArray.overviewId)
      
    }else {
      
      selectedOverviewsArray.removeAll(where: { $0 == overviewArray.overviewName })
      selectedOverviewIdsArray.removeAll(where: { $0 == overviewArray.overviewId })
      cell.checkBoxButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
      
    }
    cell.checkBoxButton.tag = indexPath.row
    cell.checkBoxButton.addTarget(self, action: #selector(checkBoxTapped(sender:)), for: .touchUpInside)
    return cell
    
  }
  
  @objc func checkBoxTapped(sender: UIButton){
    
    overviewArray[sender.tag].isChecked = !overviewArray[sender.tag].isChecked
    let indexPath = IndexPath(row: sender.tag, section: 0)
    servicesTableView.reloadRows(at: [indexPath], with: .fade)
//    print(selectedOverviewsArray)
    let servicesTextViewText = selectedOverviewsArray.joined(separator: ", ")
    serviceTextView.text = servicesTextViewText
    
  }
  
  private func toggleServicesTableView(flag: Bool){
    
    if flag{
      
      servicesTVBottomConstraint.constant = 2
      
    }else {
      
      servicesTVBottomConstraint.constant = -350
      
    }
    
    UIView.animate(withDuration: 0.3){
      
      self.view.layoutIfNeeded()
      
    }
    
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    overviewArray[indexPath.row].isChecked = !overviewArray[indexPath.row].isChecked
//    let indexPath = IndexPath(row: sender.tag, section: 0)
    servicesTableView.reloadRows(at: [indexPath], with: .fade)
//    print(selectedOverviewsArray)
    let servicesTextViewText = selectedOverviewsArray.joined(separator: ", ")
    serviceTextView.text = servicesTextViewText
    
  }
  
}

extension AddListingStep2ViewController: UITextViewDelegate{
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView == serviceTextView{
      
      toggleServicesTableView(flag: true)
      textView.endEditing(true)
//      let addListingSB = UIStoryboard(name: "AddListing", bundle: nil)
//      let overviewVC = addListingSB.instantiateViewController(withIdentifier: "PropertyOverviewViewController") as! PropertyOverviewViewController
//      present(overviewVC, animated: true)
      if textView.text.isEmpty {

        textView.textColor = .lightGray

      }else {
        
        textView.textColor = .black

      }
      
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView == serviceTextView{

      if textView.text.isEmpty {
        
        textView.text = "Property Overview"
        textView.textColor = .lightGray
        
      }else {
        
        textView.textColor = .black
        
      }

    }
  }
  
//  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    
//  }
  
}

extension AddListingStep2ViewController : UITextFieldDelegate{
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == priceTypeTextField {
      
      return false
      
    }else {
      
      return true
      
    }
  }
  
}
