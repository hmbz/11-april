//
//  TabBarViewController.swift
//  OgreSpace
//
//  Created by Ehtisham on 01/07/19.
//  Copyright © 2018 BrainPlow. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UINavigationBarDelegate , UITabBarControllerDelegate {

  @IBOutlet weak var bottomBarItem: UITabBar!
  override func viewDidLoad() {
        super.viewDidLoad()
   
    self.moreNavigationController.delegate = self as? UINavigationControllerDelegate
    self.tabBarController?.delegate = self
        // Do any additional setup after loading the view.
      // reduciing size of tab bar
//      let appearance = UITabBarItem.appearance()
//        let attributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 10)]
//        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    moreNavigationController.navigationBar.barTintColor = #colorLiteral(red: 0.764506421, green: 0, blue: 0.03501774407, alpha: 1)
    moreNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
    tabBarController?.moreNavigationController.navigationBar.tintColor = UIColor.white
    moreNavigationController.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad{
      let appearance = UITabBarItem.appearance()
      let attributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]
      appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    else {
      let appearance = UITabBarItem.appearance()
      let attributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 10)]
      appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
      
    }
    bottomBarItem.items![2].image = UIImage(named: "Add Listing")?.withRenderingMode(.alwaysOriginal)
    bottomBarItem.items![2].selectedImage = UIImage(named: "Add Listing Tap")?.withRenderingMode(.alwaysOriginal)
    }
  

  
  override func viewWillAppear(_ animated: Bool) {
    func navigationController(_ navigationController: UINavigationController , willShow viewController: UIViewController, animated: Bool){
      let moreNavBar = navigationController.navigationBar
      if let moreNavItem = moreNavBar.topItem {
        moreNavItem.rightBarButtonItem = nil
      }
    }
    //
    //     navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    //    let moreNavController = self.moreNavigationController
    //    if let moreTableView = moreNavController.topViewController?.view as? UITableView {
    //      for cell in moreTableView.visibleCells {
    //        cell.textLabel?.textColor = .red
    //
    //        cell.imageView?.image = cell.imageView?.image?.withRenderingMode(.alwaysTemplate)
    //      }
    //    }
    
  }
}
