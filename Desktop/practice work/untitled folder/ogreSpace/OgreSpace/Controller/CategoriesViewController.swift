//
//  CategoriesViewController.swift
//  OgreSpace
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import SDWebImage
class CategoriesViewController: UIViewController, UISearchBarDelegate {

  @IBOutlet weak var categoriesTblView: UITableView!
  lazy var categoriesNames = ["Offices","Retail","Co Working","Land","Industrial","Medical Offices"]
  var statesImageIcons : [UIImage] = [#imageLiteral(resourceName: "Offices"),#imageLiteral(resourceName: "Retail"),#imageLiteral(resourceName: "Co-Working"),#imageLiteral(resourceName: "Land"),#imageLiteral(resourceName: "Industrial"),#imageLiteral(resourceName: "Medical Offices")]
  lazy var titleview = Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)?.first as! SearchBarView
  lazy var categoriesArray = [CategoriesModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topMenu()
    getCategories()
//        categoriesAPI()
        // Do any additional setup after loading the view.
    
    }

  private func getCategories(){
    
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
       
        self.categoriesTblView.reloadData()
        
      }
      
      
    }
    
  }
  
  private func topMenu() {
    
    self.navigationItem.titleView = titleview
    //    titleview.backBtnViewWidth.constant = 60
    //    titleview.backBtn.setImage(nil, for: .normal)
    //    titleview.backBtn.setTitle("Home", for: .normal)
    //    titleview.backBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    titleview.searchBtn.delegate = self
    titleview.searchBtn.placeholder = "Search Categories"
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
//  func categoriesAPI() {
//    CategoriesService.instance.getAllCategories{(success) in
//      print("success")
//      DispatchQueue.main.async {
//        self.categoriesTblView.reloadData()
//      }
//    }
//  }
}
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return self.categoriesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = categoriesTblView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
    let catArray  = self.categoriesArray
    cell.categoriesLbl.text = catArray[indexPath.row].propertyType
    let categoryIcons = catArray[indexPath.row].logoOfCategories
    cell.categoryImageView.sd_setImage(with: URL(string: categoryIcons), placeholderImage: UIImage(named: "appLogo"))
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let array = self.categoriesArray
    
    guard indexPath.row < array.count else {return}
    let instance = array[indexPath.row].propertyType
    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
    vc.searchKeyword = instance
    self.navigationController?.pushViewController(vc, animated: true)

  }
  
}
