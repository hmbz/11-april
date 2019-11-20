//
//  PropertyOverviewViewController.swift
//  OgreSpace
//
//  Created by admin on 11/14/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class PropertyOverviewViewController: UIViewController {

    //MARK: Outlets
  
  @IBOutlet weak var overviewTableView: UITableView!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var nextBtn: UIButton!
  
    //MARK: Properties
  
  lazy var overviewDictArray = [[String: String]]()
  lazy var selectedOverviewArray = [String]()
//  lazy var activeOverviewKey = String()
//  lazy var overviewDictArray = [[String: String]]()
  
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
    //MARK: View Life Cycle
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    overviewTableView.delegate = self
    overviewTableView.dataSource = self
    overviewTableView.estimatedRowHeight = 150
    overviewTableView.rowHeight = UITableView.automaticDimension
    
    addTopBar()
    
    backBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    nextBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)

    }
  
  
  override func viewLayoutMarginsDidChange() {
    
    // setting the topbar View Height
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }
  
  //MARK: Setup Top Bar
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "Property Overview"
    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    titleview.homeBtn.layer.cornerRadius = 6
    titleview.homeBtn.layer.masksToBounds = true
    self.navigationItem.hidesBackButton = true
  }
  // performing back button functionality
  @objc func backbtnTapped(sender: UIButton){
    // agar hum push view controller se navigation perform karwa rahe hon then back pe pop karwana ho ga ni to dismiss
    navigationController?.popViewController(animated: true)
//    dismiss(animated: true, completion: nil)
  }
  // going back directly towards the home
  @objc func homeBtnTapped(sender: UIButton) {
    
    navigationController?.popViewController(animated: true)
//    dismiss(animated: true, completion: nil)
  }
  
  
  //MARK: Actions
  
  @IBAction func BackBtnTapped(_ sender: Any) {
  
  self.navigationController?.popViewController(animated: true)
  
  }
  
  @IBAction func NextBtnTapped(_ sender: Any) {
  
//    if priceTextField.text!.isEmpty {
//
//      priceTextField.shake()
//      self.view.makeToast("Please enter listing price ", duration: 3.0, position: .top)
//
//    }else if areaTextField.text!.isEmpty {
//
//      areaTextField.shake()
//      self.view.makeToast("Please enter listing area", duration: 3.0, position: .top)
//
//    }else if priceTypeTextField.text!.isEmpty {
//
//      priceTypeTextField.shake()
//      self.view.makeToast("Please enter price type", duration: 3.0, position: .top)
//
//    }else if descriptionTextField.text!.isEmpty {
//
//      descriptionTextField.shake()
//      self.view.makeToast("Please enter listing description", duration: 3.0, position: .top)
//
//    }else if contactTextField.text!.isEmpty {
//
//      contactTextField.shake()
//      self.view.makeToast("Please enter contact number", duration: 3.0, position: .top)
//
//    }else if serviceTextView.text!.isEmpty {
//
//      self.view.makeToast("Please enter at least one service", duration: 3.0, position: .top)
//
//    }else {
      
//      var step1and2ParamsDict: [String: Any] = [
//
//        "price": priceTextField.text!,
//        "property_area": areaTextField.text!,
//        "price_type": priceTypeTextField.text!,
//        "overview": descriptionTextField.text!,
//        "contact_no": contactTextField.text!,
//        "mapped_services": selectedOverviewIdsArray
//
//      ]
//      step1and2ParamsDict.merge(dict: step1Params)
      let vc = storyboard?.instantiateViewController(withIdentifier: "AddListingStep3ViewController") as! AddListingStep3ViewController
//      vc.step1and2ParametersDictionary = step1and2ParamsDict

      navigationController?.pushViewController(vc, animated: true)
      
//    }
  
  }

}
 
extension PropertyOverviewViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return selectedOverviewArray.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyOverviewTableViewCell") as! PropertyOverviewTableViewCell
    cell.overviewTextView.delegate = self
    cell.overviewTextView.tag = indexPath.row
//    let key = selectedOverviewArray[indexPath.row]
    var textVal = ""
      for itemDict in overviewDictArray {

        let key = selectedOverviewArray[indexPath.row]
        textVal = itemDict[key] ?? ""

        }
    cell.overviewTextView.text = textVal
    
//    if cell.overviewTextView.isFirstResponder  {
//
//      self.activeOverviewKey = selectedOverviewArray[indexPath.row]
//
//    }
    cell.overviewLbl.text = "Enter " + self.selectedOverviewArray[indexPath.row] + " Overview *"
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyOverviewTableViewCell") as! PropertyOverviewTableViewCell
//    cell.overviewTextView.isUserInteractionEnabled = true
//    cell.overviewTextView.becomeFirstResponder()
  }
  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 100
//  }
  
}

extension PropertyOverviewViewController: UITextViewDelegate{
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    
//    textView.text = ""
//
//    if textView.text.isEmpty{
//
//
//    }else {
//
//
//    }
    
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    
    if textView.text.isEmpty{
      
      print("empty textview")
      
    }else {
      let index = textView.tag
      let key = selectedOverviewArray[index]
      let dict = [key: textView.text!]
      overviewDictArray.append(dict)
      
    }
    
    
  }
  
}
