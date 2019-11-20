//
//  SliderVC.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class SliderVC: UIViewController {
    //MARK:- Properties
  @IBOutlet weak var sliderCollectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var googleBtn: UIButton!
  @IBOutlet weak var googleBtnView: UIView!
  @IBOutlet weak var facebookBtn: UIButton!
  @IBOutlet weak var signupBtn: UIButton!
  @IBOutlet weak var signinBtn: UIButton!
  @IBOutlet weak var privacyTextView: UITextView!
  @IBOutlet weak var fidgetSpinner: UIImageView!
  @IBOutlet weak var shadowView: UIView!
    
    //MARK:- Variables
    var scrollingTimer: Timer? // To keep track of the Auto Scrolling Timer
    lazy var dummyCount = 10 //To make the slider looks like infnite
    lazy var sliderCollectionViewDataSource: Array = [UIImage]()
    var temp:CGPoint!
    lazy var selectedPage = 0 //For keeping track of the selected page in slider
    let privacyText = "By clicking on the Signup button, you understand and agree with the Terms of Use and Privacy Policy."
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupHyperLabel()
      
      if (AccessToken.current != nil) {
        
        print("User is already logged in through facebook")
        
      }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
      startTimer()
      navigationController?.isNavigationBarHidden = true

    }
    
  override func viewDidAppear(_ animated: Bool) {
    
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance()?.delegate = self
    
    
  }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        stopTimer()
    }
    
    
    //MARK:- Action
    
    @objc func signInTapped(sender: UIButton) {
       print("Moving Towards the SignIn View")
      let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(vc, animated: true)
      

    }
    
    @objc func signUpTapped(sender: UIButton) {

        self.performSegue(withIdentifier: "sliderToSignUp", sender: self)
        
    }
    
    @objc func facebookBtnTapped(sender: UIButton){
        print("Signing in through facebook")
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
    
    @objc func googleBtnTapped(sender: UIButton){
        print("Signing in through google")
      GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    //MARK:- Private Function
    private func setupViews() {
        
        // Setup animation to the buttons
        signinBtn.applyShadowOnRoundedBlackButton(backColor: #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        signupBtn.applyShadowOnRoundedBlackButton(backColor: #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        facebookBtn.applyShadowOnRoundedBlackButton(backColor: #colorLiteral(red: 0.2980036139, green: 0.4364652336, blue: 0.6649262309, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        googleBtnView.makeRoundedCorners(cornerRadius: 20)
        
        // Setup images for collectionView
      
        if Env.iPad {
            sliderCollectionViewDataSource = [UIImage (named: "sliderIpad1")!, UIImage (named: "sliderIpad2")!, UIImage (named: "sliderIpad3")!, UIImage (named: "sliderIpad4")!,UIImage (named: "sliderIpad5")!, UIImage (named: "sliderIpad6")!]
        }else {
            sliderCollectionViewDataSource = [UIImage (named: "slider1")!, UIImage (named: "slider2")!, UIImage (named: "slider3")!, UIImage (named: "slider4")!, UIImage (named: "slider5")!, UIImage (named: "slider6")!]
        }
        
        // Applying delegate to the Collection view
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.reloadData()
        
        // apply Button Actions
        signupBtn.addTarget(self, action: #selector(signUpTapped(sender:)), for: .touchUpInside)
        signinBtn.addTarget(self, action: #selector(signInTapped(sender:)), for: .touchUpInside)
        facebookBtn.addTarget(self, action: #selector(facebookBtnTapped(sender:)), for: .touchUpInside)
        googleBtn.addTarget(self, action: #selector(googleBtnTapped(sender:)), for: .touchUpInside)
        
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
          
        }
      })
    }
    
  }
  
  
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
          
//          self.performSegue(withIdentifier: "fromSliderToTabBar", sender: self)
          
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
  
    
    // setting up the Privacy policy and term of use.
    private func setupHyperLabel() {
        let str = self.privacyText
        let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
        let string = NSMutableAttributedString(attributedString: NSAttributedString(string: str, attributes: myAttribute))
        let attributedString = string
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://ogrespace.com/terms" , range: NSRange(location: 68, length: 13))
        attributedString.addAttribute(NSAttributedString.Key.link, value: "https://ogrespace.com/privacy-policy" , range: NSRange(location: 84, length: 15))
        privacyTextView.attributedText = attributedString
        privacyTextView.textAlignment = .center
        privacyTextView.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }

    
    
    
    
}
extension SliderVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderCollectionViewDataSource.count * dummyCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
        print(indexPath.row)
        print(indexPath.item)
        let imageIndex = indexPath.item % sliderCollectionViewDataSource.count
        var image = UIImage()
        image = sliderCollectionViewDataSource[imageIndex]
        cell.imageDetailSlider.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sliderCollectionView.bounds.size
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView == self.sliderCollectionView) {
            stopTimer()
        }
    }
    
    // start animating the slider
    func startTimer() {
        
        if sliderCollectionViewDataSource.count > 1 && scrollingTimer == nil {
            let timeInterval = 3.0;
            scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.rotate), userInfo: nil, repeats: true)
            scrollingTimer!.fireDate = Date().addingTimeInterval(timeInterval)
        }
    }
    
    // stop animating the Slider
    func stopTimer() {
        scrollingTimer?.invalidate()
        scrollingTimer = nil
    }
    
    @objc func rotate() {
        print("passed offset to rotate: \(sliderCollectionView.contentOffset.x)")
        let offset = CGPoint(x:self.sliderCollectionView.contentOffset.x + cellWidth, y: self.sliderCollectionView.contentOffset.y)
        print("setting the Calculated offset in rotate: \(offset)")
        var animated = true
        if (offset.equalTo(CGPoint.zero) || offset.equalTo(CGPoint(x: totalContentWidth, y: offset.y))){
            animated = false
        }
        self.sliderCollectionView.setContentOffset(offset, animated: animated)
        print("\n")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if (scrollView == self.sliderCollectionView) {
            self.centerIfNeeded(animationTypeAuto: true, offSetBegin: CGPoint.zero)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == self.sliderCollectionView){
            if(scrollView.panGestureRecognizer.state == .began){
                stopTimer()
            }else if( scrollView.panGestureRecognizer.state == .possible){
                startTimer()
            }
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
    
    func centerIfNeeded(animationTypeAuto:Bool, offSetBegin:CGPoint) {
        let currentOffset = self.sliderCollectionView.contentOffset
        let contentWidth = self.totalContentWidth
        let width = contentWidth / CGFloat(dummyCount)
        if currentOffset.x < 0{
            //left scrolling
            self.sliderCollectionView.contentOffset = CGPoint(x: width - currentOffset.x, y: currentOffset.y)
        } else if (currentOffset.x + cellWidth) >= contentWidth {
            //right scrolling
            let  point = CGPoint.zero
            var tempCGPoint = point
            tempCGPoint.x = tempCGPoint.x + cellWidth
            print("center if need set offset to \( tempCGPoint)")
            self.sliderCollectionView.contentOffset = point
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (scrollView == self.sliderCollectionView)
        {
            print("\(scrollView.contentOffset)")
            self.temp = scrollView.contentOffset
            self.stopTimer()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(collectionView == self.sliderCollectionView){
            print("collectionView.contentOffset.x \(collectionView.contentOffset.x)")
            print("collectionView.frame.size.width\(collectionView.frame.size.width)")
            var page:Int =  Int(collectionView.contentOffset.x / collectionView.frame.size.width)
            page = page % sliderCollectionViewDataSource.count
            print("page = \(page)")
            pageControl.currentPage = Int (page)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.sliderCollectionView) {
            self.centerIfNeeded(animationTypeAuto: false, offSetBegin: temp)
            self.startTimer()
        }
    }
    
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        DispatchQueue.main.async() {
            self.stopTimer()
            self.sliderCollectionView.reloadData()
            self.sliderCollectionView.setContentOffset( CGPoint.zero, animated: true)
            self.startTimer()
        }
        print("changed orientation")
    }
    
    var totalContentWidth: CGFloat {
        return CGFloat(sliderCollectionViewDataSource.count * dummyCount) * cellWidth
    }
    
    var cellWidth: CGFloat {
        return self.sliderCollectionView.frame.width
    }
    
    
}


//MARK:- Google sign in
extension SliderVC : GIDSignInUIDelegate, GIDSignInDelegate {
  
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
      
    } else {
      print("\(error.localizedDescription)")
    }
    
  }
  
}
