//
//  LoginViewController.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import GoogleSignIn


class LoginViewController: UIViewController {
  
  //MARK:- IBOutlets
  
    @IBOutlet weak var usernameTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var facebookBtn: UIButton!
//    @IBOutlet weak var termBtn: UIButton!
//    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var passShowBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var fidgetSpinner: UIImageView!
    
//MARK:- Properties
    
    
    
    //MARK:- View Life Cycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
      
      
      if (AccessToken.current != nil) {
        
        print("User is already logged in through facebook")
        
      }
      
    }
    
  override func viewWillAppear(_ animated: Bool) {

    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance()?.delegate = self

  }
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK:- Actions
    
    //....................Show and hide pass Btn Action.................//
    @objc private func showPass(sender: UIButton){
        if (passShowBtn.isSelected == true){
            passShowBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            passShowBtn.isSelected = false
            passwordTextField.isSecureTextEntry = false
        }
        else{
            passShowBtn.setImage(#imageLiteral(resourceName: "unLike"), for: .normal)
            passShowBtn.isSelected = true
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    //...................moving towards Reset Pass.......................//
    @objc func forgotPassBtnTapped(sender: UIButton){
       self.performSegue(withIdentifier: "signInToForgotPass", sender: self)
    }
    
    //....................moving towards Home ...........................//
    @objc func signInBtnTapped(sender: UIButton){
        if usernameTextField.text!.isEmpty{
            self.view.makeToast("Please enter username",position:.top)
            self.usernameTextField.becomeFirstResponder()
        }
        else if passwordTextField.text!.isEmpty{
            self.view.makeToast("Please enter Password",position:.top)
            self.passwordTextField.becomeFirstResponder()
        }
        else {
            print("Login In")
          getIsActive()
          
        }
    }
    
    // ....................moving towards SignUp..........................//
    @objc func signUpBtnTapped(sender: UIButton){
        self.performSegue(withIdentifier: "signInToSignUp", sender: self)
    }
    
  @IBAction func facebookLoginTapped(_ sender: Any) {
    
    if InternetAvailability.isConnectedToNetwork() {
      
      let loginManager = LoginManager()
      loginManager.loginBehavior = .browser
      
      loginManager.logIn(permissions: [.userAboutMe, .email], viewController: self, completion: { (loginResult) in
        
        switch loginResult {
        case .failed(let error):
          print(error)
//          _ = SweetAlert().showAlert("Login With Facebook Failed", subTitle:error.localizedDescription , style: .error)
        case .cancelled:
          print("User cancelled login.")
          
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
          print("grantedPermissions == \(grantedPermissions)")
          print("declinedPermissions == \(declinedPermissions)")
          print(accessToken)
          self.getFbUserData()
        }
      })
      
    }
    else{
//      _ = SweetAlert().showAlert("Error", subTitle: "Please check your network connection and try again." , style: AlertStyle.error,buttonTitle:
//        "Ok", buttonColor:UIColor.colorFromRGB(0x000000))
      
    }
    
  }
  
  @IBAction func googleLoginTapped(_ sender: Any) {
    
    GIDSignIn.sharedInstance().signIn()
    
  }
  
  
    //MARK:- Private functions
    private func setupViews() {
        
        // Apply Animation to buttons
        signInBtn.applyShadowOnRoundedBlackButton(backColor: UIColor.black, titleColor: UIColor.white)
        facebookBtn.applyShadowOnRoundedBlackButton(backColor: #colorLiteral(red: 0.2980036139, green: 0.4364652336, blue: 0.6649262309, alpha: 1), titleColor: UIColor.white)
        googleView.makeRoundedCorners(cornerRadius: 20)
        
        //Applying Button Action
        passShowBtn.addTarget(self, action: #selector(showPass(sender:)), for: .touchUpInside)
        signInBtn.addTarget(self, action: #selector(signInBtnTapped(sender:)), for: .touchUpInside)
        forgotPassBtn.addTarget(self, action: #selector(forgotPassBtnTapped(sender:)), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnTapped(sender:)), for: .touchUpInside)
      addTopMenu()
      self.navigationController?.isNavigationBarHidden = false
      
    }
  
  
  private func getFbUserData() {
    
    if((AccessToken.current) != nil){
      GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { [weak self] (connection, result, error) -> Void in
        guard let strongSelf = self else { return }
        if (error == nil){
          
          let dict = result as! [String : AnyObject]
          //print(result!)
          
          print(dict)
          guard let name = dict["name"] as? String else {
            return
          }
          print(name)
          guard let email = dict["email"] as? String else {
            return
          }
          guard let id = dict["id"] as? String else {
            return
          }
          var imageUrlStr = "NA"
          if let picDict = dict["picture"] as? Dictionary<String,Any> ,
            let dataDict = picDict["data"] as? Dictionary<String,Any>,
            let url = dataDict["url"] as? String{
            //print("picDict : \(picDict)")
            //print("url = \(url)")
            imageUrlStr = url
            UserDefaults.standard.set(imageUrlStr, forKey: SessionManager.keys.imageUrl)
            
          }
          let token = AccessToken.current?.tokenString
          
          let userDict = ["id" : id ,
                          "name": name,
                          "email": email,
                          "photoUrl" : imageUrlStr,
                          "authToken" : token ?? "NA",
                          "provider": "FACEBOOK" ]  as [String:Any]
          print(userDict)
          self?.getLoginSocially(prameters: ["user": userDict])
          
//          showSwiftMessageWithParams(theme: .success, title: "Sign In", body: "You have successfully logged in to OgreSpace")
//          self?.performSegue(withIdentifier: "tabBar", sender: self)
//
//          print(userDict)
//
//          // decoding the token to get user id and username
//          let bodyDict = userDict as NSDictionary
//          // getting id
//          var userIdFinal = -1
//          if let userId = bodyDict.value(forKey: "id") as? Int {
//            userIdFinal = userId
//            print("decoded userId \(String(describing: userId))")
//            UserDefaults.standard.set(userIdFinal, forKey: SessionManager.keys.UserId)
//            print(UserDefaults.standard.string(forKey: SessionManager.keys.UserId)!)
//          }
//          // email
//          var emailFinal = ""
//          if let userName = bodyDict.value(forKey: "email") as? String {
//            emailFinal = userName
//            UserDefaults.standard.set(emailFinal, forKey: SessionManager.keys.email)
//            print(UserDefaults.standard.string(forKey: SessionManager.keys.email)!)
//          }
//          var userNameFinal = ""
//          if let userName = bodyDict.value(forKey: "firstName") as? String {
//            userNameFinal = userName
//            UserDefaults.standard.set(userNameFinal, forKey: SessionManager.keys.name)
//            print(UserDefaults.standard.string(forKey: SessionManager.keys.name)!)
//          }
//          // saving the token and loginStatus to the Userdefault Memory
////          UserDefaults.standard.set(token, forKey: SessionManager.keys.accessToken)
//          UserDefaults.standard.set(true, forKey: SessionManager.keys.isUserLoggedIn)
          
          //          showSwiftMessageWithParams(theme: .success, title: "Sign In Successful", body: .strLoginSuccesfulMsg, layout: .cardView, completion: { (success) in
          //            self.navigationController?.popViewController(animated: true)
          //          })
          
          //
          //          let nameWithoutSpaces = name.replacingOccurrences(of: " ", with: "")
          //
          //          let password = "",  firstName = "",  lastName = ""
          //          let userInfo =  [nameWithoutSpaces , password,  firstName,  lastName,  email, true, id , token , loggedInThrough.facebook.hashValue] as [Any]
          //
          //          UserInfo.storeUserInfoArrayInInstance(array: userInfo)
          
        }
      })
    }
    
  }
  
    //............... geting token from Login Api Call.................//
  
  
  private func getIsActive(){
    self.fidgetSpinner.isHidden = false
    self.fidgetSpinner.loadGif(name: "name")
    self.shadowView.isHidden = false
    //        }
    let body = [
        "username" : usernameTextField.text!,
        "password" : passwordTextField.text!
    ]
//    let body = [
//      "username" : usernameTextField.text!
//
//    ]
    mainService.instance.checkIsActive(param:body, completion: { (success) in
      if success{
        let status = mainService.instance.status
        if status == 500{
          print("500")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body:"Unable to log in with provided credentials.")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 400{
          print("400")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Username or password does not exist. Please signup first.")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 404{
          print("404")
          
          showSwiftMessageWithParams(theme: .error, title: "Error", body: "We have sent you an activation email. Please click on the link to activate your account", layout: .messageView, position: .center , completion: { (value) in
            
          })
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 200 || status == 202{
          print("200")
          showSwiftMessageWithParams(theme: .success, title: "Sign In", body: "You have successfully logged in to OgreSpace")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          setRootViewController(storyboardName: "Main", VCIdentifier: "TabBarViewController")
//          self.loginAPI()
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
          
        }else{
          print("Error")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }
        
      }else{
        let status = mainService.instance.status
        print(status)
        showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
        self.fidgetSpinner.isHidden = true
        self.shadowView.isHidden = true
      }
    })
  }
  
//  private func loginAPI(){
//    self.fidgetSpinner.isHidden = false
//    self.fidgetSpinner.loadGif(name: "name")
//    self.shadowView.isHidden = false
//    //        }
//    let body = [
//        "username" : usernameTextField.text!,
//        "password" : passwordTextField.text!
//    ]
//    UserDefaults.standard.set(passwordTextField.text!, forKey: SessionManager.keys.password)
//    mainService.instance.loginUser(param:body, completion: { (success) in
//      if success{
//        let status = mainService.instance.status
//        if status == 500{
//          print("500")
//          showSwiftMessageWithParams(theme: .error, title: "Sign In", body:"Unable to log in with provided credentials.")
//          self.fidgetSpinner.isHidden = true
//          self.shadowView.isHidden = true
//
//        }else if status == 400{
//          print("400")
//          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Username or password does not exist. Please signup first.")
//          self.fidgetSpinner.isHidden = true
//          self.shadowView.isHidden = true
//
//        }else if status == 404{
//          print("404")
//          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Server not found")
//          self.fidgetSpinner.isHidden = true
//          self.shadowView.isHidden = true
//
//        }else if status == 200{
//          print("200")
//          showSwiftMessageWithParams(theme: .success, title: "Sign In", body: "You have successfully logged in to OgreSpace")
//          self.fidgetSpinner.isHidden = true
//          self.shadowView.isHidden = true
//          setRootViewController(storyboardName: "Main", VCIdentifier: "TabBarViewController")
////          self.performSegue(withIdentifier: "tabBar", sender: self)
//
//        }else{
//          print("Error")
//          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
//          self.fidgetSpinner.isHidden = true
//          self.shadowView.isHidden = true
//
//        }
//
//      }else{
//        let status = mainService.instance.status
//        print(status)
//        showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
//        self.fidgetSpinner.isHidden = true
//        self.shadowView.isHidden = true
//      }
//    })
//  }
  
  
  
  private func getLoginSocially(prameters: [String: Any]){
    self.fidgetSpinner.isHidden = false
    self.fidgetSpinner.loadGif(name: "name")
    self.shadowView.isHidden = false

    mainService.instance.getSocialLogin(param:prameters, completion: { (success) in
      if success{
        let status = mainService.instance.status
        if status == 500{
          print("500")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body:"Unable to log in with provided credentials.")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 400{
          print("400")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Username or password does not exist. Please signup first.")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 404{
          print("404")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Server not found")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }else if status == 200{
          
          print("200")
          showSwiftMessageWithParams(theme: .success, title: "Sign In", body: "You have successfully logged in to OgreSpace")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          setRootViewController(storyboardName: "Main", VCIdentifier: "TabBarViewController")
//          self.performSegue(withIdentifier: "tabBar", sender: self)
          
        }else{
          
          print("Error")
          showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
          self.fidgetSpinner.isHidden = true
          self.shadowView.isHidden = true
          
        }
        
      }else{
        
        let status = mainService.instance.status
        print(status)
        showSwiftMessageWithParams(theme: .error, title: "Sign In", body: "Try again")
        self.fidgetSpinner.isHidden = true
        self.shadowView.isHidden = true
        
      }
    })
  }
  
      //MARK:- Top Bar Setting
      // setting variable for top bar View
      lazy var titleview = Bundle.main.loadNibNamed("topBarView", owner: self, options: nil)?.first as! topBarView
      
      private func addTopMenu() {
          self.navigationItem.titleView = titleview
        titleview.titleLbl.text = "Sign In"
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
        navigationController?.popViewController(animated: true)
      }
      // going back directly towards the home
      @objc func homeBtnTapped(sender: UIButton) {
          print("Home Button Tapped")
  //        dismiss(animated: true, completion: nil)
      }
      
      // setting the topbar View Height
      override func viewLayoutMarginsDidChange() {
          titleview.frame =  CGRect(x:0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: 40)
          print("titleview width = \(titleview.frame.width)")
      }

}

//MARK:- Google sign in
extension LoginViewController : GIDSignInUIDelegate, GIDSignInDelegate {
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    // Perform any operations on signed in user here.
    if error == nil {
      
      let userId = user.userID ?? "NA"             // For client-side use only!
      let idToken = user.authentication.accessToken ?? "NA" // Safe to send to the server
      let fullName = user.profile.name ?? "NA"
//      let givenName = user.profile.givenName ?? "NA"
//      let familyName = user.profile.familyName ?? "NA"
      let email = user.profile.email ?? "NA"
      guard let imageUrl = user.profile.imageURL(withDimension: 0) else {return}
      let imageUrlStr = String(describing: imageUrl)
      UserDefaults.standard.set(imageUrlStr, forKey: SessionManager.keys.imageUrl)
      
      let userDict = ["id" : userId ,
                      "name": fullName,
                      "email": email,
                      "photoUrl" : imageUrlStr,
                      "authToken" : idToken ,
                      "provider": "GOOGLE" ]  as [String:Any]
      print(userDict)
      self.getLoginSocially(prameters: ["user": userDict])
      
      //      let userInfo = userInfoStruct(userName: fullName, password: "", firstName: givenName, lastName: familyName, email: email, isUserLoggedIn: true, userId: userId, googleIdToken: idToken, facebookIdToken: nil)

//      let userInfo =  [fullName , password,  givenName,  familyName,  email, true, userId , idToken, loggedInThrough.google.hashValue] as [Any]
//      UserInfo.storeUserInfoArrayInInstance(array: userInfo)
//      showSwiftMessageWithParams(theme: .success, title: "Sign In", body:"You have successfully logged in to OgreSpace.")
//      showSwiftMessageWithParams(theme: .success, title: "Login Successful", body: .strLoginSuccesfulMsg, layout: .cardView)
      
//      self.navigationController?.popViewController(animated: true)
      
    } else {
      print("\(error.localizedDescription)")
    }
    
  }
  
}
