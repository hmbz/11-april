//
//  MapViewController.swift
//  OgreSpace
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  //MARK: IBOutlets
  
  @IBOutlet weak var mapView: MKMapView!
  
    //MARK: Properties
  var coordinatesDict = [String: Any]()
  
    //MARK: View Life Cycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
//      addTopBar()
      loadLocation(coordinates: self.coordinatesDict)

    }

//  private func addTopBar() {
//
//    let titleview = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)?.first as! TopView
//    self.navigationItem.titleView = titleview
//    titleview.filterBtn.removeFromSuperview()
//    titleview.notificationBtn.removeFromSuperview()
//    titleview.searchBtn.isUserInteractionEnabled = false
//    titleview.micBtn.setImage(UIImage(named: "ShareGray"), for: .normal)
//    titleview.micBtn.addTarget(self, action: #selector(shareBtnTapped(sender:)), for: .touchUpInside)
//    titleview.iconBtn.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
//    titleview.searchBtn.setTitle("Map", for: .normal)
//    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
//    titleview.pizzaMEnu.setImage(UIImage(named: "grayBack"), for: .normal)
//    titleview.pizzaMEnu.addTarget(self, action: #selector(pizzaMenuTapped(_:)), for: .touchUpInside)
//
//    self.navigationItem.hidesBackButton = true
//  }
  
  
//  @objc func shareBtnTapped(sender: UIButton) {
//
//    dismiss(animated: false, completion: nil)
//
//  }
  
//  @objc private func pizzaMenuTapped(_ sender: UIButton) {
//    
//    self.navigationController?.popViewController(animated: true)
////    dismiss(animated: false, completion: nil)
//  }
  
  @IBAction func backButtonTapped(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
    
  }
  private func loadLocation(coordinates: [String: Any]){
    
//    if instance.latitude!.isEmpty || instance.longitude!.isEmpty || instance.property_title!.isEmpty {
//
//
//    }else {
    
    let latitude = coordinates["latitude"]
    let longitude = coordinates["longitude"]
    let title = coordinates["title"]
    let annotation = MKPointAnnotation()
    let centerCoordinate = CLLocationCoordinate2D(latitude: latitude! as! CLLocationDegrees, longitude: longitude! as! CLLocationDegrees)
    annotation.coordinate = centerCoordinate
    annotation.title = title as! String
    self.mapView.showAnnotations([annotation], animated: true)
      
    let mapCenter = CLLocationCoordinate2DMake(latitude! as! CLLocationDegrees, longitude! as! CLLocationDegrees)
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: mapCenter, span: span)
    self.mapView.region = region
      //            self.propertyMapView.addAnnotation(annotation)
      
      
//    }
    
    
  }
}
