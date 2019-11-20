//
//  CadDataViewController.swift
//  OgreSpace
//
//  Created by admin on 11/7/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class CadDataViewController: UIViewController {
  
  //MARK: IBOutlets
  
  @IBOutlet weak var geographicIdLbl: UILabel!
  @IBOutlet weak var govtIdLbl: UILabel!
  @IBOutlet weak var legalDescriptionLbl: UILabel!
  @IBOutlet weak var propertyAddressLbl: UILabel!
  @IBOutlet weak var improvedAreaLbl: UILabel!
  @IBOutlet weak var propertyTypeLbl: UILabel!
  @IBOutlet weak var subDivisionLbl: UILabel!
  @IBOutlet weak var taxAgentLbl: UILabel!
  @IBOutlet weak var exemptionLbl: UILabel!
  @IBOutlet weak var ownerIdLbl: UILabel!
  @IBOutlet weak var OwnerNameLbl: UILabel!
  @IBOutlet weak var mailingAddressLbl: UILabel!
  @IBOutlet weak var ownershipPercentLbl: UILabel!
  
  @IBOutlet weak var propertyValueCollectionView: UICollectionView!
  @IBOutlet weak var salesCollectionView: UICollectionView!
  @IBOutlet weak var improvementHistoryCollectionview: UICollectionView!
  @IBOutlet weak var taxCollectionView: UICollectionView!
  
  @IBOutlet weak var valueCVHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var salesCVHeightConstraint: NSLayoutConstraint!
//  @IBOutlet weak var improvementHistoryCVHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var taxCollectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var improvementHistoryCVHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var noDataView: UIView!
  //  @IBOutlet weak var cadCollectionView: UICollectionView!
  //  @IBOutlet weak var cadDataTable: UITableView!
  
  //MARK: Properties
  lazy var propertyId = -1
  var cadData: CadDataModel?
  let titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
  
  //MARK: View Life Cycle
  
    override func viewDidLoad() {
      
      super.viewDidLoad()
      getPropertyInfoAPI()
      setupViews()
//      cadCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
  
  //MARK: Setup Views
  
  private func setupViews(){
    
    propertyValueCollectionView.delegate = self
    propertyValueCollectionView.dataSource = self
    
    salesCollectionView.delegate = self
    salesCollectionView.dataSource = self
    
    improvementHistoryCollectionview.delegate = self
    improvementHistoryCollectionview.dataSource = self
    
    taxCollectionView.delegate = self
    taxCollectionView.dataSource = self
    self.toggleNoDataView(flag: true)
    addTopBar()
    
    //let width = view.frame.width
   // let layout = propertyValueCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //layout.itemSize = CGSize(width: 700, height: 100)
    
  }
  
  //MARK: Private Functions
  
  private func loadDataInViews(data: CadDataModel){
    
    self.geographicIdLbl.text = data.buildingAndLotData?.geoId
    self.govtIdLbl.text = data.buildingAndLotData?.govId
    self.legalDescriptionLbl.text = data.buildingAndLotData?.legalDiscription
    self.propertyAddressLbl.text = data.buildingAndLotData?.propertyAddress
    self.improvedAreaLbl.text = String(describing: data.buildingAndLotData?.improvedArea)
    self.propertyTypeLbl.text = data.buildingAndLotData?.propertyType
    self.subDivisionLbl.text = data.buildingAndLotData?.subDivision
    self.taxAgentLbl.text = data.buildingAndLotData?.taxAgent
    self.exemptionLbl.text = data.ownershipData?[0].exemption
    self.ownerIdLbl.text = data.ownershipData?[0].ownerId
    self.OwnerNameLbl.text = data.ownershipData?[0].ownerName
    self.mailingAddressLbl.text = data.ownershipData?[0].mailingAddress
    self.ownershipPercentLbl.text = String(describing: data.ownershipData?[0].ownershipPercent)
    
  }
  
  //MARK: Add Top Bar
    
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    titleview.titleLbl.text = "360-Degree Property Information"
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
    dismiss(animated: true, completion: nil)
  }
  // going back directly towards the home
  @objc func homeBtnTapped(sender: UIButton) {
    print("Home Button Tapped")
    dismiss(animated: true, completion: nil)
  }
  
  // setting the topbar View Height
  override func viewLayoutMarginsDidChange() {
    titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
    print("titleview width = \(titleview.frame.width)")
  }

  //MARK: API Calls
  
  private func getPropertyInfoAPI(){
    
    if propertyId == -1{
      
      print("property id not found")
      
    }else {
      
//      let url = cadUrl + "\(propertyId)/"
      let url = cadUrl + "8293/"
      let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
      let header = [
        
        "Authorization":"JWT " + token
      ]
      print(header, "headers")
      Networking.instance.getApiCall(url: url, header: header){ (responseData, error, statusCode) in
        
        if error == nil && statusCode == 200{
          
          guard let responseDict = responseData.dictionary else {return}
//          guard let result = responseData["results"].string else { return }
          guard let id = responseDict["id"]?.int else {return}
          guard let propertyInfo = responseDict["property_info"]?.array else {return}
          var propertyInfoArray = [OwnershipModel]()
          for item in propertyInfo{
            
            guard let propertyDict = item.dictionary else {return}
            
            guard let propId = propertyDict["id"]?.int32 else {return}
            guard let ownerId = propertyDict["owner_id"]?.string else {return}
            guard let ownerName = propertyDict["owner_name"]?.string else {return}
            guard let exemption = propertyDict["exemption"]?.string else {return}
            guard let ownershipPercent = propertyDict["ownership_percent"]?.int else {return}
            guard let mailingAddress = propertyDict["mailing_address"]?.string else {return}
            guard let propInfo = propertyDict["property_info"]?.int32 else {return}
            let propertyInfoInstance = OwnershipModel(propId: propId, ownerId: ownerId, ownerName: ownerName, exemption: exemption, ownershipPercent: ownershipPercent, mailingAddress: mailingAddress, propertyInfo: propInfo)
            propertyInfoArray.append(propertyInfoInstance)
//            guard let propId = propertyDict["id"]?.int else {return}
//            "id": 396356,
//            "owner_id": "1006472",
//            "owner_name": "7250 North Dallas Parkway Texas LLC C/O Intercontinental Real Estate Corporation",
//            "exemption": "None",
//            "ownership_percent": 100,
//            "mailing_address": "1270 Soldiers Field RdBrighton, MA  02135-1003",
//            "property_info": 396350
            
          }
          
          guard let propertyValueArray = responseDict["value"]?.array else {return}
          var valueDataArray = [PropertyValueModel]()
          for item in propertyValueArray{
            
            guard let valueDict = item.dictionary else {return}
            guard let valueId = valueDict["id"]?.int32 else {return}
            guard let valueYear = valueDict["year"]?.string else {return}
            guard let improvementvalue = valueDict["improvement_value"]?.int32 else {return}
            guard let landValue = valueDict["land_value"]?.int32 else {return}
            guard let marketValue = valueDict["markete_value"]?.int32 else {return}
            guard let appraisedValue = valueDict["appraised_value"]?.int32 else {return}
            guard let assessedValue = valueDict["assessed_value"]?.int32 else {return}
            guard let propertyInform = valueDict["property_inform"]?.int32 else {return}
            
            let valueDataInstance = PropertyValueModel(valueId: valueId, valueYear: valueYear, improvValue: improvementvalue, landValue: landValue, marketValue: marketValue, appraisedValue: appraisedValue, assessedValue: assessedValue, propertyInform: propertyInform)
            valueDataArray.append(valueDataInstance)
//            "id": 6163449,
//            "year": "2019",
//            "improvement_value": 130530469,
//            "land_value": 6469531,
//            "markete_value": 137000000,
//            "appraised_value": 137000000,
//            "assessed_value": 137000000,
//            "property_inform": 396350
            
          }
          

          guard let propertyImprovementsArray = responseDict["improvements"]?.array else {return}
          var improvementDataArray = [ImprovementHistoryModel]()
          for item in propertyImprovementsArray{
            
            guard let improvementDict = item.dictionary else {return}
            guard let improvementId = improvementDict["id"]?.int32 else {return}
            guard let improvementNo = improvementDict["improv_no"]?.string else {return}
            guard let improvementType = improvementDict["improv_type"]?.string else {return}
            guard let spaceOfImprovements = improvementDict["space_of_improvements"]?.string else {return}
            guard let yearOfImprovements = improvementDict["year_of_improvements"]?.string else {return}
            guard let areaOfImprovements = improvementDict["area_of_improvements"]?.string else {return}
            let improvementValue = improvementDict["improvement_value"]?.int32
            guard let propertyInfo = improvementDict["property_info"]?.int32 else {return}
            let improvementInstance = ImprovementHistoryModel(historyId: improvementId, improvType: improvementType, spaceOfImprov: spaceOfImprovements, yearOfImprov: yearOfImprovements, areaOfImprov: areaOfImprovements, improvNo: improvementNo, improvValue: improvementValue, propertyInfo: propertyInfo)
            improvementDataArray.append(improvementInstance)
//            "id": 559918,
//            "improv_no": "Improvement #2",
//            "improv_type": "Commercial",
//            "space_of_improvements": "PG - Parking Garage",
//            "year_of_improvements": "2013",
//            "area_of_improvements": "386502",
//            "improvement_value": null,
//            "property_info": 396350
            
          }
          

          guard let ownerDetailArray = responseDict["owner_detail"]?.array else {return}
          var salesDataArray = [SalesModel]()
          for item in ownerDetailArray{
            
            guard let ownerDetailDict = item.dictionary else {return}
            guard let ownerDetailId = ownerDetailDict["id"]?.int32 else {return}
            guard let deedDate = ownerDetailDict["deed_date"]?.string else {return}
            guard let sellerName = ownerDetailDict["Seller_name"]?.string else {return}
            guard let buyerName = ownerDetailDict["Buyer_name"]?.string else {return}
            guard let instructionNo = ownerDetailDict["instruction_no"]?.string else {return}
            guard let propInfo = ownerDetailDict["property_info"]?.int32 else {return}

            let salesInstance = SalesModel(salesId: ownerDetailId, deedDate: deedDate, sellerName: sellerName, buyerName: buyerName, instructionNo: instructionNo, propertyInfo: propInfo)
            salesDataArray.append(salesInstance)
//            "id": 1445511,
//            "deed_date": "2016-10-03",
//            "Seller_name": "TC/P LEGACY TOWER I LLC",
//            "Buyer_name": "7250 NORTH DALLAS PARKWAY TEXAS LLC",
//            "instruction_no": "20161004001336740",
//            "property_info": 396350
            
          }
          

          guard let taxArray = responseDict["propert"]?.array else {return}
          var taxDataArray = [TaxModel]()
          for item in taxArray{
            
            guard let taxDict = item.dictionary else {return}
            guard let taxId = taxDict["id"]?.int32 else {return}
            guard let taxingEntity = taxDict["taxing_entity"]?.string else {return}
            guard let taxRate = taxDict["taxrate"]?.float else {return}
            guard let collectedCo = taxDict["collected"]?.string else {return}
            guard let propInfo = taxDict["property_informa"]?.int32 else {return}

            let taxInstance = TaxModel(taxId: taxId, taxEntity: taxingEntity, collectingEntity: collectedCo, taxRate: taxRate, propertyInfo: propInfo)
            taxDataArray.append(taxInstance)
//            "id": 1741384,
//            "taxing_entity": "SPL (Plano ISD)",
//            "taxrate": 1.3373502019,
//            "collected": "Collin County Tax Office",
//            "property_informa": 396350
            
          }
          
          guard let proLink = responseDict["pro_link"]?.string else {return}
          guard let govId = responseDict["gov_id"]?.string else {return}
          guard let geoId = responseDict["geo_graphic_id"]?.string else {return}
          guard let propAddress = responseDict["property_address"]?.string else {return}
          guard let landArea = responseDict["land_area"]?.int32 else {return}
          guard let improvedArea = responseDict["improved_area"]?.int32 else {return}
          guard let subDivisions = responseDict["subdivisions"]?.string else {return}
          guard let legalDesc = responseDict["legal_desc"]?.string else {return}
          guard let taxAgent = responseDict["tax_agent"]?.string else {return}
          guard let docs = responseDict["docs"]?.string else {return}
          guard let propType = responseDict["property_type"]?.string else {return}
          let state = responseDict["state"] as? String
          let city = responseDict["city"] as? String
          let zipCode = responseDict["zipcode"] as? String
          
          let buildingDataInstance = BuildingAndLotModel(geoId: geoId, govId: govId, legalDiscription: legalDesc, propertyAddress: propAddress, landArea: landArea, improvedArea: improvedArea, propertyType: propType, subDivision: subDivisions, taxAgent: taxAgent, state: state, city: city, zipCode: zipCode)
          let docsDataInstance = DocumentsAndFilesModel(proLink: proLink, docsLink: docs)
          
          
          let cadData = CadDataModel(buildingAndLotData: buildingDataInstance, salesData: salesDataArray, ownershipData: propertyInfoArray, improvementHistoryData: improvementDataArray, propertyValueData: valueDataArray, taxData: taxDataArray, documentsData: docsDataInstance)
          self.toggleNoDataView(flag: false)
          self.loadDataInViews(data: cadData)
          self.cadData = cadData
          
          self.updateCollectionViewHeights()
          
        }else {
          
//          self.toggleNoDataView(flag: true)
          
        }
        
      }
      
    }
    
    
  }
  
  private func toggleNoDataView(flag: Bool){
    
    if flag {
      
      noDataView.isHidden = false
      
    }else {
      
      noDataView.isHidden = true
      
    }
    
  }
  
  private func updateCollectionViewHeights(){
    
    self.propertyValueCollectionView.reloadData()
    self.salesCollectionView.reloadData()
    self.improvementHistoryCollectionview.reloadData()
    self.taxCollectionView.reloadData()
    
    if self.cadData?.taxData?.count != 0{
      
      self.taxCollectionViewHeightConstraint.constant = CGFloat((self.cadData?.taxData?.count)! * 60)
      
    }else {
      
      self.taxCollectionViewHeightConstraint.constant = 0
      
    }
    
    if self.cadData?.improvementHistoryData?.count != 0{
      
      self.improvementHistoryCVHeightConstraint.constant = CGFloat((self.cadData?.improvementHistoryData?.count)! * 60)
      
    }else {
      
      self.improvementHistoryCVHeightConstraint.constant = 0
      
    }
    
    if self.cadData?.propertyValueData?.count != 0{
      
      self.valueCVHeightConstraint.constant = CGFloat((self.cadData?.propertyValueData?.count)! * 60)
      
    }else {
      
      self.valueCVHeightConstraint.constant = 0
      
    }
    
    if self.cadData?.salesData?.count != 0{
      
      self.salesCVHeightConstraint.constant = CGFloat((self.cadData?.salesData?.count)! * 60)
      
    }else {
      
      self.salesCVHeightConstraint.constant = 0
      
    }
    
  }
  
  
}


//MARK: Extensions

extension CadDataViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == propertyValueCollectionView{
      
      if let count = self.cadData?.propertyValueData!.count {
        
        return count
        
      }else {
        
        return 0
        
      }
      
    }else if collectionView == salesCollectionView{
      
      if let count = self.cadData?.salesData!.count {
        
        return count
        
      }else {
        
        return 0
        
      }
      
    }else if collectionView == improvementHistoryCollectionview{
      
      if let count = self.cadData?.improvementHistoryData!.count {
        
        return count
        
      }else {
        
        return 0
        
      }
      
    }else {
      
      if let count = self.cadData?.taxData!.count {
        
        return count
        
      }else {
        
        return 0
        
      }
      
    }

    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == propertyValueCollectionView{
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyValueCollectionViewCell", for: indexPath) as! PropertyValueCollectionViewCell
      
      if let instance = self.cadData?.propertyValueData![indexPath.row]{
        
        cell.loadData(instance: instance)
        
      }
      
      return cell
      
    }else if collectionView == salesCollectionView{
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SalesCollectionViewCell", for: indexPath) as! SalesCollectionViewCell
      
      if let instance = self.cadData?.salesData![indexPath.row]{
        
        cell.loadData(instance: instance)
        
      }
      
      return cell
      
    }else if collectionView == improvementHistoryCollectionview{
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImprovementHistoryCollectionViewCell", for: indexPath) as! ImprovementHistoryCollectionViewCell
      
      if let instance = self.cadData?.improvementHistoryData![indexPath.row]{
        
        cell.loadData(instance: instance)
        
      }
      
      return cell
      
    }else {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxCollectionViewCell", for: indexPath) as! TaxCollectionViewCell
      
      if let instance = self.cadData?.taxData![indexPath.row]{
        
        cell.loadData(instance: instance)
        
      }
      
      return cell
      
    }

  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//    if collectionView == propertyValueCollectionView{
      
      let width = collectionView.frame.width
      let size = CGSize(width: width, height: 60)
      return size
      
//    }else {
//
//      let width = collectionView.frame.width
//      let size = CGSize(width: width, height: 60)
//      return size
//
//    }
    
    
  }
  
}

struct CadDataModel{
  
  let buildingAndLotData: BuildingAndLotModel?
  let salesData: [SalesModel]?
  let ownershipData: [OwnershipModel]?
  let improvementHistoryData: [ImprovementHistoryModel]?
  let propertyValueData: [PropertyValueModel]?
  let taxData: [TaxModel]?
  let documentsData: DocumentsAndFilesModel?
  
  
}

struct BuildingAndLotModel{
  
  let geoId : String?
  let govId : String?
  let legalDiscription : String?
  let propertyAddress : String?
  let landArea: Int32?
  let improvedArea : Int32?
  let propertyType : String?
  let subDivision : String?
  let taxAgent : String?
  let state: String?
  let city: String?
  let zipCode: String?
//  "pro_link": "https://www.collincad.org/propertysearch?prop=2711541&year=2019",
//  "gov_id": "2711541",
//  "geo_graphic_id": "R-4831-001-001R-1",
//  "property_address": "7250 Dallas Pkwy, Plano, TX",
//  "land_area": 161738,
//  "improved_area": 356196,
//  "subdivisions": "Robb & Stucky Addition",
//  "legal_desc": "Robb & Stucky Addition, Blk 1, Lot 1r; Replat",
//  "tax_agent": "Altus Group Us Inc Dallas",
//  "docs": "https://storage.officedoor.ai/CadData/cMWNjDqxWBIx3Jc-396349-CollinCad4.zip",
//  "property_type": "Real",
//  "state": null,
//  "city": null,
//  "zipcode": null
  
  
}

struct SalesModel{
  
  let salesId: Int32?
  let deedDate: String?
  let sellerName: String?
  let buyerName: String?
  let instructionNo: String?
  let propertyInfo: Int32?
//  "id": 1445511,
//  "deed_date": "2016-10-03",
//  "Seller_name": "TC/P LEGACY TOWER I LLC",
//  "Buyer_name": "7250 NORTH DALLAS PARKWAY TEXAS LLC",
//  "instruction_no": "20161004001336740",
//  "property_info": 396350
  
}

struct OwnershipModel {
  
  
  let propId: Int32?
  let ownerId: String?
  let ownerName: String?
  let exemption: String?
  let ownershipPercent: Int?
  let mailingAddress: String?
  let propertyInfo: Int32?
//   "id": 396356,
//   "owner_id": "1006472",
//   "owner_name": "7250 North Dallas Parkway Texas LLC C/O Intercontinental Real Estate Corporation",
//   "exemption": "None",
//   "ownership_percent": 100,
//   "mailing_address": "1270 Soldiers Field RdBrighton, MA  02135-1003",
//   "property_info": 396350
  
  
}

struct ImprovementHistoryModel {
   
  let historyId: Int32?
  let improvType: String?
  let spaceOfImprov: String?
  let yearOfImprov: String?
  let areaOfImprov: String?
  let improvNo: String?
  let improvValue: Int32?
  let propertyInfo: Int32?
//  "id": 559918,
//  "improv_no": "Improvement #2",
//  "improv_type": "Commercial",
//  "space_of_improvements": "PG - Parking Garage",
//  "year_of_improvements": "2013",
//  "area_of_improvements": "386502",
//  "improvement_value": null,
//  "property_info": 396350
}

struct PropertyValueModel {
  
  let valueId: Int32?
  let valueYear: String?
  let improvValue: Int32?
  let landValue: Int32?
  let marketValue: Int32?
  let appraisedValue: Int32?
  let assessedValue: Int32?
  let propertyInform: Int32?
  
//  "id": 6163449,
//  "year": "2019",
//  "improvement_value": 130530469,
//  "land_value": 6469531,
//  "markete_value": 137000000,
//  "appraised_value": 137000000,
//  "assessed_value": 137000000,
//  "property_inform": 396350
  
  
}

struct TaxModel {
  
  let taxId: Int32?
  let taxEntity: String?
  let collectingEntity: String?
  let taxRate: Float?
  let propertyInfo: Int32?
  
}

struct DocumentsAndFilesModel{
  
  let proLink: String?
  let docsLink: String?
  
}

//extension CadDataViewController: UITableViewDelegate, UITableViewDataSource{
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 10
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: "CadTableViewCell")
////      as! CadTableViewCell
//    cell?.textLabel?.text = "Before the haters come at me about saying website instead of URL or API, I want to mention that URL stands for “Uniform Resource Locator” and exists even for local files and paths. APIs, “Application Programming Interfaces” do not necessarily have to be a remote resource either. An ad blocker might use Safari’s API to block ads."
////    textDataLabel.text = "Before the haters come at me about saying website instead of URL or API, I want to mention that URL stands for “Uniform Resource Locator” and exists even for local files and paths. APIs, “Application Programming Interfaces” do not necessarily have to be a remote resource either. An ad blocker might use Safari’s API to block ads."
//    return cell!
//
//
//  }
//
//
//
//}

//extension CadDataViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 10
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CadCollectionViewCell", for: indexPath) as! CadCollectionViewCell
//    //      as! CadTableViewCell
//    cell.cadDataLabel.text = "Before the haters come at me about saying website instead of URL or API, I want to mention that URL stands for “Uniform Resource Locator” and exists even for local files and paths. APIs, “Application Programming Interfaces” do not necessarily have to be a remote resource either. An ad blocker might use Safari’s API to block ads."
//    //    textDataLabel.text = "Before the haters come at me about saying website instead of URL or API, I want to mention that URL stands for “Uniform Resource Locator” and exists even for local files and paths. APIs, “Application Programming Interfaces” do not necessarily have to be a remote resource either. An ad blocker might use Safari’s API to block ads."
//        return cell
//    
//  }
//  
//   func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
//     {
//      let cellSize:CGSize = CGSize(width: self.cadCollectionView.frame.width, height: 100)
//         return cellSize
//     }
//  
//  
//}
