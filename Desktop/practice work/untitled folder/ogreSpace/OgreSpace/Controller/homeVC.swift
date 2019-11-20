//
//  homeVC.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import SDWebImage
import TextFieldEffects
import SwiftyJSON

class homeVC: UIViewController {
  
  //MARK:- IBOutlets
  
  @IBOutlet weak var sliderColView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var sliderCollectionViewHeight: NSLayoutConstraint!
  @IBOutlet weak var drawerLeading: NSLayoutConstraint!
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var statesCollectionView: UICollectionView!
  @IBOutlet weak var saleCollectionview: UICollectionView!
  @IBOutlet weak var leaseCollectionView: UICollectionView!
  @IBOutlet weak var recnetlyViewedCollectionView: UICollectionView!
  @IBOutlet weak var packgesPricingCollectionView: UICollectionView!
  @IBOutlet weak var salemoreBtn: UIButton!
  @IBOutlet weak var leasemoreBtn: UIButton!
  @IBOutlet weak var categoriesCollectionView: UICollectionView!
  //MARK:- Properties
  
  var packagesPlanArray: [String] = ["MONTHLY PLAN", "YEARLY PLAN"]
  var pacakgesPriceArray: [String] = ["$24.99", "$199.99"]
  var priceBackgroundColor: [UIColor] = [#colorLiteral(red: 0.7490196078, green: 0.1568627451, blue: 0.1137254902, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
  var registeredButtonArray: [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
  
  var scrollingTimer: Timer? // To keep track of the Auto Scrolling Timer
  lazy var dummyCount = 10000 //To make the slider looks like infnite
  lazy var sliderCollectionViewDataSource: Array = [UIImage]()
  var temp:CGPoint!
  lazy var selectedPage = 0 //For keeping track of the selected page in slider
  lazy var SaleProprtyTableViewCellId: String = "propertyCollectionViewCell"
  lazy var LeaseProprtyTableviewcell: String  = "propertyCollectionViewCell"
  lazy var recentlyViewedProprtyTableviewcell: String = "propertyCollectionViewCell"
  lazy var packgesPricingTableviewcell: String = "propertyCollectionViewCell"
  var statesImageIcons : [UIImage] = [#imageLiteral(resourceName: "Michigan"),#imageLiteral(resourceName: "Alabama"),#imageLiteral(resourceName: "Alaska"),#imageLiteral(resourceName: "Arizona"),#imageLiteral(resourceName: "Arkansas"),#imageLiteral(resourceName: "California"),#imageLiteral(resourceName: "Colorado"),#imageLiteral(resourceName: "Columbia"),#imageLiteral(resourceName: "Connecticut"),#imageLiteral(resourceName: "Delaware"),#imageLiteral(resourceName: "Florida"),#imageLiteral(resourceName: "Hawaii"),#imageLiteral(resourceName: "Idaho"),#imageLiteral(resourceName: "Illinois"),#imageLiteral(resourceName: "Indiana"),#imageLiteral(resourceName: "Iowa"),#imageLiteral(resourceName: "Kansas"),#imageLiteral(resourceName: "Kentucky"),#imageLiteral(resourceName: "Louisiana"),#imageLiteral(resourceName: "Maine"),#imageLiteral(resourceName: "Maryland"),#imageLiteral(resourceName: "Massachusetts"),#imageLiteral(resourceName: "Michigan"),#imageLiteral(resourceName: "Minnesota"),#imageLiteral(resourceName: "Mississippi"),#imageLiteral(resourceName: "Montana"),#imageLiteral(resourceName: "Nebraska"),#imageLiteral(resourceName: "Nevada"),#imageLiteral(resourceName: "New Hampshire"),#imageLiteral(resourceName: "New Jersey"),#imageLiteral(resourceName: "New York"),#imageLiteral(resourceName: "North Carolina"),#imageLiteral(resourceName: "North Dakota"),#imageLiteral(resourceName: "Ohio"),#imageLiteral(resourceName: "Oklahoma"),#imageLiteral(resourceName: "Oregon"),#imageLiteral(resourceName: "Pennsylvania"),#imageLiteral(resourceName: "Rhode Island"),#imageLiteral(resourceName: "South Carolina"),#imageLiteral(resourceName: "Texas"),#imageLiteral(resourceName: "Utah"),#imageLiteral(resourceName: "Vermont"),#imageLiteral(resourceName: "Virginia"),#imageLiteral(resourceName: "Washington"),#imageLiteral(resourceName: "West Virginia"),#imageLiteral(resourceName: "Wisconsin"),#imageLiteral(resourceName: "Wyoming"),#imageLiteral(resourceName: "Tennessee"),#imageLiteral(resourceName: "New Mexico"),#imageLiteral(resourceName: "Missouri"),#imageLiteral(resourceName: "South Dakota")]

  lazy var favPropertiesArray = [propertyModel]()
  lazy var statesArray = [statesModel]()
  lazy var leasePropertyArray = [propertyModel]()
  lazy var salePropertyArray = [propertyModel]()
  lazy var recentlyViewedPropertyArray = [propertyModel]()
  lazy var categoriesArray = [CategoriesModel]()
  
  let salesCV = 1
  let leaseCV = 2
  let recentlyViewedCV = 3
  lazy var CVNoForFav = Int()
  
  let transition = TransitionAnimator()
  var selectedCell = UICollectionViewCell()
  lazy var isShowingDrawer = false
//  var cellImage = UIImage()
  
  
    //MARK:- View LifeCycle
    override func viewDidLoad() {
      
      super.viewDidLoad()
      setUpViews()
      
  
  }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    startTimer()
    self.tabBarController?.tabBar.isHidden = false
    leaseCollectionView.reloadData()
    saleCollectionview.reloadData()
    recnetlyViewedCollectionView.reloadData()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    if touch?.view == shadowView{
      
      toggleDimView(flag: false)
      toggleDrawerView(flag: false)
      
    }

  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
        super.viewWillDisappear(true)
        stopTimer()
  
  }
    
  override func viewDidLayoutSubviews() {
    sliderCollectionViewHeight.constant = super.view.frame.width / 2
  }
  
  
  
  //MARK: View Setup
  
  private func setUpViews() {

    addTopBar()
    shadowView.isHidden = true
    categoriesCollectionView.delegate = self
    categoriesCollectionView.dataSource = self
    sliderCollectionViewDataSource = [UIImage (named: "homeSlider1")!, UIImage (named: "homeSlider2")!, UIImage (named: "homeSlider3")!, UIImage (named: "homeSlider4")!]
//        sliderCollectionViewHeight.constant = view.frame.width / 2
    StatesApiCall()
    SalePropertyApiCall()
    LeasePropertyApiCall()
    getCategories()
    getRecentlyViewedProperties()
      swipe()
    
    let MycustomCell = UINib(nibName: SaleProprtyTableViewCellId, bundle: nil)
    self.saleCollectionview.register(MycustomCell, forCellWithReuseIdentifier: SaleProprtyTableViewCellId)
    self.leaseCollectionView.register(MycustomCell, forCellWithReuseIdentifier: LeaseProprtyTableviewcell)
    self.recnetlyViewedCollectionView.register(MycustomCell, forCellWithReuseIdentifier: recentlyViewedProprtyTableviewcell)
    
    salemoreBtn.makeRoundedCorners(cornerRadius: 15)
    leasemoreBtn.makeRoundedCorners(cornerRadius: 15)
    transition.dismissCompletion = {
      self.selectedCell.isHidden = false
    }
    
  }
    //MARK:- Top Bar Setting
    // setting variable for top bar View
    lazy var titleview = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)?.first as! TopView
    
    private func addTopBar() {
        self.navigationItem.titleView = titleview
      titleview.propertySearchBar.isHidden = true
      titleview.iconBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
      titleview.searchBtn.addTarget(self, action: #selector(searchBtnTapped(sender:)), for: .touchUpInside)
      titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
      titleview.pizzaMEnu.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
      
      titleview.micBtn.addTarget(self, action: #selector(btnMikeTapped(_:)), for: .touchUpInside)
       
//      titleview.filterBtn.addTarget(self, action: #selector(filterBtnTapped(_:)), for: .touchUpInside)
        self.navigationItem.hidesBackButton = true
    }
  
  
  
  //MARK:- Actions
  @IBAction func saleMoreBtnTapper(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
     // sender.tag value is saved through storyBorad
    vc.productsArray = self.salePropertyArray
     vc.flagMoreButtonSale = true
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  @IBAction func detailPageTapped(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "detailPageViewController") as! detailPageViewController
   
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @IBAction func leaseMoreBtnTapped(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
     // sender.tag value is saved through storyBorad
    vc.flagMoreButtonLease = true
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @IBAction func recentlViewedMoreBtnTapped(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
    vc.flagMoreButton3RecentlyViewed = true
    self.navigationController?.pushViewController(vc, animated: true)
    
  }

  // going back directly towards the home
  
  @objc func homeBtnTapped(sender: UIButton) {
    
    setRootViewController(storyboardName: "Main", VCIdentifier: "SliderVC")
       
    }

  @objc private func searchBtnTapped(sender: UIButton) {
  tabBarController?.selectedIndex = 4
    
  }
  
  @objc private func pizzaMenuTapped(_ sender: UIButton) {
    
    toggleDrawerView(flag: !isShowingDrawer)

  }
  
  @objc func btnMikeTapped(_ sender: UIButton) {
    
    print("SpeechRecIconTapped called in \(self)")
    if let navController = self.tabBarController?.children[4] as? UINavigationController {
      if let searchVC = navController.topViewController as? SearchViewController {
        searchVC.flagOpenSpeechRecView = true
        tabBarController?.selectedIndex = 4
      }
    }
    
  }
  
  //MARK:- API Calls
  private func LeasePropertyApiCall(){
  
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: LeasePropertyUrl, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
//          let totalItems = jsonDic["totalItems"]?.int ?? 0
//          self.totalPages = jsonDic["totalPages"]?.int ?? 0
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
            self.leasePropertyArray.append(object)
          }
          
        }
        self.leaseCollectionView.reloadData()
      }
      
    }
    
  }
  
  private func SalePropertyApiCall(){
   
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: SalePropertyUrl, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
//          let totalItems = jsonDic["totalItems"]?.int ?? 0
//          self.totalPages = jsonDic["totalPages"]?.int ?? 0
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
            self.salePropertyArray.append(object)
          }
          
        }
        
        self.saleCollectionview.reloadData()
        
      }else {
        
        
      }
      
    }
    
  }
  // calling recently viewed properties
  private func getRecentlyViewedProperties(){
    
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    
    Networking.instance.getApiCall(url: recentlyViewedUrl, header: header){ (data, error, statusCode) in
      
      if error == nil && statusCode == 200{

        if let jsonDic = data.dictionary{
//          let totalItems = jsonDic["totalItems"]?.int ?? 0
//          self.totalPages = jsonDic["totalPages"]?.int ?? 0
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
            self.recentlyViewedPropertyArray.append(object)
          }
          
        }
        
        self.recnetlyViewedCollectionView.reloadData()
        
      }else {
        
        
      }
      
    }
    
  }
  
  // calling States Api
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
       
        self.statesCollectionView.reloadData()
        
      }
      
      
    }
    
  }
  
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
       
        self.categoriesCollectionView.reloadData()
        
      }
      
      
    }
    
  }
  
  
    @objc func RepondtoGesture(gesture: UISwipeGestureRecognizer) {
      
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            swipeLeft()
        case UISwipeGestureRecognizer.Direction.right:
            swipeRight()
//            shadowView.isHidden = false
        default:
            break
        }
        
    }
    
   
    
    //MARK:- Private Functions
  
  private func toggleDrawerView(flag: Bool){
    
    if flag{
      
      drawerLeading.constant = 0
      toggleDimView(flag: true)
      
    }else {
      
      drawerLeading.constant = -280
      toggleDimView(flag: false)
      
    }
    
    isShowingDrawer = !isShowingDrawer
    UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
    
    
  }
  
  private func toggleDimView(flag: Bool){
    
    if flag{
      
      shadowView.isHidden = false
      
    }else {
      
      shadowView.isHidden = true
      
    }
    
  }
  
  @objc func toggleFavourite(_ sender: UIButton){
    
    guard let flag = self.favPropertiesArray[sender.tag].isFavourite else {return}
    guard let propertyId = favPropertiesArray[sender.tag].id else {return}
    if flag{
      
      mainService.instance.removeFromFavourites(propertyId: String(describing: propertyId) ){ (success, isRemoved) in
        
        if success{
          if isRemoved {
            
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
            self.favPropertiesArray[sender.tag].isFavourite = false
//            let message = mainService.instance.message
            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property removed from favorites")
            
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
            self.favPropertiesArray[sender.tag].isFavourite = true
            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property added to favorites")
            
          }else {
            
            
            
          }
          
        }else {
          
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
          
        }
        
      }
      
    }
    
    
  }

  
    private func swipe() {
      
      let Rightswipe = UISwipeGestureRecognizer(target: self, action: #selector(self.RepondtoGesture))
      Rightswipe.direction = UISwipeGestureRecognizer.Direction.right
      self.view.addGestureRecognizer(Rightswipe)
      
      let Leftswipe = UISwipeGestureRecognizer(target: self, action: #selector(self.RepondtoGesture))
      Leftswipe.direction = UISwipeGestureRecognizer.Direction.left
      self.view.addGestureRecognizer(Leftswipe)
  
  }
    
    private func swipeRight() {
      
      toggleDrawerView(flag: true)
      
  }
    
    private func swipeLeft() {
      
      toggleDrawerView(flag: false)

    }
  
  func getSelectedArray() -> [propertyModel]? {
    
    if CVNoForFav == salesCV{
      
      return self.salePropertyArray
      
    }else if CVNoForFav == leaseCV{
      
      return self.leasePropertyArray
      
    }else if CVNoForFav == recentlyViewedCV{
      
      return self.recentlyViewedPropertyArray
      
    }else {
      
      return nil
      
    }
    
    
  }
  
  
  func setSelectedArray(array : [propertyModel]){
    
    if CVNoForFav == salesCV{
      
      self.salePropertyArray.removeAll()
      self.salePropertyArray.append(contentsOf: array)
      
      
    }else if CVNoForFav == leaseCV{
      
      self.leasePropertyArray.removeAll()
      self.leasePropertyArray.append(contentsOf: array)
      
    }else if CVNoForFav == recentlyViewedCV{
      
      self.recentlyViewedPropertyArray.removeAll()
      self.recentlyViewedPropertyArray.append(contentsOf: array)
      
    }
    
  }
  
}

//MARK:- UICollectioview Data Source and Delegate
extension homeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
      return 1
  
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == sliderColView{
      
      return sliderCollectionViewDataSource.count * dummyCount
    
    }else if collectionView == statesCollectionView {
      
      return self.statesArray.count
    
    }else if collectionView == categoriesCollectionView {
      
      return self.categoriesArray.count
      
    }else if collectionView == saleCollectionview {
      
      return self.salePropertyArray.count
    
    }else if collectionView == leaseCollectionView {
      
      return self.leasePropertyArray.count
    
    }else if collectionView == recnetlyViewedCollectionView{
      
      return self.recentlyViewedPropertyArray.count
    
    }else if collectionView == packgesPricingCollectionView{
      
      return packagesPlanArray.count
    
    }else {
      
      return 0
    
    }
  
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == sliderColView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
      print(indexPath.row)
      print(indexPath.item)
      let imageIndex = indexPath.item % sliderCollectionViewDataSource.count
      var image = UIImage()
      image = sliderCollectionViewDataSource[imageIndex]
      cell.imageDetailSlider.image = image
      return cell
    
    }else if collectionView == statesCollectionView{
      let cell = statesCollectionView.dequeueReusableCell(withReuseIdentifier: "stateCell", for: indexPath) as! StatesCollectionViewCell
      let array = self.statesArray
      guard indexPath.row < array.count else {return cell}
      let instance = array[indexPath.row]
      cell.stateNameLbl.text = instance.stateName
      cell.stateImg.image = statesImageIcons[indexPath.row]
      return cell
    
    }else if collectionView == categoriesCollectionView{
      
      let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
      let catArray = self.categoriesArray
      cell.categoryLabel.text = catArray[indexPath.row].propertyType
      let categoryIcons = catArray[indexPath.row].logoOfCategories
      cell.categoryImage.sd_setImage(with: URL(string: categoryIcons), placeholderImage: UIImage(named: "appLogo"))
      return cell
      
      
    } else if collectionView == saleCollectionview {
      
      self.CVNoForFav = self.salesCV
      let cell = saleCollectionview.dequeueReusableCell(withReuseIdentifier: "propertyCollectionViewCell", for: indexPath) as! propertyCollectionViewCell
      
      self.favPropertiesArray =  self.salePropertyArray
      guard indexPath.row < favPropertiesArray.count else {return cell}
      let instance = favPropertiesArray[indexPath.row]
      cell.loadData(item: instance)
      cell.likeBtn.tag = indexPath.row
      cell.favDelegate = self
      cell.getFavoriteInfo(flag: instance.isFavourite!, index: indexPath.row)
      
      if  instance.isFavourite ?? false{
        
        cell.likeBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        
        
      }else {
        
        cell.likeBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
        
      }
//      cell.likeBtn.addTarget(self, action: #selector(self.toggleFavourite), for: .touchUpInside)
      return cell
    
    }else if collectionView == recnetlyViewedCollectionView{
      
      self.CVNoForFav = self.recentlyViewedCV
      let cell = recnetlyViewedCollectionView.dequeueReusableCell(withReuseIdentifier: "propertyCollectionViewCell", for: indexPath) as! propertyCollectionViewCell
//      self.productsArray =  homeService.instance.salePRopertArray
      self.favPropertiesArray = self.recentlyViewedPropertyArray
      guard indexPath.row < favPropertiesArray.count else {return cell}
      let instance = favPropertiesArray[indexPath.row]
      cell.loadData(item: instance)
      cell.favDelegate = self
      cell.getFavoriteInfo(flag: instance.isFavourite!, index: indexPath.row)
      if  instance.isFavourite ?? false{
        
        cell.likeBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        
        
      }else {
        
        cell.likeBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
        
      }

      return cell
    
    }else if collectionView == packgesPricingCollectionView {
      
      
      let identifier = "packagesPricingCollectionViewCell"
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! packagesPricingCollectionViewCell
      cell.planLbl.text = packagesPlanArray[indexPath.row]
      cell.priceLbl.text = pacakgesPriceArray[indexPath.row]
      cell.priceLbl.backgroundColor = priceBackgroundColor[indexPath.row]
      cell.RegisterBtn.backgroundColor = registeredButtonArray[indexPath.row]
      
      let registeredButton = cell.RegisterBtn!
      let statusValue:Bool = UserDefaults.standard.bool(forKey: "loginStatus")
      if statusValue == false {

      }else {

        
      }

      
      
      
      cell.layer.cornerRadius = 3.0
      
      cell.layer.masksToBounds = false
      
      cell.layer.shadowColor = UIColor.black.cgColor
      
      cell.layer.shadowOffset = CGSize(width: 0, height: 0)
      
      cell.layer.shadowOpacity = 0.6
      
      //    cell.sellImagevView.addShadowAndRound()
      
      let baseView = cell.packagesCollectionView!
      
      baseView.layer.cornerRadius = 8
      
      baseView.clipsToBounds = true
      registeredButton.layer.cornerRadius = 8
      registeredButton.clipsToBounds = true
  
      return cell
    } else {
      
      self.CVNoForFav = self.leaseCV
      let cell = leaseCollectionView.dequeueReusableCell(withReuseIdentifier: "propertyCollectionViewCell", for: indexPath) as! propertyCollectionViewCell
      self.favPropertiesArray = self.leasePropertyArray
//      let array = homeService.instance.leasePropertyArray
      guard indexPath.row < favPropertiesArray.count else {return cell}
      let instance = favPropertiesArray[indexPath.row]
      cell.loadData(item: instance)
      cell.favDelegate = self
      cell.getFavoriteInfo(flag: instance.isFavourite!, index: indexPath.row)

      if  instance.isFavourite ?? false{
        
        cell.likeBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
        
        
      }else {
        
        cell.likeBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
        
      }

      
      return cell
    
    }
  
  }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      if collectionView == statesCollectionView {
        
        let array = self.statesArray
        guard indexPath.row < array.count else {return}
        let instance = array[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
        vc.searchKeyword = instance.stateName!
        self.navigationController?.pushViewController(vc, animated: true)
      
      }else if collectionView == categoriesCollectionView{
        
        let array = self.categoriesArray
        
        guard indexPath.row < array.count else {return}
        let instance = array[indexPath.row].propertyType
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
        vc.searchKeyword = instance
        self.navigationController?.pushViewController(vc, animated: true)
        
      } else if collectionView == saleCollectionview{
        
        selectedCell = (collectionView.cellForItem(at: indexPath) as? propertyCollectionViewCell)!
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailPageViewController") as! detailPageViewController
        let array = self.salePropertyArray
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

      }else if collectionView == leaseCollectionView{
        
        selectedCell = (collectionView.cellForItem(at: indexPath) as? propertyCollectionViewCell)!
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailPageViewController") as! detailPageViewController
        let array = self.leasePropertyArray
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
        
      }else if collectionView  == sliderColView{
        
        tabBarController?.selectedIndex = 4
        
        
      } else if collectionView == packgesPricingCollectionView{
        
        
        
      }else {
        selectedCell = (collectionView.cellForItem(at: indexPath) as? propertyCollectionViewCell)!
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailPageViewController") as! detailPageViewController
        let array = self.recentlyViewedPropertyArray
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
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      
      if collectionView == sliderColView {
        
        return sliderColView.bounds.size
      
      }else if collectionView == statesCollectionView {
        
        let catName = self.statesArray[indexPath.row].stateName
        let label = UILabel(frame: CGRect.zero)
        label.text = catName
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: 80)
        
//        let cgSize = CGSize(width: 100, height: 80)
//        return cgSize
      
      }
      else if collectionView == categoriesCollectionView || collectionView == statesCollectionView {
        
        let catName = self.categoriesArray[indexPath.row].propertyType
        if catName.count <= 5{
          
          return CGSize(width: 60, height: 80)
          
        }else {
          
          let label = UILabel(frame: CGRect.zero)
          label.text = catName
          label.sizeToFit()
          return CGSize(width: label.frame.width + 10, height: 80)
          
        }
        
//        return catName.size(withAttributes: nil)
        
      }else if collectionView == packgesPricingCollectionView {
        
        if Env.iPad{
          
          let height = packgesPricingCollectionView.bounds.height
          let cgSize = CGSize(width: 370, height: height - 30)
          return cgSize
        
        }else {
          
          let height = packgesPricingCollectionView.bounds.height
          let cgSize = CGSize(width: 250, height: height - 10)
          return cgSize
        
        }} else {
        
        let cgSize = CGSize(width: 217, height: 230)
        return cgSize
      
      }
      
    }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    if (scrollView == self.sliderColView) {
      if temp == nil{
        return
      }
      else {
        
        self.centerIfNeeded(animationTypeAuto: false, offSetBegin: temp!)
        self.startTimer()
        
      }
      
    }
    
  }
  
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    
    DispatchQueue.main.async() {
      
      self.stopTimer()
      
      self.sliderColView.reloadData()
      
      self.sliderColView.setContentOffset( CGPoint.zero, animated: true)
      
      self.startTimer()
      
    }
    
    print("changed orientation")
    
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    if (scrollView == self.sliderColView) {
      
      stopTimer()
    
    }
  
  }
    
    // start animating the slider
  func startTimer() {
    
    //self.colVSliderImages.setContentOffset(CGPoint.zero, animated: false)
    
    if sliderCollectionViewDataSource.count > 1 && scrollingTimer == nil {
      
      let timeInterval = 3.0;
      
      scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.rotate), userInfo: nil, repeats: true)
      
      scrollingTimer!.fireDate = Date().addingTimeInterval(timeInterval)
      
    }
    
  }
  
  func stopTimer() {
    
    scrollingTimer?.invalidate()
    
    scrollingTimer = nil
    
  }
  
  @objc func rotate() {
    
    //print("passed offset to rotate: \(colVSlider.contentOffset.x)")
    
    let offset = CGPoint(x:self.sliderColView.contentOffset.x + cellWidth, y: self.sliderColView.contentOffset.y)
    
    //print("setting the Calculated offset in rotate: \(offset)")
    
    var animated = true
    
    if (offset.equalTo(CGPoint.zero) || offset.equalTo(CGPoint(x: totalContentWidth, y: offset.y))){
      
      animated = false
      
    }
    
    self.sliderColView.setContentOffset(offset, animated: animated)
    
    print("\n")
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    if (scrollView == self.sliderColView) {
      
      self.centerIfNeeded(animationTypeAuto: true, offSetBegin: CGPoint.zero)
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if(scrollView == self.sliderColView){
      
      if(scrollView.panGestureRecognizer.state == .began){
        
        stopTimer()
        
      }else if( scrollView.panGestureRecognizer.state == .possible){
        
        startTimer()
        
      }
      
    }
    
  }
  
  func centerIfNeeded(animationTypeAuto:Bool, offSetBegin:CGPoint) {
    
    let currentOffset = self.sliderColView.contentOffset
    
    let contentWidth = self.totalContentWidth
    
    let width = contentWidth / CGFloat(dummyCount)
    
    if currentOffset.x < 0{
      
      //left scrolling
      
      self.sliderColView.contentOffset = CGPoint(x: width - currentOffset.x, y: currentOffset.y)
      
    } else if (currentOffset.x + cellWidth) >= contentWidth {
      
      //right scrolling
      
      let  point = CGPoint.zero
      
      //point.x = point.x - cellWidth
      
      var tempCGPoint = point
      
      tempCGPoint.x = tempCGPoint.x + cellWidth
      
      print("center if need set offset to \( tempCGPoint)")
      
      self.sliderColView.contentOffset = point
      
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
    if (scrollView == self.sliderColView)
    {
      print("\(scrollView.contentOffset)")
      
      self.temp = scrollView.contentOffset
      
      self.stopTimer()
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    if(collectionView == self.sliderColView){

      
      var page:Int =  Int(collectionView.contentOffset.x / collectionView.frame.size.width)
      
      page = page % sliderCollectionViewDataSource.count
      
      //print("page = \(page)")
      
      pageControl.currentPage = Int (page)
      
    }
    
  }
  
  
  func updatePageControl(){
    
    var updatedPage = selectedPage + 1
    
    let totalItems = sliderCollectionViewDataSource.count
    
    updatedPage = updatedPage % totalItems
    
    print("updatedPage: \(updatedPage)")
    
    selectedPage  = updatedPage
    
    self.pageControl.currentPage = updatedPage
    
  }
  var totalContentWidth: CGFloat {
    
    //Total width
    //return CGFloat(collectionViewImageArray.count) * cellWidth
    return CGFloat(sliderCollectionViewDataSource.count * dummyCount) * cellWidth
    
  }
  var cellWidth: CGFloat {
    
    return self.sliderColView.frame.width
    
  }
    
    
}


extension homeVC: PropertyCellDelegate{
  
  
  func toggleFavorite(flag: Bool, index: Int, sender: UIButton) {
    

    var array = getSelectedArray()
    guard let propertyId = getSelectedArray()?[index].id else {return}
    if flag{
      
      mainService.instance.removeFromFavourites(propertyId: String(describing: propertyId) ){ (success, isRemoved) in
        
        if success{
          if isRemoved {
            
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
            array?[index].isFavourite = false
            self.setSelectedArray(array: array!)
            
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
            array![index].isFavourite = true
            self.setSelectedArray(array: array!)
//            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property added to favorites")
            
          }else {
            
            
            
          }
          
        }else {
          
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
          
        }
        
      }
      
    }
//    print("array![index].isFavourite: ",array![index].isFavourite)
//    setSelectedArray(array: array!)
//    print("getSelectedArray()![index].isFavourite: ",getSelectedArray()![index].isFavourite)

    
  }
  
}

extension homeVC: UIViewControllerTransitioningDelegate {
  
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

