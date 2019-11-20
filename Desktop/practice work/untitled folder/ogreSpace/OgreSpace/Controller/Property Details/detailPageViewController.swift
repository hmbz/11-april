//
//  detailPageViewController.swift
//  OgreSpace
//
//  Created by admin on 7/9/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
import SKPhotoBrowser
import Charts
//import DTPhotoViewerController

class detailPageViewController: UIViewController {
  
  //MARK:- Outlets

  @IBOutlet weak var imageSliderCollectionView: UICollectionView!
  @IBOutlet weak var heightOfPropertyColView: NSLayoutConstraint!
  @IBOutlet weak var featuresCollectionView: UICollectionView!
//  @IBOutlet weak var detailviewShadow: UIView!
//  @IBOutlet weak var propertyTileLbl: UILabel!
  @IBOutlet weak var propertyPriceLbl: UILabel!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var desciptionLbl: UILabel!
  @IBOutlet weak var detailTypeLbl: UILabel!
  @IBOutlet weak var addressLbl: UILabel!
  @IBOutlet weak var detailPriceLbl: UILabel!
  @IBOutlet weak var detailPropertyTitleLbl: UILabel!
  @IBOutlet weak var presentedNameLbl: UILabel!
  @IBOutlet weak var detailAreaLbl: UILabel!
  @IBOutlet weak var detailAddressLbl: UILabel!
  @IBOutlet weak var detailPropertyLbl: UILabel!
  @IBOutlet weak var similarPropertiesColView: UICollectionView!
  @IBOutlet weak var detailPropertyIdLbl: UILabel!
  @IBOutlet weak var propertyMapView: MKMapView!
  @IBOutlet weak var featuresViewHeightConstraint: NSLayoutConstraint!
  
  
  @IBOutlet weak var nearbyPlacesCollectionView: UICollectionView!
  
  @IBOutlet weak var scheduleTourBtn: UIButton!
  
  @IBOutlet weak var requestToBookBtn: UIButton!
  
  @IBOutlet weak var demographicsCollectionView: UICollectionView!
  
  @IBOutlet weak var nearbyPlacesPopupView: UIView!
  @IBOutlet weak var nearbyPlacesTableView: UITableView!
//
  @IBOutlet weak var dimView: UIView!
//
  @IBOutlet weak var nearbyPlaceTitleLbl: UILabel!
  
  @IBOutlet weak var demographicsCVHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var nearbyPlacesViewheightConstraint: NSLayoutConstraint!
  
//  @IBOutlet weak var mapView: UIView!
// 
//  @IBOutlet weak var demographicsView: UIView!
//  
//  @IBOutlet weak var nearbyPlacesView: UIView!
  
  @IBOutlet weak var favoriteBtn: UIButton!
  
  @IBOutlet weak var mainScrollView: UIScrollView!
  
  @IBOutlet weak var navigationView: UIView!
  
  @IBOutlet weak var barChartView: LineChartView!
  @IBOutlet weak var pieChartView: PieChartView!

  @IBOutlet weak var pieChartLbl: UILabel!
  @IBOutlet weak var PieGraphView: UIView!
  @IBOutlet weak var barChartLbl: UILabel!
  
  @IBOutlet weak var barGraphView: UIView!
  
  @IBOutlet weak var sliderCollectionViewHeightConstraint: NSLayoutConstraint!
  
  //MARK:- Properties
//  lazy var itemId = String()
  
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  lazy var detailId = Int()
  lazy var isFav = Bool()
  var temp:CGPoint?
  var scrollingTimer: Timer?
  var dummyCount = 10000
  var selectedPage = 0
  lazy var similarCollectionViewCellId: String = "propertyCollectionViewCell"
//  var sliderArray = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "sliderIpad4"),#imageLiteral(resourceName: "sliderIpad4"),#imageLiteral(resourceName: "man"),#imageLiteral(resourceName: "bell")]
  lazy var sliderImagesArray: Array = [SKPhoto]()
  lazy var propertyImagesArray: Array = [String]()
  var featuresArrayString = [String]()

  var locationDict = [String: Any]()
  fileprivate lazy var selectedImageIndex: Int = 0
  
  let demographicsTextArray = ["Forecast", "Crime Rate", "Home Value", "Gender Ratio", "Rent paid by renters", "Total houses built", "Household distribution"]
  //    , "Population", "Population Change Detail", "Population by occupation", "Education", "Occupied houses according to population", "Public transportation Detail", "Economy", "Property detail"
  
  let demographicsImagesArray = [UIImage(named: "forecast"), UIImage(named: "crime_det"), UIImage(named: "house_permits"),UIImage(named: "gender"), UIImage(named: "rent_paid"), UIImage(named: "house_build"), UIImage(named: "house_owners")]
  //    , UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners")]
  
  let nearbyPlacesTextArray = ["Coffee", "Park", "Hospital", "School", "Airport", "Police", "Cinema", "Mall", "Hotel", "Metro Station", "Playground", "Subway", "Railway"]
  let nearbyPlacesImagesArray: [UIImage] = [#imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "Parking"), #imageLiteral(resourceName: "Hospital"), #imageLiteral(resourceName: "Education"), #imageLiteral(resourceName: "Airport"), #imageLiteral(resourceName: "Police"), #imageLiteral(resourceName: "Cinema"), #imageLiteral(resourceName: "Mall"), #imageLiteral(resourceName: "Hotel"), #imageLiteral(resourceName: "Metrostation"), #imageLiteral(resourceName: "Playground"), #imageLiteral(resourceName: "Subway"), #imageLiteral(resourceName: "Railway")]
  
  var nearbyPlacesDataArray = [NearbyPlacesModel]()
  var demographicsDataArray = [DemographicsModel]()
  
  var crimeRateTextArray = [String]()
  var crimeRateValueArray = [Double]()
  
  var homeValueTextArray = [String]()
  var homeValueNumberArray = [Double]()
  
  var rentDataTextArray = [String]()
  var rentDataValueArray = [Double]()
  
  var housesBuiltTextArray = [String]()
  var housesBuiltValueArray = [Double]()
  
  var householDistributionTextArray = [String]()
  var householDistributionValueArray = [Double]()
  
  var genderDataValuesArray = [Double]()
  var genderDataTextArray = ["Age under 5", "Age under 18", "Age above 65", "Male Population", "Female Population", "White Population", "Black Population", "Other Population"]
  
//  var months = [String]()
//  var unitsSold = [Double]()
  let forecastTextArray = ["Forecast 2017", "Forecast 2018", "Forecast 2019", "Forecast 2020"]
  var foreCastValuesArray = [Double]()

  
//  var animationImage: String?
//  var nearbyPlacesArray = [NearbyPlacesModel]()
  
  //MARK:- View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
//    setupView()
    dimView.isUserInteractionEnabled = false
    detailPropertyIdLbl.text = String(describing:  self.detailId)
    PieGraphView.isHidden = true
    barGraphView.isHidden = true
    
    propertyMapView.mapType = .standard
    addTopBar()
    
    imageSliderCollectionView.reloadData()
//    animationImageView.sd_setImage(with: URL(string: animationImage!), placeholderImage: UIImage(named: "appLogo"))
    
    print(detailId)
    let saleUrl = detailUrl + "\(detailId)" + "/"
    let similarPropUrl = similarPropertyUrl + "\(detailId)"
    
    getDetailOfProperty(url: saleUrl)
    
    similarProperty(url: similarPropUrl)
    let MycustomCell = UINib(nibName: similarCollectionViewCellId, bundle: nil)
    self.similarPropertiesColView.register(MycustomCell, forCellWithReuseIdentifier: similarCollectionViewCellId)
    startTimer()
    scheduleTourBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
    requestToBookBtn.applyShadowOnRoundedBlackButton(backColor: .black, titleColor: .white)
   
    imageSliderCollectionView.delegate = self
    imageSliderCollectionView.dataSource = self
    similarPropertiesColView.delegate = self
    similarPropertiesColView.dataSource = self
    featuresCollectionView.delegate = self
    featuresCollectionView.dataSource = self
    nearbyPlacesCollectionView.delegate = self
    nearbyPlacesCollectionView.dataSource = self
    nearbyPlacesTableView.delegate = self
    nearbyPlacesTableView.dataSource = self
    demographicsCollectionView.delegate = self
    demographicsCollectionView.dataSource = self
    
    nearbyPlacesPopupView.makeRoundedCorners(cornerRadius: 8)
    nearbyPlacesPopupView.isHidden = true
    dimView.isHidden = true
    
    self.tabBarController?.tabBar.isHidden = true
    
//    addGestureRecognizers()
    featuresViewHeightConstraint.constant = 0
//    self.imageSliderCollectionView.maximumZoomScale = 10.0
//    self.imageSliderCollectionView.maximumZoomScale = 1.0
    if isFav {
      
      favoriteBtn.setImage(UIImage(named: "filledHeart"), for: .normal)
      
    }else {
      
      favoriteBtn.setImage(UIImage(named: "emptyHeart"), for: .normal)
      
    }
    
    if Env.iPad{
      
      demographicsCVHeightConstraint.constant = (UIScreen.main.bounds.width / 7) + 30
      nearbyPlacesViewheightConstraint.constant = ((UIScreen.main.bounds.width / 7)*2) + 30
      
    }else {
      
      let singleItemHeight = (UIScreen.main.bounds.width / 4) + 15
      demographicsCVHeightConstraint.constant = (singleItemHeight * 2)
      nearbyPlacesViewheightConstraint.constant = (((UIScreen.main.bounds.width / 5) + 16) * 3)
      
    }
    sliderCollectionViewHeightConstraint.constant = UIScreen.main.bounds.height * 0.35
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches , with:event)
    let touch = touches.first
    if touch?.view == dimView {
      nearbyPlacesPopupView.isHidden = true
      barGraphView.isHidden = true
      PieGraphView.isHidden = true
      
    }
  }
  
  private func addTopBar() {
    
//    @IBOutlet weak var backBtn: UIButton!
//    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var inviteBtn: UIButton!
//    @IBOutlet weak var homeBtn: UIButton!
    
    self.navigationView.addSubview(titleview)
    titleview.frame = navigationView.bounds
//    titleview.filterBtn.removeFromSuperview()
//    titleview.notificationBtn.removeFromSuperview()
//    titleview.searchBtn.isUserInteractionEnabled = false
//    titleview.micBtn.setImage(UIImage(named: "ShareGray"), for: .normal)
//    titleview.micBtn.addTarget(self, action: #selector(shareBtnTapped(sender:)), for: .touchUpInside)
    titleview.homeBtn.layer.cornerRadius = 6
    titleview.homeBtn.layer.masksToBounds = true
    titleview.homeBtn.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
//    titleview.backBtn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 0)
    titleview.titleLbl.text = "Property Detail"
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
//    titleview.backBtn.setImage(UIImage(named: "grayBack"), for: .normal)
    titleview.backBtn.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)

    self.navigationItem.hidesBackButton = true
  }
  
  
  @objc func shareBtnTapped(sender: UIButton) {
    
    dismiss(animated: false, completion: nil)
    
  }

  @objc private func pizzaMenuTapped(_ sender: UIButton) {
    
    dismiss(animated: false, completion: nil)
  }
  
//  override func viewLayoutMarginsDidChange() {
//    titleview.frame = navigationView.frame
////    print("titleview width = \(titleview.frame.width)")
//  }
  
//  override func viewDidLayoutSubviews() {
//    
//    self.addGradient(view: self.detailviewShadow)
//
//  }
  
//  override func viewDidLayoutSubviews() {
//    heightOfPropertyColView.constant = super.view.frame.width / 2
//  }
//  func setupView (){
//    self.detailviewShadow.shadowSimple()
//    mapingView()
//    descriptionTextViewShadow.shadowSimple()
//    overViewTextViewShadow.shadowSimple()
//    amentiesViewShadow.shadowSimple()
//    mapViewshadow.shadowSimple()
//    ogrespaceShadow.shadowSimple()
//   
//    
//  }
  

  
    //MARK:- Actions
  
  @IBAction func scheduleTourPressed(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleTourViewController") as! ScheduleTourViewController
    let propertyId = self.detailId
//    print(propertyId)
    vc.propertyId = String(describing: propertyId)
    let navController = UINavigationController(rootViewController: vc)
    present(navController, animated: true, completion: nil)
//    present(vc, animated: true)
//    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @IBAction func requestToBookPressed(_ sender: Any) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "RequestToBookViewController") as! RequestToBookViewController
    let propertyId = self.detailId
//    print(propertyId)
    vc.propertyId = String(describing: propertyId)
    let navController = UINavigationController(rootViewController: vc)
    present(navController, animated: true, completion: nil)
//    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @IBAction func hideNearbyPlacesPopupAction(_ sender: Any) {
    
//    toggleNearbyPlacesView()
    nearbyPlacesPopupView.isHidden = true
    barGraphView.isHidden = true
    PieGraphView.isHidden = true
    dimView.isHidden = true
    
  }
  
//  private func addGestureRecognizers() {
//
//    let mapViewTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
//    mapView.isUserInteractionEnabled = true
//    mapView.addGestureRecognizer(mapViewTap)
//
//    let demographicsViewTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
//    demographicsView.isUserInteractionEnabled = true
//    demographicsView.addGestureRecognizer(demographicsViewTap)
//
//    let nearbyPlacesViewTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
//    nearbyPlacesView.isUserInteractionEnabled = true
//    nearbyPlacesView.addGestureRecognizer(nearbyPlacesViewTap)
//
//
//  }
  
//  @objc private func tapFunction(sender:UITapGestureRecognizer){
//
//    if sender.view == mapView {
//
//      let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//      vc.coordinatesDict = self.locationDict
//      let navController = UINavigationController(rootViewController: vc)
//      present(navController, animated: true, completion: nil)
////      present(vc, animated: true)
////      self.navigationController?.pushViewController(vc, animated: true)
//
//    }else if sender.view == demographicsView {
//
//      let isSubscribed  = UserDefaults.standard.bool(forKey: SessionManager.keys.isSubscribed)
//      if isSubscribed{
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DemographicsViewController") as! DemographicsViewController
//        guard let zipcode = homeService.instance.propertyDetail.zipcode else {return}
//        vc.flagDemoGraphics = true
//        vc.zipCode = zipcode
//        let navController = UINavigationController(rootViewController: vc)
//        present(navController, animated: true, completion: nil)
////        present(vc, animated: true)
////        self.navigationController?.pushViewController(vc, animated: true)
//
//      }else {
//
//        showSwiftMessageWithParams(theme: .error, title: "Subscribe", body: "Subscribe to OgreSpace to get demographics", layout: .messageView, position: .center , completion: { (value) in
//
//        })
//
//      }
//
//
//
//    }else {
//
//      let vc = storyboard?.instantiateViewController(withIdentifier: "DemographicsViewController") as! DemographicsViewController
//      vc.flagDemoGraphics = false
//      let navController = UINavigationController(rootViewController: vc)
//      present(navController, animated: true, completion: nil)
////      present(vc, animated: true)
////      self.navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//  }
  
  @IBAction func favoriteBtnTapped(_ sender: UIButton) {
    
////    print(sender.tag, "sender.tag")
//    guard let flag = self.productsArray[sender.tag].isFavourite else {return}
////    guard let propertyId = self.detailId else {return}
//    if flag{
//
//      mainService.instance.removeFromFavourites(propertyId: String(describing: self.detailId) ){ (success, isRemoved) in
//
//        if success{
//          if isRemoved {
//
//            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
////            self.productsArray[sender.tag].isFavourite = false
//            //            let message = mainService.instance.message
//            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property removed from favorites")
//            //            let indexPath = IndexPath(item: sender.tag, section: 0)
//            //            self.detailTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.top)
//            //            self.detailTableView.reload
//
//          }else {
//
//
//
//          }
//
//        }else {
//
//          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
//
//        }
//
//      }
//
//    }else {
//
//      mainService.instance.addToFavourites(propertyId: String(describing: self.detailId)){ (success, isAdded) in
//
//        if success{
//          if isAdded {
//
//            sender.setImage(UIImage(named: "filledHeart"), for: .normal)
////            self.productsArray[sender.tag].isFavourite = true
////            print(self.productsArray[sender.tag].isFavourite, "self.productsArray[sender.tag].isFavourite")
//            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property added to favorites")
//            //            let indexPath = IndexPath(item: sender.tag, section: 0)
//            //            self.detailTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.top)
//
//          }else {
//
//
//
//          }
//
//        }else {
//
//          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
//
//        }
//
//      }
//
//    }
    
  }
  
  @IBAction func propertyInfoBtnTapped(_ sender: Any) {
    
    let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
    let vc = homeStoryboard.instantiateViewController(withIdentifier: "CadDataViewController") as! CadDataViewController
    vc.propertyId = self.detailId
    let navController = UINavigationController(rootViewController: vc)
    present(navController, animated: true)
    
  }
  
  //MARK:- Detail API Function
  private func getDetailOfProperty(url: String){
    
    homeService.instance.getDetail(url: url) { (success) in
      if success{
        let status = homeService.instance.status
        if status == 404{
          print("404")
          
        }else if status == 200{
          
          print("200")
          
          self.sliderImagesArray.removeAll()
          self.mainScrollView.setContentOffset(CGPoint(x: 0, y:  0), animated: true) // for taking scroll view to the top in case of similar properties
          let instance = homeService.instance.propertyDetail
          let price = instance.price!
          let floatPrice = Float (price)
          let intPrice = Int(floatPrice ?? -1)
          print(intPrice)
          let largeNumber = intPrice
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .decimal
          let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
          self.propertyPriceLbl.text = "$" + String(formattedNumber!)
          //let title = instance.property_title
          //self.propertyTileLbl.text = title
          self.addressLbl.text = instance.Address
          self.desciptionLbl.text = instance.description
          guard let imagesUrl = instance.pic_url else {return}
          self.propertyImagesArray = imagesUrl.components(separatedBy: ",,,")
          print(self.propertyImagesArray)
          self.pageControl.numberOfPages = self.propertyImagesArray.count
          self.imageSliderCollectionView.reloadData()
//          let imageUrlArray = Array(imageUrl!)
//           print(imageUrlArray)
          if instance.property_id == "" {
            self.detailPropertyLbl.text = "null"
          }
            
          else {
            
            self.detailPropertyLbl.text = instance.property_id
            
          }
         
          
         
          if instance.Address == "" {
            
            self.detailAddressLbl.text = "null"
          }
          else {
             self.detailAddressLbl.text = instance.Address
          }
          if instance.property_type == "" {
            self.detailTypeLbl.text = "null"
          }
          else {
            self.detailTypeLbl.text = instance.property_type
          }
          if instance.price == "" {
            self.detailPriceLbl.text = "null"
          }
          else {
            self.detailPriceLbl.text = "$" + instance.price!
          }
          if instance.property_area == "" {
            self.detailAreaLbl.text = "null"
          }
          else {
            self.detailAreaLbl.text = instance.property_area! + " sqft"
          }
          if instance.property_title == ""{
            self.detailPropertyTitleLbl.text = "null"
          }
          else {
            self.detailPropertyTitleLbl.text = instance.property_title
          }
          if instance.presented_name == "" {
            self.presentedNameLbl.text = "null"
          }
          else{
            self.presentedNameLbl.text = instance.presented_name
          }
          
          if instance.latitude!.isEmpty || instance.longitude!.isEmpty || instance.property_title!.isEmpty {
            
            
          }else {
            
            let latitude = Double(instance.latitude!)
            let longitude = Double(instance.longitude!)
            let title = instance.property_title
            self.locationDict = [
              "latitude": latitude,
              "longitude": longitude,
              "title": title
            
            ]
            
            for item in self.propertyImagesArray{
              
              
//              let imageUrl = URL(string: item)
              let photo = SKPhoto.photoWithImageURL(item)
              self.sliderImagesArray.append(photo)
//              let downloader = SDWebImageManager()
//
//              downloader.imageDownloader?.downloadImage(with: imageUrl, options: .highPriority, progress: {
//                (receivedSize, expectedSize, url) in
//                // image is being downloading and you can monitor progress here
//              }, completed: { (downloadedImage, data, error, success) in
//                self.sliderImagesArray.append(downloadedImage!)
////                print(downloadedImage, data, success)
//
//              })
              
            }
            
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            annotation.coordinate = centerCoordinate
            annotation.title = title
            self.propertyMapView.showAnnotations([annotation], animated: true)

            let mapCenter = CLLocationCoordinate2DMake(latitude!, longitude!)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: mapCenter, span: span)
            self.propertyMapView.region = region
            self.propertyMapView.addAnnotation(annotation)
            
            
          }
          

          if instance.servicesArray!.isEmpty{
            
            self.featuresViewHeightConstraint.constant = 0

          }else {

            
            guard let count = instance.servicesArray?.count else {return}
            
            self.featuresCollectionView.reloadData()
            var numberOfRows = 0
            
            let (quotient, remainder) = count.quotientAndRemainder(dividingBy: 5)
            if remainder >= 1 || quotient == 0{
              
              numberOfRows = quotient + 1
              
            }else {
              
              numberOfRows = quotient
              
            }
//            let width = self.featuresCollectionView.frame.width
            let featuresLabelHeight = CGFloat(40)
            let featureCVRowHeight = (self.featuresCollectionView.frame.width / 5) + 18
            let heightOfCV = CGFloat(Int(featureCVRowHeight) * Int(numberOfRows))
            let totalHeight = featuresLabelHeight + heightOfCV
            print(count,  "features count")
            print(remainder, "remainder")
            print(numberOfRows, "numberOfRows")
            print(heightOfCV, "heightOfCV")
            self.featuresViewHeightConstraint.constant = totalHeight
//            self.featuresCollectionView.frame =  CGRect(x: 0, y: 0, width: width, height: heightOfCV)

          }
          
          let zipcode = instance.zipcode
          print(zipcode, "zipcode demographics")
          self.getDemographicsData(zipcode: zipcode!)
        
//          let instance = homeService.instance.detailArray
//          self.descriptionLbl.text = "\(instance.description)"
////          self.titeDetailLbl.text = instance[0].property_title
//          self.subTitleLbl.text = "\(instance[0].Address)" + " | " + "\(instance[0].city ?? "")"
//          self.titleLbl.text = instance[0].property_title
//          self.priceLbl.text = "\(instance[0].price)" + " / " + "\(instance[0].price_type)"
//          self.spaceLbl.text = "\(instance[0].post_type)" + " / " + "\(instance[0].property_type)"
//          self.areaLbl.text = "\(instance[0].property_area)" + " sqft "
//          self.detailCollectionView.reloadData()
        }
        else{
          print("Error!")
          
          
        }
      }
      else{
        let status = homeService.instance.status
        print(status)
        
      }
    }
    
  }
  
  func similarProperty(url: String){
    homeService.instance.smililarPropertiesAPI(url: url){ (totalItems, success) in
      if success{
        let status = homeService.instance.status
        if status == 404{
          print("404")
          
        }
        else if status == 202{
          print("202")
          
        }
          
        else if status == 200{
          print("200")
          self.similarPropertiesColView.reloadData()
        }
          
        else{
          print("Error!")
          
        }
      }
      else{
        let status = homeService.instance.status
        print(status)
        
      }
    }
  }
  
  
  private func getNearbyPlaces(params: [String: Any]){
    print(params)
    DetailPageService.instance.getNearByPlaces(params: params){ (success, dataArray) in
      if success{

//        let status = DetailPageService.instance.status
//        if status == 404{
//          print("404")
//
//        }else if status == 200 || status == 202 {
          print("200")
        self.nearbyPlacesDataArray = dataArray
        self.nearbyPlacesTableView.reloadData()
        self.toggleNearbyPlacesView()
//        }

//        else{
//          print("Error!")
//
//        }
      }
      else{
        let status = homeService.instance.status
        print(status)

      }
    }
  }
  
  
  private func getDemographicsData(zipcode: String){
    
    DetailPageService.instance.getDemograhics(zipcode: zipcode){ (success, data) in
      if success{
        print(data, "demographics data")
        self.pieChartLbl.text = "Forecast"
        let valuesArray = data?.ForecastData
        self.foreCastValuesArray = valuesArray!
        self.setPieChart(dataPoints: self.forecastTextArray, values: valuesArray!)
        
        self.crimeRateTextArray.removeAll()
        self.crimeRateValueArray.removeAll()
        let crimeDataArray = data?.CrimeRateData
        var index = 0
        for  name in crimeDataArray! {
          let name = crimeDataArray?[index].crimeTitle
          guard let unit = crimeDataArray?[index].crimeCount else {return}
          self.crimeRateTextArray.append(name ?? "nil")
          self.crimeRateValueArray.append(Double(unit))
          index = index + 1
          
        }
        self.homeValueTextArray.removeAll()
        self.homeValueNumberArray.removeAll()
        let homeValueArray = data?.HomeValueData
        for item in homeValueArray!{
          
          self.homeValueTextArray.append(item.valuesDetail!)
          self.homeValueNumberArray.append(Double(item.noOfHouses!))
          
        }
        self.genderDataValuesArray.removeAll()
        
        let genderArray = data?.GenderRatioData
        let genderDataInstance = genderArray?[0]
        self.genderDataValuesArray.append((genderDataInstance?.under5Population!)!)
        self.genderDataValuesArray.append((genderDataInstance?.under18Population!)!)
        self.genderDataValuesArray.append((genderDataInstance?.above65Population!)!)
        self.genderDataValuesArray.append((genderDataInstance?.malePopulation!)!)
        self.genderDataValuesArray.append((genderDataInstance?.femalePopulation!)!)
        self.genderDataValuesArray.append((genderDataInstance?.whitePopulation!)!)
        self.genderDataValuesArray.append((genderDataInstance?.blackPopulation!)!)
        self.genderDataValuesArray.append((genderDataInstance?.othersPopulation!)!)
        
        self.rentDataTextArray.removeAll()
        self.rentDataValueArray.removeAll()
        let rentPaidDataArray = data?.RentPaidData
        for item in rentPaidDataArray!{
          
          self.rentDataTextArray.append(item.priceDetail!)
          self.rentDataValueArray.append(Double(item.noOfPayers!))
          
        }
        self.housesBuiltTextArray.removeAll()
        self.housesBuiltValueArray.removeAll()
        let housesBuiltDataArray = data?.TotalHousesBuiltData
        for item in housesBuiltDataArray!{
          
          self.housesBuiltTextArray.append(item.year!)
          self.housesBuiltValueArray.append(Double(item.noOfHouses!))
          
        }
        
        self.householDistributionTextArray.removeAll()
        self.householDistributionValueArray.removeAll()
        let householdDataArray = data?.HouseholdDistributionData
        for item in householdDataArray!{
          
          self.householDistributionTextArray.append(item.incomeDistribution!)
          self.householDistributionValueArray.append(Double(item.noOfHouses!))
          
        }
        
      }
      else{
        let status = homeService.instance.status
        print(status)
        
      }
    }
  }

  
  private func toggleNearbyPlacesView(){

    nearbyPlacesPopupView.isHidden = !nearbyPlacesPopupView.isHidden
    dimView.isHidden = !dimView.isHidden

  }
  
  private func showBarChartView(){
    
    barGraphView.isHidden = false
    dimView.isHidden = false
    PieGraphView.isHidden = true
//    togglePieChartView()
    
  }
  
  private func showPieChartView(){
    
    barGraphView.isHidden = true
    dimView.isHidden = false
    PieGraphView.isHidden = false
    
  }
  
//  let instance = courseDetailVideoService.instance.bidReview
//  print(instance)
//  self.ratingViewForReviews.rating = instance.rating!
//  self.commentDateLbl.text = "US $" + "\(instance.commentDate!)"
//  self.commentLbl.text = instance.comment!
//  self.userNameLbl.text = instance.userName
}


// MARK:- Collection view delegate, data source and page controller
extension detailPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == imageSliderCollectionView {
//      print(homeService.instance.detailAr
//      return homeService.instance.detailArray[0].pic_url!.count
      return propertyImagesArray.count * dummyCount
      
    }else if collectionView == featuresCollectionView{
      
      guard let count = homeService.instance.propertyDetail.servicesArray?.count else {return 0}
      return count
        
//      }
      
      
    }else if collectionView == nearbyPlacesCollectionView{
      
            return nearbyPlacesTextArray.count
    
    }else if collectionView == demographicsCollectionView{
      
      return demographicsImagesArray.count
      
    }else {
      return homeService.instance.simlilarPropertyArray.count
    
    }

//    else {
//
//      return demographicsTextArray.count
//
//    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    if collectionView == imageSliderCollectionView {
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImagesCollectionViewCell", for: indexPath) as! DetailImagesCollectionViewCell
//      let array = homeService.instance.detailArray
//      guard indexPath.row < array.count else {return cell}
//      let instance = array[indexPath.row]
//      let nameImage = instance.pic_url
//      let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
//      let finalName = "https://storage.officedoor.ai/final/" + imageUrlEncoded!
//      print(finalName)
//      cell.propertyImagesView.sd_setImage(with: URL(string: finalName), placeholderImage: UIImage(named: "appLogo"))
//      return cell
//    }
     if collectionView == imageSliderCollectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImagesCollectionViewCell", for: indexPath) as! DetailImagesCollectionViewCell
      let imageIndex = indexPath.item % propertyImagesArray.count
      //print("imageIndex : \(imageIndex)")
      let imageUrl = URL(string: propertyImagesArray[imageIndex])
      
      cell.propertyImagesView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "appLogo"))
      
      return cell
    }else if collectionView == featuresCollectionView{
      let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCollectionViewCell", for: indexPath) as! FeaturesCollectionViewCell
      
      if let feature = homeService.instance.propertyDetail.servicesArray?[indexPath.row] {
        if indexPath.row <= homeService.instance.propertyDetail.servicesArray!.count{
          
          cell.featureImageView.sd_setImage(with: URL(string: feature.logo64px!), placeholderImage: UIImage(named: "appLogo"))
          cell.featureLbl.text = feature.ourService
          
        }

        
      }
      
      
      
//      cell.featureImageView.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "placeholder.png"))
      return cell
    }else if collectionView == nearbyPlacesCollectionView{
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyPlacesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
      cell.categoryImage.image = nearbyPlacesImagesArray[indexPath.row]
      cell.categoryLabel.text = nearbyPlacesTextArray[indexPath.row]
      return cell
      
    }else if collectionView == demographicsCollectionView{
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemographicsCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
      cell.categoryImage.image = demographicsImagesArray[indexPath.row]
      cell.categoryLabel.text = demographicsTextArray[indexPath.row]
      return cell
      
    }else {
      let cell = similarPropertiesColView.dequeueReusableCell(withReuseIdentifier: "propertyCollectionViewCell", for: indexPath) as! propertyCollectionViewCell
      cell.favDelegate = self
      let array = homeService.instance.simlilarPropertyArray
      
      guard indexPath.row < array.count else {return cell}
      let instance = array[indexPath.row]
      cell.titleLbl.text = instance.Title
      cell.locationLbl.text = instance.Address
      
      let price = instance.price!
      print(price)
      
//      let floatPrice = Float(price)
//      print(floatPrice)
      let intPrice = Int(price)
      print(intPrice)
      let largeNumber = intPrice
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber ?? 0))
      cell.priceLbl.text = "$" + formattedNumber!
      
      //          let strPrice = String(intPrice)
      
      cell.typeLbl.text = "For " + instance.postType!
      let area = instance.Area!
      print(area)
      cell.areaLbl.text = "\(area) Sqrf"
      let nameImage = instance.image
      let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
//      cell.favDelegate = self
      cell.propertyImage.sd_setImage(with: URL(string: imageUrlEncoded!), placeholderImage: UIImage(named: "appLogo"))
      return cell
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if collectionView == imageSliderCollectionView{
      
      let cell = collectionView.cellForItem(at: indexPath) as? DetailImagesCollectionViewCell
      let originImage = cell?.propertyImagesView.image // some image for baseImage
      
      let browser = SKPhotoBrowser(originImage: originImage ?? UIImage(), photos: sliderImagesArray, animatedFromView: cell!)
      browser.initializePageIndex(indexPath.row)
      present(browser, animated: true, completion: {})
      
    }else if collectionView == nearbyPlacesCollectionView{
      
      
      let selectedPlace = nearbyPlacesTextArray[indexPath.row]
      nearbyPlaceTitleLbl.text = "Nearby \(selectedPlace)s"
      let longitude = homeService.instance.propertyDetail.longitude
      let latitude = homeService.instance.propertyDetail.latitude
      let params = ["latitude" : latitude,
                    "longitude" : longitude,
                    "type" : selectedPlace]
      getNearbyPlaces(params: params as [String : Any])
      
      
    }else if collectionView == demographicsCollectionView{
      
      if indexPath.row == 0{

        self.pieChartLbl.text = "Forecast"
        let valuesArray = self.foreCastValuesArray
        self.setPieChart(dataPoints: self.forecastTextArray, values: valuesArray)
        self.showPieChartView()

      }else if indexPath.row == 1 {

        self.pieChartLbl.text = "Crime Rate"
        self.setPieChart(dataPoints: self.crimeRateTextArray, values: self.crimeRateValueArray)
        self.showPieChartView()

      }else if indexPath.row == 2 {

        self.barChartLbl.text = "Home Value"
        self.setBarChart(dataPoints: self.homeValueTextArray, values: self.homeValueNumberArray)
        self.showBarChartView()

      }else if indexPath.row == 3 {

        self.pieChartLbl.text = "Gender Ratio"
        self.setPieChart(dataPoints: self.genderDataTextArray, values: self.genderDataValuesArray)
        self.showPieChartView()


      }else if indexPath.row == 4 {

        self.barChartLbl.text = "Rent Paid by Renters"

        self.setBarChart(dataPoints: self.rentDataTextArray, values: self.rentDataValueArray)
        self.showBarChartView()

      }else if indexPath.row == 5 {

        self.barChartLbl.text = "Total Houses Built"

        self.setBarChart(dataPoints: self.housesBuiltTextArray, values: self.housesBuiltValueArray)
        self.showBarChartView()

      }else if indexPath.row == 6 {

        self.barChartLbl.text = "Household Distribution"
        self.setBarChart(dataPoints: self.householDistributionTextArray, values: self.householDistributionValueArray)
        self.showBarChartView()


      }else if indexPath.row == 7 {



      }else if indexPath.row == 8 {



      }else if indexPath.row == 9 {



      }else if indexPath.row == 10 {



      }else if indexPath.row == 11 {



      }else if indexPath.row == 12 {



      }else if indexPath.row == 13 {



      }else if indexPath.row == 14 {



      }else if indexPath.row == 15 {



      }else if indexPath.row == 16 {



      }
        //
      
    
    }else if collectionView == featuresCollectionView{
      
      
    }else {
      
      let propertyId = homeService.instance.simlilarPropertyArray[indexPath.row].id!
      let url = detailUrl + "\(String(describing: propertyId))" + "/"
      getDetailOfProperty(url: url)
      
      
      
    }
 
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if collectionView == imageSliderCollectionView {
    
     return imageSliderCollectionView.bounds.size

    }else if collectionView == similarPropertiesColView{
      let cgSize = CGSize(width: 217, height: 230)
      return cgSize
    }
    //        else {
    //            let cgSize = CGSize(width: 100, height: 100)
    //            return cgSize
    //        }
//    else if collectionView == demographicsCollectionView{
//      let size = CGSize.init(width: featuresCollectionView.frame.width / 5 - 11, height: 130 )
//      return size
//    }
    else if collectionView == demographicsCollectionView{
      if Env.iPad{
        
        let width = collectionView.frame.width / 7
         let size = CGSize.init(width: width, height: width )
        return size
        
      }else {
        
         let width = collectionView.frame.width / 4
         let size = CGSize.init(width: width, height: width )
        return size
        
      }
      
    }else if collectionView == featuresCollectionView{
      
      if Env.iPad{

        let width = UIScreen.main.bounds.width / 7
        let size = CGSize.init(width: width, height: width )
        return size

      }else {

        let width = collectionView.frame.width / 5
         let size = CGSize.init(width: width, height: width + 20)
        return size

      }
      
    }else {
      
      if Env.iPad{

        let width = UIScreen.main.bounds.width / 7
        let size = CGSize.init(width: width, height: width )
        return size

      }else {

        let width = collectionView.frame.width / 5
         let size = CGSize.init(width: width , height: width + 10)
        return size

      }

      
//      let size = CGSize.init(width: (featuresCollectionView.frame.width / 5) - 11, height: 100 )
//      return size
      
    }
   
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {

      return 1
    
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    if (scrollView == self.imageSliderCollectionView) {
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
      
      self.imageSliderCollectionView.reloadData()
      
      self.imageSliderCollectionView.setContentOffset( CGPoint.zero, animated: true)
      
      self.startTimer()
      
    }
    
    print("changed orientation")
    
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if (scrollView == self.imageSliderCollectionView) {
      stopTimer()
    }
  }
  
  // start animating the slider
  func startTimer() {
    
    //self.colVSliderImages.setContentOffset(CGPoint.zero, animated: false)
    
    if propertyImagesArray.count > 1 && scrollingTimer == nil {
      
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
    
    let offset = CGPoint(x:self.imageSliderCollectionView.contentOffset.x + cellWidth, y: self.imageSliderCollectionView.contentOffset.y)
    
    //print("setting the Calculated offset in rotate: \(offset)")
    
    var animated = true
    
    if (offset.equalTo(CGPoint.zero) || offset.equalTo(CGPoint(x: totalContentWidth, y: offset.y))){
      
      animated = false
      
    }
    
    self.imageSliderCollectionView.setContentOffset(offset, animated: animated)
    
    print("\n")
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    if (scrollView == self.imageSliderCollectionView) {
      
      self.centerIfNeeded(animationTypeAuto: true, offSetBegin: CGPoint.zero)
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if(scrollView == self.imageSliderCollectionView){
      
      if(scrollView.panGestureRecognizer.state == .began){
        
        stopTimer()
        
      }else if( scrollView.panGestureRecognizer.state == .possible){
        
        startTimer()
        
      }
      
    }
    
  }

  
  func centerIfNeeded(animationTypeAuto:Bool, offSetBegin:CGPoint) {
    
    let currentOffset = self.imageSliderCollectionView.contentOffset
    
    let contentWidth = self.totalContentWidth
    
    let width = contentWidth / CGFloat(dummyCount)
    
    //print("CurrentOffset: \(currentOffset)")
    
    //print("contentWidth: \(contentWidth)")
    
    //print("width: \(width)")
    
    if currentOffset.x < 0{
      
      //left scrolling
      
      self.imageSliderCollectionView.contentOffset = CGPoint(x: width - currentOffset.x, y: currentOffset.y)
      
    } else if (currentOffset.x + cellWidth) >= contentWidth {
      
      //right scrolling
      
      let  point = CGPoint.zero
      
      //point.x = point.x - cellWidth
      
      var tempCGPoint = point
      
      tempCGPoint.x = tempCGPoint.x + cellWidth
      
      print("center if need set offset to \( tempCGPoint)")
      
      self.imageSliderCollectionView.contentOffset = point
      
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
    if (scrollView == self.imageSliderCollectionView)
    {
      print("\(scrollView.contentOffset)")
      
      self.temp = scrollView.contentOffset
      
      self.stopTimer()
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    if(collectionView == self.imageSliderCollectionView){
      
      //print("collectionView.contentOffset.x \(collectionView.contentOffset.x)")
      
      //print("collectionView.frame.size.width\(collectionView.frame.size.width)")
      
      var page:Int =  Int(collectionView.contentOffset.x / collectionView.frame.size.width)
      
      page = page % propertyImagesArray.count
      
      //print("page = \(page)")
      
      pageControl.currentPage = Int (page)
      
    }
    
  }
  
  
  func updatePageControl(){
    
    var updatedPage = selectedPage + 1
    
    let totalItems = propertyImagesArray.count
    
    updatedPage = updatedPage % totalItems
    
    print("updatedPage: \(updatedPage)")
    
    selectedPage  = updatedPage
    
    self.pageControl.currentPage = updatedPage
    
  }
  var totalContentWidth: CGFloat {
    
    //Total width
    //return CGFloat(collectionViewImageArray.count) * cellWidth
    return CGFloat(propertyImagesArray.count * dummyCount) * cellWidth
    
  }
  var cellWidth: CGFloat {
    
    return self.imageSliderCollectionView.frame.width
    
  }
}

//MARK: UItableViewDelegate

extension detailPageViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.nearbyPlacesDataArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyPlacesTableViewCell") as! NearbyPlacesTableViewCell
    let instance = self.nearbyPlacesDataArray[indexPath.row]
    cell.addressLbl.text = instance.placeAddress
    if let distance = instance.placeDistance {
      
      cell.distanceLbl.text = String(describing: distance) + "m"
      
    }
    cell.nameLbl.text = instance.placeName
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let instance = self.nearbyPlacesDataArray[indexPath.row]
    let latitude = Double(instance.latitude!)
    let longitude = Double(instance.longitude!)
    let title = instance.placeName
    let locationDict: [String : Any] = [
      "latitude": latitude,
      "longitude": longitude,
      "title": title
      
    ]
    let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
    vc.coordinatesDict = locationDict
    present(vc, animated: true)
//    self.navigationController?.pushViewController(vc, animated: true)
  }

  
  
}
// MARK:- Setup Charts
extension detailPageViewController{
  
  private func setBarChart(dataPoints: [String], values: [Double]){
    print("dataPoints:",dataPoints, "values",values)
    barChartView.noDataText = "No data"
    
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry.init(x: Double(i), y: values[i])
      dataEntries.append(dataEntry)
    }
    print(dataEntries, "dataEntries")
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
    chartDataSet.colors = ChartColorTemplates.colorful()
    //    chartDataSet.colors = ChartColorTemplates.colorful()
    
    
    let chartData = BarChartData(dataSet: chartDataSet)
    //    chartData.barWidth = 0.5
    //    barChartView.setVisibleXRange(minXRange: 0.0, maxXRange: 5.0)
    //    let barWidth = 0.4
    //    let barSpace = 0.05
    //    let groupSpace = 0.1
    
    
    //    self.barChartView.xAxis.axisMinimum = Double(xArray[0])
    //    self.barChartView.xAxis.axisMaximum = Double(xArray[0]) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(xArray.count)
    // (0.4 + 0.05) * 2 (data set count) + 0.1 = 1
    //    data.groupBars(fromX: Double(xArray[0]), groupSpace: groupSpace, barSpace: barSpace)
    
    
    //    (xVals: homeValueTextArray, dataSet: chartDataSet)
    barChartView.data = chartData
    barChartView.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuad)
    
    // Do any additional setup after loading the view.
    //    let xArray = homeValueDataArray(1..<10)
    //    let ys1 = xArray.map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
    //    let ys2 = xArray.map { x in return cos(Double(x) / 2.0 / 3.141) }
    
    //    let xValues = homeValueDataArray.enumerated().map { index, element in
    //      return element.valuesDetail
    //    }
    //
    //    let yValues = homeValueDataArray.enumerated().map { index, element in
    //      return BarChartDataEntry(value: Double(element.noOfHouses), xIndex: index)
    //    }
    //
    //    let dataSet = BarChartDataSet(yVals: yValues, label: "Pizzas Sales")
    //    let data = BarChartData(xVals: xValues, dataSet: dataSet)
    //
    ////    let chartView = BarChartView(frame: view.frame)
    //    barChartView.data = data
    
    //    let yse1 = homeValueDataArray.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
    //    let yse2 = ys2.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
    //
    //    let data = BarChartData()
    //    let ds1 = BarChartDataSet(entries: yse1, label: "Hello")
    //    ds1.colors = [NSUIColor.red, NSUIColor.green]
    //    data.addDataSet(ds1)
    //
    //    let ds2 = BarChartDataSet(entries: yse2, label: "World")
    //    ds2.colors = [NSUIColor.blue]
    //    data.addDataSet(ds2)
    //
    //    let barWidth = 0.4
    //    let barSpace = 0.05
    //    let groupSpace = 0.1
    //
    //    data.barWidth = barWidth
    //    self.barChartView.xAxis.axisMinimum = Double(xArray[0])
    //    self.barChartView.xAxis.axisMaximum = Double(xArray[0]) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(xArray.count)
    //    // (0.4 + 0.05) * 2 (data set count) + 0.1 = 1
    //    data.groupBars(fromX: Double(xArray[0]), groupSpace: groupSpace, barSpace: barSpace)
    //
    //    self.barChartView.data = data
    
    //    self.barChartView.gridBackgroundColor = NSUIColor.white
    
    //    self.barChartView.chartDescription?.text = "Barchart Demo"
  }

  
  private func setPieChart(dataPoints: [String], values: [Double]){
    
    pieChartView.chartDescription?.enabled = false
    pieChartView.drawHoleEnabled = true
    pieChartView.rotationEnabled = true
    pieChartView.isUserInteractionEnabled = true
    var displayedData: [ChartDataEntry] = []
    for i in 0..<values.count {
      let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
      displayedData.append(dataEntry1)
    }
    let pieChartDataSet = PieChartDataSet(entries: displayedData, label: "")
    pieChartDataSet.colors = .init(repeating: .red, count: displayedData.count)
    let pieChartData = PieChartData(dataSet: pieChartDataSet)
    pieChartView.data = pieChartData
    pieChartView.animate(xAxisDuration: 1.0)
    
    
    //Pie chart data color
    var colors: [UIColor] = []
    for _ in 0..<dataPoints.count {
      let black = Double(arc4random_uniform(256))
      let red = Double(arc4random_uniform(256))
      let blue = Double(arc4random_uniform(256))
      let color = UIColor(red: CGFloat(black/255), green: CGFloat(red/255), blue: CGFloat(blue/255), alpha: 1)
      colors.append(color)
    }
    pieChartDataSet.colors = colors
  }

  
  
}

//extension detailPageViewController: PropertyCellDelegate{
//
//
//  func toggleFavorite(flag: Bool, index: Int, sender: UIButton) {
//
//
//    let array = homeService.instance.simlilarPropertyArray
//    guard let propertyId = array[index].id else {return}
//    if flag{
//
//      mainService.instance.removeFromFavourites(propertyId: String(describing: propertyId) ){ (success, isRemoved) in
//
//        if success{
//          if isRemoved {
//
//            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
//            homeService.instance.simlilarPropertyArray.isFavourite = false
//            self.setSelectedArray(array: array!)
//
//          }else {
//
//
//
//          }
//
//        }else {
//
//          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
//
//        }
//
//      }
//
//    }else {
//
//      mainService.instance.addToFavourites(propertyId: String(describing: propertyId)){ (success, isAdded) in
//
//        if success{
//          if isAdded {
//
//            sender.setImage(UIImage(named: "filledHeart"), for: .normal)
//            array![index].isFavourite = true
//            self.setSelectedArray(array: array!)
//            //            showSwiftMessageWithParams(theme: .success, title: "Success", body: "Property added to favorites")
//
//          }else {
//
//
//
//          }
//
//        }else {
//
//          showSwiftMessageWithParams(theme: .error, title: "Error", body: "Something went wrong")
//
//        }
//
//      }
//
//    }
//    //    print("array![index].isFavourite: ",array![index].isFavourite)
//    //    setSelectedArray(array: array!)
//    //    print("getSelectedArray()![index].isFavourite: ",getSelectedArray()![index].isFavourite)
//
//
//  }
//
//}


extension detailPageViewController: PropertyCellDelegate{
  
  
  func toggleFavorite(flag: Bool, index: Int, sender: UIButton) {
    
    
    var array = homeService.instance.simlilarPropertyArray
    guard let propertyId = array[index].id else {return}
    if flag{
      
      mainService.instance.removeFromFavourites(propertyId: String(describing: propertyId) ){ (success, isRemoved) in
        
        if success{
          if isRemoved {
            
            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)
            array[index].isFavourite = false
            homeService.instance.simlilarPropertyArray.removeAll()
            homeService.instance.simlilarPropertyArray.append(contentsOf: array)
//            self.setSelectedArray(array: array!)
            
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
            array[index].isFavourite = true
            homeService.instance.simlilarPropertyArray.removeAll()
            homeService.instance.simlilarPropertyArray.append(contentsOf: array)
//            self.setSelectedArray(array: array!)
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
