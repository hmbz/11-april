//
//  StatesViewController.swift
//  OgreSpace
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class StatesViewController: UIViewController ,UISearchBarDelegate{
  
  @IBOutlet weak var statesTableView: UITableView!
  
  lazy var titleview = Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)?.first as! SearchBarView
  var statesImageIcons : [UIImage] = [#imageLiteral(resourceName: "Michigan"),#imageLiteral(resourceName: "Alabama"),#imageLiteral(resourceName: "Alaska"),#imageLiteral(resourceName: "Arizona"),#imageLiteral(resourceName: "Arkansas"),#imageLiteral(resourceName: "California"),#imageLiteral(resourceName: "Colorado"),#imageLiteral(resourceName: "Columbia"),#imageLiteral(resourceName: "Connecticut"),#imageLiteral(resourceName: "Delaware"),#imageLiteral(resourceName: "Florida"),#imageLiteral(resourceName: "Hawaii"),#imageLiteral(resourceName: "Idaho"),#imageLiteral(resourceName: "Illinois"),#imageLiteral(resourceName: "Indiana"),#imageLiteral(resourceName: "Iowa"),#imageLiteral(resourceName: "Kansas"),#imageLiteral(resourceName: "Kentucky"),#imageLiteral(resourceName: "Louisiana"),#imageLiteral(resourceName: "Maine"),#imageLiteral(resourceName: "Maryland"),#imageLiteral(resourceName: "Massachusetts"),#imageLiteral(resourceName: "Michigan"),#imageLiteral(resourceName: "Minnesota"),#imageLiteral(resourceName: "Mississippi"),#imageLiteral(resourceName: "Montana"),#imageLiteral(resourceName: "Nebraska"),#imageLiteral(resourceName: "Nevada"),#imageLiteral(resourceName: "New Hampshire"),#imageLiteral(resourceName: "New Jersey"),#imageLiteral(resourceName: "New York"),#imageLiteral(resourceName: "North Carolina"),#imageLiteral(resourceName: "North Dakota"),#imageLiteral(resourceName: "Ohio"),#imageLiteral(resourceName: "Oklahoma"),#imageLiteral(resourceName: "Oregon"),#imageLiteral(resourceName: "Pennsylvania"),#imageLiteral(resourceName: "Rhode Island"),#imageLiteral(resourceName: "South Carolina"),#imageLiteral(resourceName: "Texas"),#imageLiteral(resourceName: "Utah"),#imageLiteral(resourceName: "Vermont"),#imageLiteral(resourceName: "Virginia"),#imageLiteral(resourceName: "Washington"),#imageLiteral(resourceName: "West Virginia"),#imageLiteral(resourceName: "Wisconsin"),#imageLiteral(resourceName: "Wyoming"),#imageLiteral(resourceName: "Tennessee"),#imageLiteral(resourceName: "New Mexico"),#imageLiteral(resourceName: "Missouri"),#imageLiteral(resourceName: "South Dakota")]
  lazy var statesArray = [statesModel]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        StatesApiCall()
        topMenu()
        // Do any additional setup after loading the view.
    }
    

  private func topMenu() {
    
    self.navigationItem.titleView = titleview
    //    titleview.backBtnViewWidth.constant = 60
    //    titleview.backBtn.setImage(nil, for: .normal)
    //    titleview.backBtn.setTitle("Home", for: .normal)
    //    titleview.backBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    titleview.searchBtn.delegate = self
    titleview.searchBtn.placeholder = "Search States"
    titleview.searchBtn.tintColor = UIColor.black
    //    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    
    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    
    self.navigationItem.hidesBackButton = true
    
  }
  @objc func homeBtnTapped(sender: UIButton) {
    
    tabBarController?.selectedIndex = 0
//    print("Home Button Tapped")
//
//    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//    let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//
//    appDelegate.window?.rootViewController = initialViewController
//
//    appDelegate.window?.makeKeyAndVisible()
    
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
  
  private func StatesApiCall(){
    
    Networking.instance.getApiCall(url: statesUrl, header: nil){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonArray = data.array{
            for item in jsonArray {
                guard let jsonDic = item.dictionary else {return}
                let id = jsonDic["id"]?.int ?? -1
                let stateName = jsonDic["state"]?.string ?? ""
                let Icon = jsonDic["icon_image_64"]?.string ?? ""
                let object = statesModel.init(id: id, stateName: stateName, Icon: Icon)
                self.statesArray.append(object)
            }
            
        }
       
        self.statesTableView.reloadData()
        
      }
      
      
    }
    
//    homeService.instance.getAllStates { (success) in
//      if success{
//        let status = homeService.instance.status
//        if status == 404{
//          print("404")
//
//        }
//        else if status == 202{
//          print("202")
//
//        }
//        else if status == 200{
//          print("200")
//          self.statesTableView.reloadData()
//        }
//        else{
//          print("Error!")
//
//        }
//      }
//      else{
//        let status = homeService.instance.status
//        print(status)
//
//      }
//    }
    
    
  }

}
extension StatesViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.statesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "StatesTableViewCell", for: indexPath)  as! StatesTableViewCell
    let array = self.statesArray
    let imagesArray = statesImageIcons
    guard indexPath.row < array.count else {return cell}
    guard indexPath.row < imagesArray.count else {
      return cell
    }
//    if searching == true {
//      guard indexPath.row < filteredStates.count else {return cell}
//      cell.statesLabel.text = filteredStates[indexPath.row]
//      cell.statesImageView.image = UIImage(named: filteredStates[indexPath.row])
//    }
//    else {
      cell.statesLbl.text = array[indexPath.row].stateName
      cell.statesImageView.image = statesImageIcons[indexPath.row]
      cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
//    }
    
    
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let array = self.statesArray
    guard indexPath.row < array.count else {return}
    let instance = array[indexPath.row].stateName
    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
    vc.searchKeyword = instance!
    self.navigationController?.pushViewController(vc, animated: true)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad{
      return 90
    }
    else{
      return 60
    }
    
  }
  
}
