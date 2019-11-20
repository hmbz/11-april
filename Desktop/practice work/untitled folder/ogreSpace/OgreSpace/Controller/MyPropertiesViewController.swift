//
//  MyPropertiesViewController.swift
//  OgreSpace
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class MyPropertiesViewController: UIViewController, UISearchBarDelegate {

  @IBOutlet weak var myPropertiesTblView: UITableView!
  lazy var myPropertiesViewCellId: String = "propertyTableViewCell"
  var pageNumber:Int = 1
  lazy var titleview = Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)?.first as! SearchBarView
  override func viewDidLoad() {
        super.viewDidLoad()
    let tvCell = UINib(nibName: myPropertiesViewCellId, bundle: nil)
    self.myPropertiesTblView.register(tvCell, forCellReuseIdentifier: myPropertiesViewCellId)
    topMenu()
    
    MyPropertiesService.instance.MyPropertiesServiceAPI(url: myPropertyUrl){
      (totalItems, success)  in
      DispatchQueue.main.async {
        self.myPropertiesTblView.reloadData()
      }
    }
        // Do any additional setup after loading the view.
    
  }
    

  
  private func topMenu() {
    
    self.navigationItem.titleView = titleview
    //    titleview.backBtnViewWidth.constant = 60
    //    titleview.backBtn.setImage(nil, for: .normal)
    //    titleview.backBtn.setTitle("Home", for: .normal)
    //    titleview.backBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    titleview.searchBtn.delegate = self
    titleview.searchBtn.placeholder = "Search Properties"
    titleview.searchBtn.tintColor = UIColor.black
    //    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    
    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    
    self.navigationItem.hidesBackButton = true
    
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
 

}
extension MyPropertiesViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MyPropertiesService.instance.myPropertyArray.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = myPropertiesTblView.dequeueReusableCell(withIdentifier: myPropertiesViewCellId) as! propertyTableViewCell
    
    //    if self.tag == 0 {
    let array = MyPropertiesService.instance.myPropertyArray
    guard indexPath.row < array.count else {return cell}
    let instance = array[indexPath.row]
    cell.nameLbl.text = instance.PropertyType
    cell.locationLbl.text = instance.Address
    let price = instance.price!
    print(price)
    
    let floatPrice = Float(price)
    print(floatPrice)
    let intPrice = Int (floatPrice ?? -1)
    print(intPrice)
    let largeNumber = intPrice
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
    cell.priceLbl.text = "$" + formattedNumber!
//    cell.typeLbl.text = "For " + instance.postType!
    let area = instance.Area!
    print(area)
    cell.areaLbl.text = "\(area) Sqrf"
    let nameImage = instance.image
    let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
    cell.itemImage.sd_setImage(with: URL(string: imageUrlEncoded!), placeholderImage: UIImage(named: "appLogo"))
    //    }
    
    
    cell.selectionStyle = .none
    cell.cardView.makeRoundedCorners(cornerRadius: 6)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    
    
    let currentOffset = scrollView.contentOffset.y
    
    
    
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height  // Change 10.0 to adjust the distance from bottom
    
    
    
    if maximumOffset - currentOffset <= 20.0 {
      
      
      
      print("going to referesh Data")
      
      
      
      //      loadMoreData()
      
      
      
    }
    
  }
  //  private func loadMoreData() {
  //
  //    //    self.fidgetSpinner.isHidden = false
  //    //    self.fidgetSpinner.loadGif(name: "name")
  //    //          self.dimView.alpha = 0.5
  //    self.favoritesTblView.isUserInteractionEnabled = false
  //
  //
  //
  ////    else {
  //      let totalItems = homeService.instance.userFavoritesArray[0].totalItems
  //      let arrayItems = homeService.instance.leasePropertyArray.count
  //      if ((arrayItems) < totalItems ?? -1) {
  //
  //
  //
  //        print ("\(String(describing: arrayItems))")
  //
  //
  //
  //        //MARK: increment of 1 will allow us to get the data for next Page on Scrolling to the bottom
  //
  //
  //        pageNumber = ((arrayItems) / 8) + 1
  //
  //
  //
  //        //            let category = UserDefaults.standard.string(forKey: "category")
  //        //            UserDefaults.standard.synchronize()
  //        //      print(agency)
  //        print(pageNumber)
  //        let url =  LeasePropertyUrl + "?page=" + String(pageNumber)
  //        print(url)
  //        let newUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
  //        print(newUrl)
  //        homeService.instance.LeaseProperty(url: url, completion: { (success) in
  //          if success{
  //            print("success")
  //
  //
  //            //          self.fidgetSpinner.isHidden = true
  //            //          self.dimView.alpha = 0
  //            self.favoritesTblView.isUserInteractionEnabled = true
  //
  //            self.favoritesTblView.dataSource = self
  //
  //            self.favoritesTblView.delegate = self
  //
  //            self.favoritesTblView.reloadData()
  //
  //          }
  //        })
  //      }
  //      else{
  //        print("not success")
  //
  //
  //        //          self.fidgetSpinner.isHidden = true
  //        //          self.dimView.alpha = 1
  //        self.favoritesTblView.isUserInteractionEnabled = true
  //      }
  ////    }
  //  }
  
}
