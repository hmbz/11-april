//

//  AddListingViewController.swift
//  OgreSpace
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//



import UIKit
import Toast_Swift



class AddListingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  
  
  //MARK: IBOutlets
  
  
  
  @IBOutlet weak var propertyNameTextField: UITextField!
//  @IBOutlet weak var propertyDescriptionTextField: UITextField!
  @IBOutlet weak var propertyOwnerNameTextField: UITextField!
  @IBOutlet weak var presentedCompanyTextField: UITextField!
  @IBOutlet weak var spaceTypeTextField: UITextField!
  @IBOutlet weak var propertyTypeTextField: UITextField!
 
  @IBOutlet weak var nextBtn: UIButton!
  @IBOutlet weak var servicesTableView: UITableView!
  @IBOutlet weak var servicesTVBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var serviceTextView: UITextView!
  
  //MARK: Properties

  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  let pickerViewTuple = (spaceTypepicker : UIPickerView(), propertyTypePicker : UIPickerView())
  
  let spaceTypeArray = ["For Lease", "For Sale"]
  lazy var categoriesArray = [CategoriesModel]()
  lazy var selectedServicesArray = [String]()
  lazy var selectedServicesIdsArray = [Int]()
  

  //MARK: View Life Cycle

  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setUPViews()

  }
  
  
//  override func viewWillLayoutSubviews() {
//    toggleServicesTableView(flag: false)
//  }
  
  @IBAction func nextButtonTapped(_ sender: Any) {
    
    if propertyNameTextField.text!.isEmpty {
      
      propertyNameTextField.shake()
      self.view.makeToast("Please enter property name", duration: 3.0, position: .top)
      
    }else if serviceTextView.text!.isEmpty {
      
//      serviceTextView.shake()
      self.view.makeToast("Please select amenities", duration: 3.0, position: .top)
      
    }else if propertyOwnerNameTextField.text!.isEmpty {
      
      propertyOwnerNameTextField.shake()
      self.view.makeToast("Please enter property owner name", duration: 3.0, position: .top)
      
    }else if presentedCompanyTextField.text!.isEmpty {
      
      presentedCompanyTextField.shake()
      self.view.makeToast("Please enter company name", duration: 3.0, position: .top)
      
    }else if spaceTypeTextField.text!.isEmpty {
      
      spaceTypeTextField.shake()
      self.view.makeToast("Please select space type", duration: 3.0, position: .top)
      
    }else if propertyTypeTextField.text!.isEmpty {
      
      propertyTypeTextField.shake()
      self.view.makeToast("Please select property type", duration: 3.0, position: .top)
      
    }else {
      
      var spaceType = ""
      if spaceTypeTextField.text == "For Lease" {
        
        spaceType = "lease"
        
      }else {
        
        spaceType = "sale"
        
      }
      let step1ParamsDictionary: [String: Any] = [

        "property_title": propertyNameTextField.text!,
        "description": serviceTextView.text!,
        "presented_name": propertyOwnerNameTextField.text!,
        "presented_company": presentedCompanyTextField.text!,
        "post_type": spaceType,
        "property_type": propertyTypeTextField.text!
        
      ]
      
      let vc = storyboard?.instantiateViewController(withIdentifier: "AddListingStep2ViewController") as! AddListingStep2ViewController
      vc.step1Params = step1ParamsDictionary
      navigationController?.pushViewController(vc, animated: true)
      
    }
    
  }
  
  
  @IBAction func serviceSelectionDoneButton(_ sender: Any) {
    
    self.toggleServicesTableView(flag: false)
    
  }
  
  @IBAction func serviceSelectionCancelButton(_ sender: Any) {
    
    self.toggleServicesTableView(flag: false)
    
  }
  
  //MARK: APIs
  
  func getCategories() {
    
    Networking.instance.getApiCall(url: CategoriesUrl, header: nil){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonArray = data.array{

            for category in jsonArray {
              guard let categoryDict = category.dictionary else{
                return
              }
              let id = categoryDict["id"]?.int ?? -1
              let propertyType = categoryDict["Property_type"]?.string ?? "N/A"
              let categoryLogo = categoryDict["logo_of_categories"]?.string ?? "N/A"
              let categoryModelObj = CategoriesModel(id: id, propertyType: propertyType, logoOfCategories: categoryLogo)
              
              self.categoriesArray.append(categoryModelObj)
            }
            
        }
       
        self.pickerViewTuple.propertyTypePicker.reloadComponent(1)
        
      }
      
      
    }
    
//    CategoriesService.instance.getAllCategories{(success) in
//
//      print("success")
//      if success {
//
//        DispatchQueue.main.async {
//
//          self.pickerViewTuple.propertyTypePicker.reloadComponent(1)
//
//        }
//
//      }else {
//
//        self.view.makeToast("Could not download categories from server", duration: 3.0, position: .top)
//
//      }
//
//
//    }
    
  }
  
  
  
  //MARK: Private Functions
  
  
  private func setUPViews(){
    
    addTopBar()
    nextBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
    addSpaceTypePicker()
    addPropertyTypePicker()
    getCategories()
    spaceTypeTextField.delegate = self
    propertyTypeTextField.delegate = self
    self.pickerViewTuple.spaceTypepicker.reloadComponent(1)
    servicesTableView.delegate = self
    servicesTableView.dataSource = self
    serviceTextView.delegate = self
    getServices()
    
  }
  
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
    tabBarController?.selectedIndex = 0
  }
  // going back directly towards the home
  @objc func homeBtnTapped(sender: UIButton) {
    
    tabBarController?.selectedIndex = 0
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }
  
  private func addSpaceTypePicker() {
    
    pickerViewTuple.spaceTypepicker.delegate = self
    pickerViewTuple.spaceTypepicker.dataSource = self
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnTapped))
    doneButton.tintColor =  _ColorLiteralType(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    toolbar.setItems([spaceButton1, spaceButton2,doneButton], animated: false)
    spaceTypeTextField.inputAccessoryView = toolbar
    spaceTypeTextField.inputView = pickerViewTuple.spaceTypepicker
    
  }
  
  
  
  private func addPropertyTypePicker() {
    
    pickerViewTuple.propertyTypePicker.delegate = self
    pickerViewTuple.propertyTypePicker.dataSource = self
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnTapped))
    doneButton.tintColor =  _ColorLiteralType(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    toolbar.setItems([spaceButton1, spaceButton2,doneButton], animated: false)
    propertyTypeTextField.inputAccessoryView = toolbar
    propertyTypeTextField.inputView = pickerViewTuple.propertyTypePicker
    
  }

  @objc private func doneBtnTapped(){
    
    spaceTypeTextField.resignFirstResponder()
    propertyTypeTextField.resignFirstResponder()
    
    
  }
  
  //MARK: API Calls
  
  func getServices() {
    AddListingService.instance.getServices{(success) in
      print("success")
      DispatchQueue.main.async {
        self.servicesTableView.reloadData()
      }
    }
  }
  
  
  //MARK:- PickerView Extension

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
    return 1
    
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    
    
    if pickerView == pickerViewTuple.propertyTypePicker {
      
      return self.categoriesArray.count
      
    }else {
      
      return spaceTypeArray.count
      
    }
    
  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    if pickerView == pickerViewTuple.propertyTypePicker {
      
      let propertyType = self.categoriesArray[row].propertyType
      propertyTypeTextField.text = propertyType
      return propertyType
      
      
    }else {
      
      let spaceType = spaceTypeArray[row]
      spaceTypeTextField.text = spaceType
      return spaceType
      
    }
    
  }
  
}

extension AddListingViewController : UITextFieldDelegate{
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == spaceTypeTextField || textField == propertyTypeTextField {
      
      return false
      
    }else {
      
      return true
      
    }
  }
  
}


extension AddListingViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return AddListingService.instance.servicesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as! ServiceTableViewCell
    let serviceArray = AddListingService.instance.servicesArray[indexPath.row]
    cell.serviceNameLabel.text = serviceArray.serviceName
    cell.backgroundColor = .clear
    cell.contentView.backgroundColor = .clear
    if  serviceArray.isChecked {
      
      cell.checkBoxButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
      selectedServicesArray.append(serviceArray.serviceName)
      selectedServicesIdsArray.append(serviceArray.serviceId)
      
    }else {
      
      selectedServicesArray.removeAll(where: { $0 == serviceArray.serviceName })
      selectedServicesIdsArray.removeAll(where: { $0 == serviceArray.serviceId })
      cell.checkBoxButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
      
    }
    cell.checkBoxButton.tag = indexPath.row
    cell.checkBoxButton.addTarget(self, action: #selector(checkBoxTapped(sender:)), for: .touchUpInside)
    return cell
    
  }
  
  @objc func checkBoxTapped(sender: UIButton){
    
    AddListingService.instance.servicesArray[sender.tag].isChecked = !AddListingService.instance.servicesArray[sender.tag].isChecked
    let indexPath = IndexPath(row: sender.tag, section: 0)
    servicesTableView.reloadRows(at: [indexPath], with: .fade)
    print(selectedServicesArray)
    let servicesTextViewText = selectedServicesArray.joined(separator: ",")
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
    AddListingService.instance.servicesArray[indexPath.row].isChecked = !AddListingService.instance.servicesArray[indexPath.row].isChecked
//    let indexPath = IndexPath(row: sender.tag, section: 0)
    servicesTableView.reloadRows(at: [indexPath], with: .fade)
    print(selectedServicesArray)
    let servicesTextViewText = selectedServicesArray.joined(separator: ",")
    serviceTextView.text = servicesTextViewText
    
  }
  
}


extension AddListingViewController: UITextViewDelegate{
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView == serviceTextView{
      
      toggleServicesTableView(flag: true)
      textView.endEditing(true)
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
        
        textView.text = "Select Services"
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
