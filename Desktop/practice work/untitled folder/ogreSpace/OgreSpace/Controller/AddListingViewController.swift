//

//  AddListingViewController.swift

//  OgreSpace

//

//  Created by MAC on 23/07/2019.

//  Copyright © 2019 brainplow. All rights reserved.

//



import UIKit



class AddListingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  
  
  //MARK: IBOutlets
  
  
  
  @IBOutlet weak var propertyNameTextField: UITextField!
  
  @IBOutlet weak var propertyAddressTextField: UITextField!
  
  @IBOutlet weak var propertyOwnerNameTextField: UITextField!
  
  @IBOutlet weak var presentedCompsnyTextField: UITextField!
  
  @IBOutlet weak var spaceTypeTextField: UITextField!
  
  @IBOutlet weak var propertyTypeTextField: UITextField!
  
  
  
  //MARK: Properties
  
  
  
  let pickerViewTuple = (spaceTypepicker : UIPickerView(), propertyTypePicker : UIPickerView())
  
  let spaceTypeArray = ["For Lease", "For Sale"]
  
  
  
  //MARK: View Life Cycle
  
  
  
  override func viewDidLoad() {
    
    
    
    super.viewDidLoad()
    
    addSpaceTypePicker()
    
    addPropertyTypePicker()
    
    getCategories()
    
    self.pickerViewTuple.spaceTypepicker.reloadComponent(1)
    
    
    
    // Do any additional setup after loading the view.
    
  }
  
  
  
  //MARK: APIs
  
  
  
  func getCategories() {
    
    CategoriesService.instance.getAllCategories{(success) in
      
      print("success")
      
      DispatchQueue.main.async {
        
        self.pickerViewTuple.propertyTypePicker.reloadComponent(1)
        
      }
      
    }
    
  }
  
  
  
  //MARK: Private Functions
  
  
  
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
  
  
  
  //MARK:- PickerView Extension
  
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
    return 1
    
  }
  
  
  
  
  
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    
    
    if pickerView == pickerViewTuple.propertyTypePicker {
      
      return CategoriesService.instance.categoriesModelArray.count
      
    }else {
      
      
      
      return spaceTypeArray.count
      
      
      
    }
    
  }
  
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    if pickerView == pickerViewTuple.propertyTypePicker {
      
      return CategoriesService.instance.categoriesModelArray[row].propertyType
      
    }else {
      
      
      
      return spaceTypeArray[row]
      
      
      
    }
    
    
    
  }
  
  
  
}
