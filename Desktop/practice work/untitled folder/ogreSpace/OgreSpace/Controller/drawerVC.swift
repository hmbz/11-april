//
//  drawerVC.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

//Model for Drawer
struct drawerModel {
    let Image : UIImage?
    let name: String?
}

class drawerVC: UIViewController {

    //MARK:- Properties
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var drawerTabView: UITableView!
    @IBOutlet weak var profileDrawerImageHeight: NSLayoutConstraint!
  
    //MARK:- Variables
    
    var drawerArray = [[drawerModel]]()
    var drawerSection = ["OgreSpace","My Account","About"]
  //MARK:- Top Bar Setting
  // setting variable for top bar View
  
  lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
      super.viewDidLoad()
      setUpViews ()
      drawerTabView.delegate = self
      drawerTabView.dataSource = self
      let username = UserDefaults.standard.string(forKey: SessionManager.keys.name)
      guard let userImageUrl = UserDefaults.standard.string(forKey: SessionManager.keys.imageUrl) else {return}
      self.userImg.sd_setImage(with: URL(string: userImageUrl), placeholderImage: #imageLiteral(resourceName: "dprofile"))
      self.userNameLbl.text = username
      userImg.round(conerRadius: 50)
      
    }
  
  //MARK:- Private Functions
  
    private func setUpViews () {
      
        let home = drawerModel.init(Image: #imageLiteral(resourceName: "TopHome"), name: "Home")
        let favourites = drawerModel.init(Image: #imageLiteral(resourceName: "dprofile"), name: "Favourites")
        let paymentMethod = drawerModel.init(Image: #imageLiteral(resourceName: "dprofile"), name: "Payment Method")
        let myProperties = drawerModel.init(Image: #imageLiteral(resourceName: "dprofile"), name: "My Properties")
        let resetPass = drawerModel.init(Image: #imageLiteral(resourceName: "dpass"), name: "Change Password")
        let logout = drawerModel.init(Image: #imageLiteral(resourceName: "dlogin"), name: "Logout")
        let profile = drawerModel.init(Image: #imageLiteral(resourceName: "dprofile"), name: "Profile")
        let whatOgreSpace = drawerModel.init(Image: #imageLiteral(resourceName: "whatisogre"), name: "What Is OgreSpace")
        let works = drawerModel.init(Image: #imageLiteral(resourceName: "howitworks"), name: "How It Works")
        let contactUs = drawerModel.init(Image: #imageLiteral(resourceName: "contactUs"), name: "Contact Us")
        let faq = drawerModel.init(Image: #imageLiteral(resourceName: "faq"), name: "Faqs")
        let TermsOfUse = drawerModel.init(Image: #imageLiteral(resourceName: "terms"), name: "Terms of Use")
        let pivacyPolicy = drawerModel.init(Image: #imageLiteral(resourceName: "privacypolicy"), name: "Privacy Policy")
        let shareNow = drawerModel.init(Image: #imageLiteral(resourceName: "share"), name: "Share")
      
        drawerArray = [[home,favourites,myProperties,paymentMethod], [profile,resetPass],[whatOgreSpace,works,contactUs,faq,TermsOfUse,pivacyPolicy,shareNow,logout]]
    }
}

// MARK:- Table View Life cycle

extension drawerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return drawerSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
      return drawerSection[section]
      
  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      return drawerArray[section].count
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = drawerTabView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      let image =  drawerArray[indexPath.section][indexPath.row].Image
      cell.imageView!.image = image?.maskWithColor(color: UIColor.white)
      cell.textLabel?.text = drawerArray[indexPath.section][indexPath.row].name
      cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
      cell.textLabel?.textColor = UIColor.white
      cell.selectionStyle = .none
      return cell
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
      return 35
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      
      let header = view as! UITableViewHeaderFooterView
      header.textLabel?.textColor = UIColor.white
      header.textLabel?.text = drawerSection[section]
      header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
      
      view.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if indexPath.section == 0 {
        
        if indexPath.row == 0 {
          
          print("Home")
        
        }else if indexPath.row == 1{
          
          let vc = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 2{
          
          let vc = UIStoryboard(name: "MyProperties", bundle: nil).instantiateViewController(withIdentifier: "MyPropertiesViewController") as! MyPropertiesViewController
          self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
          
          let vc = UIStoryboard(name: "PaymentMethod", bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }
      }else if indexPath.section == 1 {
        
        if indexPath.row == 0 {
          
          print("Profile")
          let vc = storyboard?.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 1 {
          
          print("Reset Password")
          let vc = storyboard?.instantiateViewController(withIdentifier: "resetPassViewController") as! resetPassViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }
      
      }else if indexPath.section == 2 {
        
        
        if indexPath.row == 0 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "whatIsOgreViewController") as! whatIsOgreViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 1 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "HowItWorksViewController") as! HowItWorksViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 2 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 3 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "faqsViewController") as! faqsViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 4 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 5 {
          
          let vc = storyboard?.instantiateViewController(withIdentifier: "privacyPolicyViewController") as! privacyPolicyViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
        }else if indexPath.row == 6 {
          
          let items =  [shareString, urlAppStore] as [ Any ]
          let activityVC = UIActivityViewController(activityItems: items, applicationActivities: [])
          activityVC.popoverPresentationController?.sourceView = self.view
          if let popoverController = activityVC.popoverPresentationController{
            
            popoverController.permittedArrowDirections = .up
          
          }
          self.present(activityVC, animated:true , completion: nil)
        
        }else if indexPath.row == 7 {
          
          print("Logout")
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.UserId)
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.name)
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.email)
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.accessToken)
          UserDefaults.standard.set(false, forKey: SessionManager.keys.isUserLoggedIn)
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.password)
          UserDefaults.standard.set(nil, forKey: SessionManager.keys.imageUrl)
      
          let loginManager = LoginManager()
          loginManager.logOut()
          GIDSignIn.sharedInstance()?.signOut()
          setRootViewController(storyboardName: "Main", VCIdentifier: "SliderNavController")
              
        }
      
      }
  
  }
//  func topbarInvite(){
//    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
//  }

}
    

