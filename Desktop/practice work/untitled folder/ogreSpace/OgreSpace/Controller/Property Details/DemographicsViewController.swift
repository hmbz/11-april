////
////  DemographicsViewController.swift
////  OgreSpace
////
////  Created by admin on 9/6/19.
////  Copyright © 2019 brainplow. All rights reserved.
////
//
//import UIKit
//import Charts
//
//class DemographicsViewController: UIViewController {
//
//  //MARK: IBOutlets
//  
//  @IBOutlet weak var demographicsAspectsCV: UICollectionView!
//  @IBOutlet weak var nearbyPlacesTableView: UITableView!
//  
//  @IBOutlet weak var barChartView: LineChartView!
//  @IBOutlet weak var pieChartView: PieChartView!
//  
//  //MARK: Properties
//  
//  let demographicsTextArray = ["Forecast", "Crime Rate", "Home Value", "Gender Ratio", "Rent paid by renters", "Total houses built", "Household distribution"]
////    , "Population", "Population Change Detail", "Population by occupation", "Education", "Occupied houses according to population", "Public transportation Detail", "Economy", "Property detail"
//  
//  let demographicsImagesArray = [UIImage(named: "forecast"), UIImage(named: "crime_det"), UIImage(named: "house_permits"),UIImage(named: "gender"), UIImage(named: "rent_paid"), UIImage(named: "house_build"), UIImage(named: "house_owners")]
////    , UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners"), UIImage(named: "house_owners")]
//  
//  let nearbyPlacesTextArray = ["Coffee", "Park", "Hospital", "School", "Airport", "Police", "Cinema", "Mall", "Hotel", "Metro Station", "Playground", "Subway", "Railway"]
//  let nearbyPlacesImagesArray: [UIImage] = [#imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "Parking"), #imageLiteral(resourceName: "Hospital"), #imageLiteral(resourceName: "Education"), #imageLiteral(resourceName: "Airport"), #imageLiteral(resourceName: "Police"), #imageLiteral(resourceName: "Cinema"), #imageLiteral(resourceName: "Mall"), #imageLiteral(resourceName: "Hotel"), #imageLiteral(resourceName: "Metrostation"), #imageLiteral(resourceName: "Playground"), #imageLiteral(resourceName: "Subway"), #imageLiteral(resourceName: "Railway")]
//  
//  var crimeRateTextArray = [String]()
//  var crimeRateValueArray = [Double]()
//  
//  var homeValueTextArray = [String]()
//  var homeValueNumberArray = [Double]()
//  
//  var rentDataTextArray = [String]()
//  var rentDataValueArray = [Double]()
//  
//  var housesBuiltTextArray = [String]()
//  var housesBuiltValueArray = [Double]()
//  
//  var householDistributionTextArray = [String]()
//  var householDistributionValueArray = [Double]()
//  
//  var genderDataValuesArray = [Double]()
//  var genderDataTextArray = ["Age under 5", "Age under 18", "Age above 65", "Male Population", "Female Population", "White Population", "Black Population", "Other Population"]
//  
//  var months = [String]()
//  var unitsSold = [Double]()
//  let forecastTextArray = ["Forecast 2017", "Forecast 2018", "Forecast 2019", "Forecast 2020"]
//  
//  
//  var flagDemoGraphics = false
//  var zipCode = ""
//  
//  let titleview = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)?.first as! TopView
//  
//    //MARK: View Life Cycle
//  
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      addTopBar()
//      
//      demographicsAspectsCV.delegate = self
//      demographicsAspectsCV.dataSource = self
//      
//      nearbyPlacesTableView.delegate = self
//      nearbyPlacesTableView.dataSource = self
//      
//      demographicsAspectsCV.addShadow()
//      
//      if flagDemoGraphics{
//        
//        nearbyPlacesTableView.isHidden = true
//        getDemographicsData(zipcode: zipCode)
//        
//        
//      }else {
//        
//        barChartView.isHidden = true
//        pieChartView.isHidden = true
//        let selectedPlace = nearbyPlacesTextArray[0]
//        titleview.searchBtn.setTitle("Nearby Coffees", for: .normal)
//        let longitude = homeService.instance.propertyDetail.longitude
//        let latitude = homeService.instance.propertyDetail.latitude
//        let params = ["latitude" : latitude,
//                      "longitude" : longitude,
//                      "type" : selectedPlace]
//        
//        getNearbyPlaces(params: params as [String : Any])
//        
//      }
//
//    }
//
//  private func addTopBar() {
//    
//    
//    self.navigationItem.titleView = titleview
//    titleview.filterBtn.removeFromSuperview()
//    titleview.notificationBtn.removeFromSuperview()
//    titleview.searchBtn.isUserInteractionEnabled = false
//    titleview.micBtn.setImage(UIImage(named: "ShareGray"), for: .normal)
//    titleview.micBtn.addTarget(self, action: #selector(shareBtnTapped(sender:)), for: .touchUpInside)
//    titleview.iconBtn.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
//    titleview.searchBtn.setTitle("Property Detail", for: .normal)
//    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
//    titleview.pizzaMEnu.setImage(UIImage(named: "grayBack"), for: .normal)
//    titleview.pizzaMEnu.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
//    
//    self.navigationItem.hidesBackButton = true
//  }
//  
//  
//  @objc func shareBtnTapped(sender: UIButton) {
//    
//    dismiss(animated: false, completion: nil)
//    
//  }
//  
//  @objc private func pizzaMenuTapped(_ sender: UIButton) {
//    
//    dismiss(animated: false, completion: nil)
//  }
//
////  @objc private func backButtonPressed(){
////
////    dismiss(animated: true, completion: nil)
////
////  }
//  
//  private func setChart(dataPoints: [String], values: [Double]){
//    
//    pieChartView.chartDescription?.enabled = false
//    pieChartView.drawHoleEnabled = true
//    pieChartView.rotationEnabled = true
//    pieChartView.isUserInteractionEnabled = true
//    var displayedData: [ChartDataEntry] = []
//    for i in 0..<values.count {
//      let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
//      displayedData.append(dataEntry1)
//    }
//    let pieChartDataSet = PieChartDataSet(entries: displayedData, label: "")
//    pieChartDataSet.colors = .init(repeating: .red, count: displayedData.count)
//    let pieChartData = PieChartData(dataSet: pieChartDataSet)
//    pieChartView.data = pieChartData
//    pieChartView.animate(xAxisDuration: 1.0)
//    
//    
//    //Pie chart data color
//    var colors: [UIColor] = []
//    for _ in 0..<dataPoints.count {
//      let black = Double(arc4random_uniform(256))
//      let red = Double(arc4random_uniform(256))
//      let blue = Double(arc4random_uniform(256))
//      let color = UIColor(red: CGFloat(black/255), green: CGFloat(red/255), blue: CGFloat(blue/255), alpha: 1)
//      colors.append(color)
//    }
//    pieChartDataSet.colors = colors
//  }
//  
//  
//  
//  private func setBarChart(dataPoints: [String], values: [Double]){
//    print("dataPoints:",dataPoints, "values",values)
//    barChartView.noDataText = "No data"
//    
//    var dataEntries: [BarChartDataEntry] = []
//    
//    for i in 0..<dataPoints.count {
//      let dataEntry = BarChartDataEntry.init(x: Double(i), y: values[i])
//      dataEntries.append(dataEntry)
//    }
//    print(dataEntries, "dataEntries")
//    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "No of houses sold")
////    chartDataSet.colors = ChartColorTemplates.colorful()
//    
//    
//    let chartData = BarChartData(dataSet: chartDataSet)
////    chartData.barWidth = 0.5
////    barChartView.setVisibleXRange(minXRange: 0.0, maxXRange: 5.0)
////    let barWidth = 0.4
////    let barSpace = 0.05
////    let groupSpace = 0.1
//    
//    
////    self.barChartView.xAxis.axisMinimum = Double(xArray[0])
////    self.barChartView.xAxis.axisMaximum = Double(xArray[0]) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(xArray.count)
//    // (0.4 + 0.05) * 2 (data set count) + 0.1 = 1
////    data.groupBars(fromX: Double(xArray[0]), groupSpace: groupSpace, barSpace: barSpace)
//
//    
////    (xVals: homeValueTextArray, dataSet: chartDataSet)
//    barChartView.data = chartData
//    barChartView.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuad)
//    
//    // Do any additional setup after loading the view.
////    let xArray = homeValueDataArray(1..<10)
////    let ys1 = xArray.map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
////    let ys2 = xArray.map { x in return cos(Double(x) / 2.0 / 3.141) }
//    
////    let xValues = homeValueDataArray.enumerated().map { index, element in
////      return element.valuesDetail
////    }
////
////    let yValues = homeValueDataArray.enumerated().map { index, element in
////      return BarChartDataEntry(value: Double(element.noOfHouses), xIndex: index)
////    }
////
////    let dataSet = BarChartDataSet(yVals: yValues, label: "Pizzas Sales")
////    let data = BarChartData(xVals: xValues, dataSet: dataSet)
////
//////    let chartView = BarChartView(frame: view.frame)
////    barChartView.data = data
//    
////    let yse1 = homeValueDataArray.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
////    let yse2 = ys2.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
////
////    let data = BarChartData()
////    let ds1 = BarChartDataSet(entries: yse1, label: "Hello")
////    ds1.colors = [NSUIColor.red, NSUIColor.green]
////    data.addDataSet(ds1)
////
////    let ds2 = BarChartDataSet(entries: yse2, label: "World")
////    ds2.colors = [NSUIColor.blue]
////    data.addDataSet(ds2)
////
////    let barWidth = 0.4
////    let barSpace = 0.05
////    let groupSpace = 0.1
////
////    data.barWidth = barWidth
////    self.barChartView.xAxis.axisMinimum = Double(xArray[0])
////    self.barChartView.xAxis.axisMaximum = Double(xArray[0]) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(xArray.count)
////    // (0.4 + 0.05) * 2 (data set count) + 0.1 = 1
////    data.groupBars(fromX: Double(xArray[0]), groupSpace: groupSpace, barSpace: barSpace)
////
////    self.barChartView.data = data
//    
////    self.barChartView.gridBackgroundColor = NSUIColor.white
//    
////    self.barChartView.chartDescription?.text = "Barchart Demo"
//  }
//  
//  private func getNearbyPlaces(params: [String: Any]){
//    print(params)
//    DetailPageService.instance.getNearByPlaces(params: params){ success in
//      if success{
//        
//        self.nearbyPlacesTableView.reloadData()
//        
//      }
//      else{
//        let status = homeService.instance.status
//        print(status)
//        
//      }
//    }
//  }
//  
//  private func getDemographicsData(zipcode: String){
//  
//    DetailPageService.instance.getDemograhics(zipcode: zipcode){ success in
//      if success{
//        
//        self.titleview.searchBtn.setTitle("Forecast", for: .normal)
//        let valuesArray = DetailPageService.instance.forecastValuesArray
//        self.setChart(dataPoints: self.forecastTextArray, values: valuesArray)
//        
//        let crimeDataArray = DetailPageService.instance.crimeRateArray
//        var index = 0
//        for  name in crimeDataArray {
//          let name = crimeDataArray[index].crimeTitle
//          guard let unit = crimeDataArray[index].crimeCount else {return}
//          self.crimeRateTextArray.append(name ?? "nil")
//          self.crimeRateValueArray.append(Double(unit))
//          index = index + 1
//          
//        }
//        
//        let homeValueArray = DetailPageService.instance.homeValueArray
//        for item in homeValueArray{
//          
//          self.homeValueTextArray.append(item.valuesDetail!)
//          self.homeValueNumberArray.append(Double(item.noOfHouses!))
//          
//        }
//        
//        let genderArray = DetailPageService.instance.genderDataArray
//        let genderDataInstance = genderArray[0]
//        self.genderDataValuesArray.append(genderDataInstance.under5Population!)
//        self.genderDataValuesArray.append(genderDataInstance.under18Population!)
//        self.genderDataValuesArray.append(genderDataInstance.above65Population!)
//        self.genderDataValuesArray.append(genderDataInstance.malePopulation!)
//        self.genderDataValuesArray.append(genderDataInstance.femalePopulation!)
//       self.genderDataValuesArray.append(genderDataInstance.whitePopulation!)
//        self.genderDataValuesArray.append(genderDataInstance.blackPopulation!)
//        self.genderDataValuesArray.append(genderDataInstance.othersPopulation!)
//        
//        
//        let rentPaidDataArray = DetailPageService.instance.rentDataArray
//        for item in rentPaidDataArray{
//          
//          self.rentDataTextArray.append(item.priceDetail!)
//          self.rentDataValueArray.append(Double(item.noOfPayers!))
//          
//        }
//        
//        let housesBuiltDataArray = DetailPageService.instance.totalHousesBuiltArray
//        for item in housesBuiltDataArray{
//          
//          self.housesBuiltTextArray.append(item.year!)
//          self.housesBuiltValueArray.append(Double(item.noOfHouses!))
//          
//        }
//        
//        let householdDataArray = DetailPageService.instance.householDistributionArray
//        for item in householdDataArray{
//          
//          self.householDistributionTextArray.append(item.incomeDistribution!)
//          self.householDistributionValueArray.append(Double(item.noOfHouses!))
//          
//        }
//        
//        
////        var homeValueIndex = 0
////        for  name in homeValueDataArray {
////          let name = homeValueDataArray[index].valuesDetail
////          guard let unit = homeValueDataArray[index].noOfHouses else {return}
////          self.homeValueDataArray.append(name ?? "nil")
//////          self.homeValueDataArray.append(Double(unit))
////          homeValueIndex = homeValueIndex + 1
////
////        }
//        
//        
//        
//        
//      }
//      else{
//        let status = homeService.instance.status
//        print(status)
//        
//      }
//    }
//  }
//  
//}
//
//extension DemographicsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    if flagDemoGraphics{
//      
//      return demographicsTextArray.count
//      
//    }else {
//      
//      return nearbyPlacesTextArray.count
//      
//    }
//    
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = demographicsAspectsCV.dequeueReusableCell(withReuseIdentifier: "DemographicsCollectionViewCell", for: indexPath) as! DemographicsCollectionViewCell
//    if flagDemoGraphics{
//      
//      cell.categoryImage.image = demographicsImagesArray[indexPath.row]
//      cell.categoryLabel.text = demographicsTextArray[indexPath.row]
//      
//    }else {
//      
//      cell.categoryImage.image = nearbyPlacesImagesArray[indexPath.row]
//      cell.categoryLabel.text = nearbyPlacesTextArray[indexPath.row]
//      
//    }
//    
//    return cell
//    
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    
//    if flagDemoGraphics {
//
//      if indexPath.row == 0{
//        
//        titleview.searchBtn.setTitle("Forecast", for: .normal)
//        let valuesArray = DetailPageService.instance.forecastValuesArray
//        self.barChartView.isHidden = true
//        self.pieChartView.isHidden = false
//        self.setChart(dataPoints: self.forecastTextArray, values: valuesArray)
//        
//      }else if indexPath.row == 1 {
//
//        titleview.searchBtn.setTitle("Crime Rate", for: .normal)
//        self.pieChartView.isHidden = false
//        self.barChartView.isHidden = true
//        self.setChart(dataPoints: self.crimeRateTextArray, values: self.crimeRateValueArray)
//        
//      }else if indexPath.row == 2 {
//        
//        titleview.searchBtn.setTitle("Home Value", for: .normal)
//        
//        self.pieChartView.isHidden = true
//        self.barChartView.isHidden = false
//        
//        
//        self.setBarChart(dataPoints: self.homeValueTextArray, values: self.homeValueNumberArray)
//        
//      }else if indexPath.row == 3 {
//        
//        titleview.searchBtn.setTitle("Gender Ratio", for: .normal)
//        
//        self.pieChartView.isHidden = false
//        self.barChartView.isHidden = true
//        
//        
//        self.setChart(dataPoints: self.genderDataTextArray, values: self.genderDataValuesArray)
//        
//        
//      }else if indexPath.row == 4 {
//        
//        titleview.searchBtn.setTitle("Rent Paid by Renters", for: .normal)
//        
//        self.pieChartView.isHidden = true
//        self.barChartView.isHidden = false
//        
//        
//        self.setBarChart(dataPoints: self.rentDataTextArray, values: self.rentDataValueArray)
//        
//      }else if indexPath.row == 5 {
//        
//        titleview.searchBtn.setTitle("Total Houses Built", for: .normal)
//        
//        self.pieChartView.isHidden = true
//        self.barChartView.isHidden = false
//        
//        
//        self.setBarChart(dataPoints: self.housesBuiltTextArray, values: self.housesBuiltValueArray)
//        
//      }else if indexPath.row == 6 {
//        
//        titleview.searchBtn.setTitle("Household Distribution", for: .normal)
//        
//        self.pieChartView.isHidden = true
//        self.barChartView.isHidden = false
//        
//        
//        self.setBarChart(dataPoints: self.householDistributionTextArray, values: self.householDistributionValueArray)
//        
//        
//      }else if indexPath.row == 7 {
//        
//        
//        
//      }else if indexPath.row == 8 {
//        
//        
//        
//      }else if indexPath.row == 9 {
//        
//        
//        
//      }else if indexPath.row == 10 {
//        
//        
//        
//      }else if indexPath.row == 11 {
//        
//        
//        
//      }else if indexPath.row == 12 {
//        
//        
//        
//      }else if indexPath.row == 13 {
//        
//        
//        
//      }else if indexPath.row == 14 {
//        
//        
//        
//      }else if indexPath.row == 15 {
//        
//        
//        
//      }else if indexPath.row == 16 {
//        
//        
//        
//      }
//
//    }else {
//      
//      let selectedPlace = nearbyPlacesTextArray[indexPath.row]
//      titleview.searchBtn.setTitle("Nearby \(selectedPlace)s", for: .normal)
//      let longitude = homeService.instance.propertyDetail.longitude
//      let latitude = homeService.instance.propertyDetail.latitude
//      let params = ["latitude" : latitude,
//                    "longitude" : longitude,
//                    "type" : selectedPlace]
//      getNearbyPlaces(params: params as [String : Any])
//      
//    }
//    
//    
//    
//  }
//  
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    let size = CGSize.init(width: 80, height: 70 )
//    return size
//
//
//  }
//  
//}
//
////MARK: UItableViewDelegate
//
//extension DemographicsViewController: UITableViewDelegate, UITableViewDataSource {
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return DetailPageService.instance.nearbyPlacesArray.count
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyPlacesTableViewCell") as! NearbyPlacesTableViewCell
//    let instance = DetailPageService.instance.nearbyPlacesArray[indexPath.row]
//    cell.addressLbl.text = instance.placeAddress
//    if let distance = instance.placeDistance {
//
//      cell.distanceLbl.text = String(describing: distance) + "m"
//
//    }
//    cell.nameLbl.text = instance.placeName
//    return cell
//  }
//
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//    let instance = DetailPageService.instance.nearbyPlacesArray[indexPath.row]
//    let latitude = Double(instance.latitude!)
//    let longitude = Double(instance.longitude!)
//    let title = instance.placeName
//    let locationDict: [String : Any] = [
//      "latitude": latitude,
//      "longitude": longitude,
//      "title": title
//      
//      ]
//    let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//    vc.coordinatesDict = locationDict
//    self.navigationController?.pushViewController(vc, animated: true)
//  }
//  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 130
//  }
//  
//  
//}
