//
//  moreHomeVC.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class moreHomeVC: UIViewController {
  
  //MARK:- IBOutlets
  
  @IBOutlet weak var detailTableView: UITableView!
  @IBOutlet weak var totalItemLbl: UILabel!
  @IBOutlet weak var totalItemView: UIView!
  @IBOutlet weak var noItemFoundImg: UIImageView!
  @IBOutlet weak var noItemFoundLbl: UILabel!
  
  //MARK:- Properties
  
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
//  lazy var propertiesDataArray = [propertyModel]()
  
  lazy var MyTableViewCellId: String = "propertyTableViewCell"
//  lazy var stateName = ""
  lazy var searchKeyword = ""
//  lazy var categoryKeyword = ""
//  lazy var tag = Int()
  lazy var flagMoreButtonSale = false
  lazy var flagMoreButtonLease = false
  lazy var flagMoreButton3RecentlyViewed = false
  var body = [String : Any]()
  lazy var productsArray = [propertyModel]()
  lazy var totalPages = -1
//  var pageNumber:Int = 1
  var currentPageNumber : Int = 1
  var nextPageNumber: Int = -1
  
  let transition = TransitionAnimator()
  var selectedCell = UITableViewCell()
  
  //MARK:- View life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    
  }
  
  //MARK: Setup Views
  
  private func setupViews(){
  
   let tvCell = UINib(nibName: MyTableViewCellId, bundle: nil)
   self.detailTableView.register(tvCell, forCellReuseIdentifier: MyTableViewCellId)
   
   if self.searchKeyword != ""{
     
     searchedResultsAPI(url: searchUrl)
     titleview.titleLbl.text = "Properties for \(searchKeyword)"
     
   }

   else if self.body.count != 0{
     
     searchedResultsAPI(url: searchUrl)
     
   }else if flagMoreButtonSale{
     
     SalePropertyApiCall(url: SalePropertyUrl)
     
     if !self.productsArray.isEmpty{
       
     }else {
      
      self.detailTableView.reloadData()
      
    }
     titleview.titleLbl.text = "Latest Properties for Sale"
     
   }else if flagMoreButtonLease{
     
     LeasePropertyApiCall(url: LeasePropertyUrl)
     self.detailTableView.reloadData()
     
     titleview.titleLbl.text = "Latest Properties for Lease"
     
   }else if flagMoreButton3RecentlyViewed{
     
     getRecentlyViewedProperties()

     titleview.titleLbl.text = "Recently Viewed properties"
     
   }
  
   addTopBar()
   
   self.noItemFoundImg.isHidden = true
   self.noItemFoundLbl.isHidden = true
  
  }
  
  
  //MARK:- API Calls
  
  private func searchedResultsAPI(url: String){
    
    let body = ["keyword": searchKeyword]
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    
      let header = [
        
        "Authorization": "JWT \(token)"
        
      ]
    print("searchUrl ", url)
    print("header", header)
    print("params", body)
    Networking.instance.postApiCall(url: url, param: body, header: header){ (responseData, error, statusCode) in
      
      if error == nil && statusCode == 200{
        
        guard let jsonDic = responseData.dictionary else {
            return
          }
        let totalItems = jsonDic["totalitems"]?.int ?? -1
        self.totalItemLbl.text = "\(totalItems) properties"
        self.totalPages = jsonDic["totalpages"]?.int ?? -1
        guard let jsonArray = jsonDic["results"]?.array else {
            return
          }
          for item in jsonArray {
            guard let propertyDic = item.dictionary else {return}
            let id = propertyDic["id"]?.int ?? -1
            let propertyTitle = propertyDic["property_title"]?.string ?? ""
            let propertyType = propertyDic["post_type"]?.string ?? "N/A"
            let image = propertyDic["one_pic"]?.string ?? "N/A"
            let price = propertyDic["price"]?.int ?? -1
            let propertyArea = propertyDic["property_area"]?.string  ?? ""
            let address = propertyDic["address"]?.string ?? "N/A"
            let latitude = propertyDic["latitude"]?.string ?? "N/A"
            let longitude = propertyDic["longitude"]?.string ?? "N/A"
            let postType = propertyDic["post_type"]?.string ?? "N/A"
            let isFavorite = propertyDic["isfavourite"]?.bool ?? false
            let object = propertyModel.init(id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: String(describing: price), Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
            self.productsArray.append(object)
//            searchResultArray.append(object)

        }
        
      }
      
      DispatchQueue.main.async {
        self.detailTableView.reloadData()
      }
      
    }
    
  }
  
  //latest properties for sale API
  private func SalePropertyApiCall(url: String){
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: url, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
          if let totalItems = jsonDic["totalItems"]?.int32{
            
            self.totalItemLbl.text = "\(totalItems) properties"
            
          }else {
            
            self.totalItemLbl.text = ""
            
          }
          
          self.totalPages = jsonDic["totalPages"]?.int ?? -1
          let jsonArray = jsonDic["results"]?.array ?? []
          for item in jsonArray {
            guard let propertyDic = item.dictionary else {return}
            let id = propertyDic["id"]?.int ?? -1
            let propertyTitle = propertyDic["property_title"]?.string ?? ""
            let propertyType = propertyDic["property_type"]?.string ?? ""
            let image = propertyDic["one_pic"]?.string ?? ""
            let price = propertyDic["price"]?.string ?? "N/A"
            let propertyArea = propertyDic["property_area"]?.string ?? ""
            let address = propertyDic["address"]?.string ?? ""
            let latitude = propertyDic["latitude"]?.string ?? ""
            let longitude = propertyDic["longitude"]?.string ?? ""
            let postType = propertyDic["post_type"]?.string ?? ""
            let isFavorite = propertyDic["isfavourite"]?.bool ?? false
            let object = propertyModel.init( id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
            self.productsArray.append(object)
          }
          
        }
        
        self.detailTableView.reloadData()
        
      }else {
        
        
      }
      
    }
    
  }
  
    //latest properties for sale API
  
  private func LeasePropertyApiCall(url: String){
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: url, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
        if let totalItems = jsonDic["totalItems"]?.int32{
          
          self.totalItemLbl.text = "\(totalItems) properties"
        
        }else {
          
          self.totalItemLbl.text = ""
          
          }
          self.totalPages = jsonDic["totalPages"]?.int ?? -1
          let jsonArray = jsonDic["results"]?.array ?? []
          for item in jsonArray {
            guard let propertyDic = item.dictionary else {return}
            let id = propertyDic["id"]?.int ?? -1
            let propertyTitle = propertyDic["property_title"]?.string ?? ""
            let propertyType = propertyDic["property_type"]?.string ?? ""
            let image = propertyDic["one_pic"]?.string ?? ""
            let price = propertyDic["price"]?.string ?? "N/A"
            let propertyArea = propertyDic["property_area"]?.string ?? ""
            let address = propertyDic["address"]?.string ?? ""
            let latitude = propertyDic["latitude"]?.string ?? ""
            let longitude = propertyDic["longitude"]?.string ?? ""
            let postType = propertyDic["post_type"]?.string ?? ""
            let isFavorite = propertyDic["isfavourite"]?.bool ?? false
            let object = propertyModel.init( id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
            self.productsArray.append(object)
          }
          
        }
        
        self.detailTableView.reloadData()
        
      }else {
        
        
      }
      
    }
    
  }
  
  //recentlyViewed API Call
  private func getRecentlyViewedProperties(){
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: recentlyViewedUrl, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
          let totalItems = jsonDic["totalItems"]?.int ?? -1
          self.totalItemLbl.text = "\(totalItems) Properties"
          self.totalPages = jsonDic["totalPages"]?.int ?? -1
          let jsonArray = jsonDic["results"]?.array ?? []
          for item in jsonArray {
            guard let propertyDic = item.dictionary else {return}
            let id = propertyDic["id"]?.int ?? -1
            let propertyTitle = propertyDic["property_title"]?.string ?? ""
            let propertyType = propertyDic["property_type"]?.string ?? ""
            let image = propertyDic["one_pic"]?.string ?? ""
            let price = propertyDic["price"]?.string ?? "N/A"
            let propertyArea = propertyDic["property_area"]?.string ?? ""
            let address = propertyDic["address"]?.string ?? ""
            let latitude = propertyDic["latitude"]?.string ?? ""
            let longitude = propertyDic["longitude"]?.string ?? ""
            let postType = propertyDic["post_type"]?.string ?? ""
            let isFavorite = propertyDic["isfavourite"]?.bool ?? false
            let object = propertyModel.init( id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
            self.productsArray.append(object)
          }
          
        }
        
        self.detailTableView.reloadData()
        
      }else {
        
        
      }
      
    }
    
  }
  
  
  @objc func toggleFavourite(_ sender: UIButton){
    
    print(sender.tag, "sender.tag")
    guard let flag = self.productsArray[sender.tag].isFavourite else {return}
    guard let propertyId = productsArray[sender.tag].id else {return}
    if flag{
      
      mainService.instance.removeFromFavourites(propertyId: String(describing: propertyId) ){ (success, isRemoved) in
        
        if success{
          if isRemoved {
            
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
            self.productsArray[sender.tag].isFavourite = false
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.detailTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            
          }else {
            
            
            
          }
          
        }else {
          
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
          
        }
        
      }
      
    }else {
      
      mainService.instance.addToFavourites(propertyId: String(describing: propertyId)){ (success, isAdded) in
        
        if success{
          if isAdded {
            
            sender.setImage(UIImage(named: "filledHeart"), for: .normal)
            self.productsArray[sender.tag].isFavourite = false

            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.detailTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            
          }else {
            
            
            
          }
          
        }else {
          
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
          
        }
        
      }
      
    }
    
    
  }
  //MARK:- Top Bar Setting
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
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
    print("Home Button Tapped")
    self.navigationController?.popViewController(animated: true)
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }
  
  
  
}

extension moreHomeVC: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.productsArray.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCellId) as! propertyTableViewCell
      let propertyInstance = self.productsArray[indexPath.row]
      cell.loadData(item: propertyInstance)
      cell.likeBtn.tag = indexPath.row
      if  propertyInstance.isFavourite!{
        
        cell.likeBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        
      }else {
        
        cell.likeBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
        
      }
      cell.likeBtn.addTarget(self, action: #selector(self.toggleFavourite), for: .touchUpInside)
      return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedCell = (tableView.cellForRow(at: indexPath) as? propertyTableViewCell)!
    let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailPageViewController") as! detailPageViewController
    let array = self.productsArray
    guard indexPath.row < array.count else{
      return
    }
    let instance = array[indexPath.row]
    let nameImage = instance.image
    let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
    detailVC.propertyImagesArray = [imageUrlEncoded] as! [String]
    detailVC.detailId = instance.id!
    detailVC.isFav = instance.isFavourite!
    detailVC.transitioningDelegate = self
    detailVC.modalPresentationStyle = .fullScreen
    present(detailVC, animated: true, completion: nil)
    
  }

  
    //MARK: Pagination
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    let currentOffset = scrollView.contentOffset.y
    
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height  // Change 10.0 to adjust the distance from bottom
    
    if maximumOffset - currentOffset <= 20.0 {
      
      print("going to referesh Data")
      
      loadMoreData()
      
    }
    
  }
  
  private func loadMoreData(){
    //get ready the data . fetch

    if self.searchKeyword != ""{

      nextPageNumber = currentPageNumber + 1
      currentPageNumber = nextPageNumber
      if currentPageNumber < totalPages{
        
        let url = searchUrl + "?page=\(currentPageNumber)"
        searchedResultsAPI(url: url)
        
      }
      
      
    }else if self.body.count != 0{
      
//      guard let noOfTotalPages = advanceSearchService.instance.totalPages else {return}
      nextPageNumber = currentPageNumber + 1
      currentPageNumber = nextPageNumber
      if currentPageNumber < totalPages{
        
        let url = searchUrl + "?page=\(currentPageNumber)"
        self.searchedResultsAPI(url: url)
        
      }
      
    }else if flagMoreButtonSale{
      
//      guard let noOfTotalPages = self.totalPages else {return}
      nextPageNumber = currentPageNumber + 1
      currentPageNumber = nextPageNumber
      print(currentPageNumber, nextPageNumber, totalPages)
      if currentPageNumber < totalPages{
      
        let url = SalePropertyUrl + "?page=\(currentPageNumber)"
        SalePropertyApiCall(url: url)
        
      }
      
      
    }else if flagMoreButtonLease{
      
//      guard let noOfTotalPages = homeService.instance.totalPages else {return}
      nextPageNumber = currentPageNumber + 1
      currentPageNumber = nextPageNumber
      if currentPageNumber < totalPages{
        
        let url = LeasePropertyUrl + "?page=\(currentPageNumber)"
        LeasePropertyApiCall(url: url)
        
      }
      
    }else if flagMoreButton3RecentlyViewed{
      
      
      }
      
    }
    
  }
  
extension moreHomeVC: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let originFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
      return transition
    }
    transition.originFrame = originFrame
    transition.presenting = true
    //    selectedCell.isHidden = true
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}
