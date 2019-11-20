//
//  SearchViewController.swift
//  OgreSpace
//
//  Created by MAC on 20/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit
import TextFieldEffects
import AVFoundation
import Speech
import Toast_Swift
import MapKit

class SearchViewController: UIViewController {
  
  //MARK: IBOutlets
  
  @IBOutlet weak var filterViewTrailing: NSLayoutConstraint!
  @IBOutlet weak var searchTblView: UITableView!
  @IBOutlet weak var dimView: UIView!
  
  @IBOutlet weak var propertyTypeTf: HoshiTextField!
  @IBOutlet weak var addressTf: HoshiTextField!
  @IBOutlet weak var spaceTypeTf: HoshiTextField!
  @IBOutlet weak var minPriceTf: HoshiTextField!
  @IBOutlet weak var maxPriceTf: HoshiTextField!
  @IBOutlet weak var minSpaceTf: HoshiTextField!
  @IBOutlet weak var maxSpaceTf: HoshiTextField!
  
  @IBOutlet weak var imgMicrophone: UIImageView!
  @IBOutlet weak var viewSearch: UIView!
  @IBOutlet weak var lblTapToGetStarted: UILabel!
  @IBOutlet weak var centerYViewSpeech: NSLayoutConstraint!
  
  
  //MARK: Properties
  
  lazy var titleview = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)?.first as! TopView
  lazy var isShowingFilters = false
  lazy var body = [String : Any]()
  lazy var flagOpenSpeechRecView = false
  
  lazy var timer = Timer()
  lazy var speechRecognized = false
  lazy var viewSpeechRecogShowing = false
  lazy var topSearchBar = UISearchBar()
  lazy var searchSuggestionsArray = [MKLocalSearchCompletion]()
  
  let propertyTypePickerView = UIPickerView()
  let spaceTypePickerView = UIPickerView()
  let minPricePickerView = UIPickerView()
  let maxPricePickerView = UIPickerView()
  let minSpacePickerView = UIPickerView()
  let maxSpacePickerView = UIPickerView()
  
  let searchCompleter = MKLocalSearchCompleter()
  
  
  //MARK: View Life Cycle
  
    override func viewDidLoad() {
      
      super.viewDidLoad()
      setupViews()
      addTopBar()
        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    
    if flagOpenSpeechRecView {
      mikeTapped(UIButton())
    }else {
      topSearchBar.becomeFirstResponder()
      toggleSearchViewShowing(show: false)
    }
    
    if isShowingFilters{
      
      toggleFiltersView(flag: false)
      
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    DispatchQueue.main.async {
      self.topSearchBar.resignFirstResponder()
      self.view.endEditing(true)
    }
    toggleDimView(flag: false)
//    UserDefaults.standard.set(false, forKey: "searchBarFromHomeTapped")
    self.flagOpenSpeechRecView = false
  }
  
  //MARK: Functions
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    
    if touch?.view == dimView{
      
      toggleFiltersView(flag: false)
      toggleSearchViewShowing(show: false)
      
    }
    
//    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad{
//      
//      if (touch?.view == shadowView) {
//        filterUIViewTrailing.constant = -500
//        drawerLeading.constant = -280
//        shadowView.alpha = 0
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//      }
//    }else {
//      
//      if (touch?.view == shadowView) {
//        drawerLeading.constant = -280
//        filterUIViewTrailing.constant = -300
//        shadowView.alpha = 0
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//        
//      }
//    }
  }
  
  //MARK: Private Functions
  
  private func setupViews(){
    
    dimView.isHidden = true
    propertyTypeDoneBtn()
    spaceTypeDoneBtn()
    minPriceDoneBtn()
    maxPriceDoneBtn()
    minSpaceDoneBtn()
    maxSpaceDoneBtn()
    
    
    searchTblView.delegate = self
    searchTblView.dataSource = self
    searchCompleter.delegate = self
    setUpViews()

    
  }
  
  private func toggleFiltersView(flag: Bool){
    
    if flag{
      
      if Env.iPad{
        
        filterViewTrailing.constant = 0
        
      }else {
        
        filterViewTrailing.constant = 0
        
      }
      
      toggleDimView(flag: true)
      isShowingFilters = true
      
    }else {
      
      if Env.iPad{
        
        filterViewTrailing.constant = -500
        
      }else {
        
        filterViewTrailing.constant = -300
        
      }
      
      toggleDimView(flag: false)
      isShowingFilters = false
      
    }

    UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})

    
  }
  
  private func toggleDimView(flag: Bool){
    
    if flag{
      
      dimView.isHidden = false
      
    }else {
      
      dimView.isHidden = true
      
    }
    
  }
  
//  private func getSuggestions(query: String){
//
//
////    self.searchSuggestionsArray = [MKLocalSearchCompletion]()
//
//    searchCompleter.queryFragment = query
//
//  }
  
  //MARK: Top Bar
  
  private func addTopBar() {
    
    self.navigationItem.titleView = titleview
    //    titleview.backBtnViewWidth.constant = 60
    //    titleview.backBtn.setImage(nil, for: .normal)
    //    titleview.backBtn.setTitle("Home", for: .normal)
    //    titleview.backBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
//    titleview.searchBtn.delegate = self
//    titleview.searchBtn.placeholder = "Search OgreSpace"
    self.topSearchBar = titleview.propertySearchBar
    self.topSearchBar.delegate = self
    titleview.searchBtn.isHidden = true
    titleview.propertySearchBar.delegate = self
    titleview.propertySearchBar.isUserInteractionEnabled = true
    //    titleview.backBtn.addTarget(self, action: #selector(backbtnTapped(sender:)), for: .touchUpInside)
    
//    titleview.homeBtn.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    titleview.pizzaMEnu.setImage(UIImage(named: "grayBack"), for: .normal)
    titleview.pizzaMEnu.addTarget(self, action: #selector(homeBtnTapped(sender:)), for: .touchUpInside)
    titleview.inviteBtn.addTarget(self, action: #selector(inviteBtnTapped(sender:)), for: .touchUpInside)
    titleview.notificationBtn.setImage(UIImage(named: "findBidsFilter"), for: .normal)
    titleview.notificationBtn.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    titleview.pizzaMEnu.imageEdgeInsets = UIEdgeInsets(top: 6, left: 3, bottom: 5, right: 4)
    titleview.notificationBtn.addTarget(self, action: #selector(filterBtnTapped(sender:)), for: .touchUpInside)
    titleview.micBtn.addTarget(self, action: #selector(mikeTapped(_:)), for: .touchUpInside)
    
    self.navigationItem.hidesBackButton = true
    
  }
  
  @objc private func homeBtnTapped(sender: UIButton) {
    
    tabBarController?.selectedIndex = 0
    
  }
  
  
  @objc private func filterBtnTapped(sender: UIButton) {
    
    toggleFiltersView(flag: !isShowingFilters)
    
//    if Env.iPad {
//      if filterUIViewTrailing.constant == 0 {
//
//        filterUIViewTrailing.constant = -500
//        shadowView.alpha = 0
//
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//
//      }else if filterUIViewTrailing.constant == -500 {
//        //      let filterVC = storyboard?.instantiateViewController(withIdentifier: "FindBidsFilterViewController") as! FindBidsFilterViewController
//        //      filterVC.filtersDelegate = (self as! filtersDataDelegate)
//
//        filterUIViewTrailing.constant = 0
//
//        shadowView.alpha = 0.5
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//
//      }
//    }else {
//
//      if filterUIViewTrailing.constant == 0 {
//        filterUIViewTrailing.constant = -300
//        shadowView.alpha = 0
//
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//      }else if filterUIViewTrailing.constant == -300 {
//        //      let filterVC = storyboard?.instantiateViewController(withIdentifier: "FindBidsFilterViewController") as! FindBidsFilterViewController
//        //      filterVC.filtersDelegate = (self as! filtersDataDelegate)
//
//        filterUIViewTrailing.constant = 0
//
//        shadowView.alpha = 0.5
//        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
//
//      }
//    }
    
  }
  
  @objc private func mikeTapped(_ sender: UIButton){
    
    //bring speech view to front
    print("Speech listening icon clicked")
    //view is already showing and button is clicked. so we have to hide the view and stop recognition
    timer.invalidate()
    
    if viewSpeechRecogShowing {
      print("viewSpeechRecogShowing is showing. Going to stop and hide" )
      //self.lblTapToGetStarted.text = "Stopping ...."
      
      toggleSearchViewShowing(show: false)
      topSearchBar.isUserInteractionEnabled = true
//      tableViewSugg.isUserInteractionEnabled = true
      toggleDimView(flag: false)
      stopSpeechRecognition()
      
      //recordAndRecognizeSpeech()
      //have to recognize speech
    }else{
      //display
      
      //print("view is not shwing. show the view and start recognizing speec" )
      imgMicrophone.alpha = 1
      
      requestVoicePermission(completion: { (granted) in
        if granted {
          self.toggleSearchViewShowing(show: true)
          self.recordAndRecognizeSpeec()
          self.lblTapToGetStarted.text = "Listening ...."
          
          //searchBar.isUserInteractionEnabled = false
//          self.tableViewSugg.isUserInteractionEnabled = false
          self.toggleDimView(flag: true)
          
        }
      })
    }
    
  }
  
  private func addGestureToImgMicrophone(){
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imgMicrophoneTapped))
    imgMicrophone.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc private func imgMicrophoneTapped(){
    print("you tapped on microphone")
    imgMicrophone.alpha = 1
    lblTapToGetStarted.text = "Listening....."
    requestVoicePermission { (granted) in
      if granted {
        self.recordAndRecognizeSpeec()
      }
    }
  }
  
  private func setUpViews () {
    
    propertyTypeTf.delegate = self
    propertyTypePickerView.delegate = self
    propertyTypePickerView.dataSource = self
    propertyTypeTf.inputView = propertyTypePickerView
    
    spaceTypeTf.delegate = self
    spaceTypePickerView.delegate = self
    spaceTypePickerView.dataSource = self
    spaceTypeTf.inputView = spaceTypePickerView
    
    minPriceTf.delegate = self
    minPricePickerView.delegate = self
    minPricePickerView.dataSource = self
    minSpaceTf.inputView = minPricePickerView
    
    maxPriceTf.delegate = self
    maxPricePickerView.delegate = self
    maxPricePickerView.dataSource = self
    maxPriceTf.inputView = maxPricePickerView
    
    minSpaceTf.delegate = self
    minSpacePickerView.delegate = self
    minSpacePickerView.dataSource = self
    minSpaceTf.inputView = minSpacePickerView
    
    maxSpaceTf.delegate = self
    maxSpacePickerView.delegate = self
    maxSpacePickerView.dataSource = self
    maxSpaceTf.inputView = maxSpacePickerView
    
    addressTf.placeholder = "Search by address, City and Zip Code"
    addressTf.tintColor = UIColor.black
    propertyTypeTf.placeholder = "Property type"
    propertyTypeTf.tintColor = UIColor.black
    spaceTypeTf.placeholder = "Space Type"
    spaceTypeTf.tintColor = UIColor.black
    minPriceTf.placeholder = "Min Price"
    minPriceTf.tintColor = UIColor.black
    maxPriceTf.placeholder = "Max Price"
    maxPriceTf.tintColor = UIColor.black
    minSpaceTf.placeholder = "Min Space"
    minSpaceTf.tintColor = UIColor.black
    maxSpaceTf.placeholder = "Max Space"
    maxSpaceTf.tintColor = UIColor.black
    
    addGestureToImgMicrophone()
    
  }
  
  //MARK: Filters PickerViews
  
  // property pickerView
  private func propertyTypeDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.propertyTypePicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.propertyTypeCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = propertyTypePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    propertyTypeTf.inputView = pickerView
    propertyTypeTf.inputAccessoryView = toolBar1
    
  }
  
  @objc private func propertyTypePicker() {
    
    propertyTypeTf.resignFirstResponder()
    
  }
  
  @objc private func propertyTypeCanclePicker() {
    
    propertyTypeTf.resignFirstResponder()
  }
  
  // Space Type Picker View
  private func spaceTypeDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.spaceTypePicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.spaceTypeCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = spaceTypePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    spaceTypeTf.inputView = pickerView
    spaceTypeTf.inputAccessoryView = toolBar1
    
  }
  
  @objc func spaceTypePicker() {
    
    spaceTypeTf.resignFirstResponder()
    
  }
  @objc func spaceTypeCanclePicker() {
    
    spaceTypeTf.resignFirstResponder()
  }
  // Min Price Picker View
  func minPriceDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.minPicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.minCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = minPricePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    minPriceTf.inputView = pickerView
    minPriceTf.inputAccessoryView = toolBar1
    
  }
  
  @objc private func minPicker() {
    
    minPriceTf.resignFirstResponder()
    
  }
  
  @objc private func minCanclePicker() {
    
    minPriceTf.resignFirstResponder()
  }
  
  // Max picker view
  private func maxPriceDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.maxPicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.maxCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = maxPricePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    maxPriceTf.inputView = pickerView
    maxPriceTf.inputAccessoryView = toolBar1
    
  }
  
  @objc private func maxPicker() {
    
    maxPriceTf.resignFirstResponder()
    
  }
  
  @objc private func maxCanclePicker() {
    
    maxPriceTf.resignFirstResponder()
  }
  // Min space picker view
  private func minSpaceDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.minSpacePicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.minSpaceCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = minSpacePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    minSpaceTf.inputView = pickerView
    minSpaceTf.inputAccessoryView = toolBar1
    
  }
  @objc private func minSpacePicker() {
    
    minSpaceTf.resignFirstResponder()
    
  }
  @objc private func minSpaceCanclePicker() {
    
    minSpaceTf.resignFirstResponder()
  }
  // Max Space picker view
  private func maxSpaceDoneBtn(){
    
    let toolBar1 = UIToolbar()
    toolBar1.barStyle = UIBarStyle.default
    toolBar1.isTranslucent = true
    toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar1.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.maxSpacePicker))
    doneButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(SearchViewController.maxSpaceCanclePicker))
    cancelButton.tintColor = #colorLiteral(red: 0.8024634268, green: 0.07063802083, blue: 0.1448886847, alpha: 1)
    
    toolBar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar1.isUserInteractionEnabled = true
    
    let pickerView = maxSpacePickerView
    
    pickerView.backgroundColor = .white
    pickerView.showsSelectionIndicator = true
    
    maxSpaceTf.inputView = pickerView
    maxSpaceTf.inputAccessoryView = toolBar1
    
  }
  @objc private func maxSpacePicker() {
    
    maxSpaceTf.resignFirstResponder()
    
  }
  @objc private func maxSpaceCanclePicker() {
    
    maxSpaceTf.resignFirstResponder()
  }
  
  //MARK: IBActions
  
  @IBAction func applyFilterBtnTapped(_ sender: Any) {
    print(body)
    if addressTf.text != ""{
      
      let addressField = addressTf.text
      self.body["keyword"] = addressField
      let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
      let vc = homeStoryboard.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
      print(body)
      vc.body = body
      self.navigationController?.pushViewController(vc, animated: true)
    }else{
      
      let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
      let vc = homeStoryboard.instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
      print(body)
      vc.body = body
      self.navigationController?.pushViewController(vc, animated: true)
      //      return
    }
    
    
  }
  
  @IBAction func clearFiltersBtnTapped(_ sender: Any) {
    
    self.body = [:]
    addressTf.placeholder = "Search by address, City and Zip Code"
    addressTf.text = ""
    propertyTypeTf.placeholder = "Property type"
    propertyTypeTf.text = ""
    spaceTypeTf.placeholder = "Space Type"
    spaceTypeTf.text = ""
    minPriceTf.placeholder = "Min Price"
    minPriceTf.text = ""
    maxPriceTf.placeholder = "Max Price"
    maxPriceTf.text = ""
    minSpaceTf.placeholder = "Min Space"
    minSpaceTf.text = ""
    maxSpaceTf.placeholder = "Max Space"
    maxSpaceTf.text = ""
    
  }
  
  //MARK:- Speech Recognition
  //First, an instance of the AVAudioEngine class.
  // This will process the audio stream. It will give updates when the mic is receiving audio.
  var audioEngine = AVAudioEngine()
  //second, an instance of the speech recognizer. This will do the actual speech recognition. It can fail to recognize speech and return nil, so it’s best to make it an optional
  var speechReocognizer : SFSpeechRecognizer? = SFSpeechRecognizer()
  // By default, the speech recognizer will detect the devices locale and in response recognize the language appropriate to that geographical location
  // The default language can also be set by passing in a locale argument and identifier. Like this: let speechRecognizer: SFSpeechRecognizer(locale: Locale.init(identifier: "en-US")) .
  
  //Third, recognition request as SFSpeechAudioBufferRecognitionRequest. This allocates speech as the user speaks in real-time and controls the buffering. If the audio was pre-recorded and stored in memory you would use a SFSpeechURLRecognitionRequest instead.
  
  var request = SFSpeechAudioBufferRecognitionRequest()
  //Fourth, an instance of recognition task. This will be used to manage, cancel, or stop the current recognition task.
  var recognitionTask: SFSpeechRecognitionTask?
  
  //5. will perform the speech recognition. It will record and process the speech as it comes in.
  
  //audio engine uses what are called nodes to process bits of audio. Here .inputNode creates a singleton for the incoming audio. by apple "Nodes have input and output busses, which can be thought of as connection points"
  var recognizedTest = ""
  //MARK: Speech Recognition
  private func requestVoicePermission( completion: @escaping (Bool) -> () )  {
    
    //imgMicrophone.isUserInteractionEnabled = false
    //    if !AVAudioSession.sharedInstance().recor>dPermission() == AVAudioSessionRecordPermission.granted {
    let recordingSession = AVAudioSession()
    do {
      
      try recordingSession.setCategory(AVAudioSession.Category.playAndRecord)
      switch recordingSession.recordPermission {
      case AVAudioSessionRecordPermission.granted:
        print("Permission granted")
        SFSpeechRecognizer.requestAuthorization({ (authStatus) in
          OperationQueue.main.addOperation {
            switch authStatus {
            case .authorized:
              //self.recordButton.isEnabled = true
              completion(true)
            case .denied:
              completion(false)
           self.view.makeToast(strSpeechRecPerNotGranted)
            case .restricted:
              self.view.makeToast(strSpeechRecPerRestricted)
              completion(false)
            case .notDetermined:
              self.view.makeToast(strSpeechRecPerNotGranted)
              completion(false)
            }
          }
        })
        
      //recordAndRecognizeSpeec()
      case AVAudioSessionRecordPermission.denied:
        
        print("user had denied Permission earlier")
        let title = "Microphone permission Denied"
        let mess = "Go to Settings -> Privacy -> Microphone, find SHOPnROAR and tap on the switch to allow microphone to process your voice."
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
          alert.dismiss(animated: true, completion: nil)
          completion(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
      case AVAudioSessionRecordPermission.undetermined:
        
        print("Request permission here")
        
        // Handle granted
        recordingSession.requestRecordPermission(){ (allowed) in
          if allowed {
            SFSpeechRecognizer.requestAuthorization({ (authStatus) in
              OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                  //self.recordButton.isEnabled = true
                  completion(true)
                   case .denied:
                     completion(false)
                     self.view.makeToast(strSpeechRecPerNotGranted)
                   case .restricted:
                     self.view.makeToast(strSpeechRecPerRestricted)
                     completion(false)
                   case .notDetermined:
                     self.view.makeToast(strSpeechRecPerNotDetermined)
                     completion(false)
                }
              }
            })
            //print("Granted")
            //completion(true)
            
          } else {
            print("Denied")
            self.view.makeToast(strSpeechRecPerNotGranted)
            
            //let alert = UIAlertController(title: "We need your permission to process your Speech", message: "Go to Settings -> Privacy -> Microphone, find SHOPnROAR and tap on the switch to allow speech recognition.", preferredStyle: .alert)
            //            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            //              alert.dismiss(animated: true, completion: nil)
            //              completion(false)
            //            }))
            //            self.present(alert, animated: true, completion: nil)
          }
          
        }
        
      }
    } catch {
      print("try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord) failed")
    }
    
    //}
    
    
  }
  
  private func recordAndRecognizeSpeec() {
    
    
    audioEngine = AVAudioEngine()
    speechReocognizer = SFSpeechRecognizer()
    request = SFSpeechAudioBufferRecognitionRequest()
    recognitionTask = SFSpeechRecognitionTask()
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)
    //InstallTap configures the node and sets up the request instance with the proper buffer on the proper bus.
    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
      self.request.append(buffer)
    }
    
    toggleDimView(flag: true)
    //When user did not speak for for seconds
    timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
//      utilityFunctions.hide(view: self.imgFidget)
      print("4 seconds have been passed and you did not speak")
      self.lblTapToGetStarted.text = "Sorry, we did'nt get that. Tap on the microphone to try Again."
      self.imgMicrophone.alpha = 0.3
      self.imgMicrophone.isUserInteractionEnabled = true
      //self.lblTapToGetStarted.text = ""
      //self.recognitionTask?.finish()
      self.audioEngine.stop()
      self.recognitionTask?.cancel()
      let node = self.audioEngine.inputNode
      node.removeTap(onBus: 0)
      
    }
    
    audioEngine.prepare()
    do{
      
      try audioEngine.start()
      //Then, make a few more checks to make sure the recognizer is available for the device and for the locale, since it will take into account location to get language
      guard  let myRecognizer = SFSpeechRecognizer() else {
        return
      }
      if !myRecognizer.isAvailable{
        //recognier not available right now
        print("recognizer not available")
        return
        
      }
      var timerDidFinishTalk = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
        
      })
      //Next, call the recognitionTask method on the recognizer. This is where the recognition happens.
      
      recognitionTask = speechReocognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
        
        guard let result = result else {
          print("There was an error: \(error!)")
          return
        }
        timerDidFinishTalk.invalidate()
        
        if self.timer.isValid { self.timer.invalidate() }
      
        timerDidFinishTalk = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
        
          self.timer.invalidate()
          self.toggleSearchViewShowing(show: false)
          let searchText = result.bestTranscription.formattedString
          DispatchQueue.main.async {
            self.lblTapToGetStarted.text = "Successfully recognized your speech."
            self.topSearchBar.text = searchText
            self.searchBar(self.topSearchBar, textDidChange: searchText)
            
          }
          self.searchTblView.reloadData()
          self.speechRecognized = true
          self.recognitionTask?.finish()
          node.removeTap(onBus: 0)
          self.request.endAudio()
          //self.request = nil
          self.recognitionTask = nil
          self.audioEngine.stop()
        })
      })
    }catch{
      print("let result = result failed")
      return print(error)
    }
  }
  
  private func stopSpeechRecognition(){
    self.lblTapToGetStarted.text = "Stopping Speech Recognition"
    self.request.endAudio()
    self.audioEngine.stop()
    
    let node = audioEngine.inputNode
    node.removeTap(onBus: 0)
    
    //self.request = nil
    //self.recognitionTask = nil
    
    
  }
  private func toggleSearchViewShowing(show : Bool){
    if(show){
      centerYViewSpeech.constant = 0
      viewSpeechRecogShowing = true
      DispatchQueue.main.async {
//        self.imgViewSpeechRec.isUserInteractionEnabled = false
        self.topSearchBar.isUserInteractionEnabled = false
      }
      
    }else{
      centerYViewSpeech.constant = 1000
//      self.imgViewSpeechRec.isUserInteractionEnabled = true
      self.topSearchBar.isUserInteractionEnabled = true
      viewSpeechRecogShowing = false
    }
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
    
    
  }

}

//MARK:- UITableView Delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchSuggestionsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let searchResult = searchSuggestionsArray[indexPath.row]
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    cell.textLabel?.text = searchResult.title
    cell.detailTextLabel?.text = searchResult.subtitle
    return cell
    
//    let cell = searchTblView.dequeueReusableCell(withIdentifier: "SearchSuggestionTableViewCell", for: indexPath) as! SearchSuggestionTableViewCell
//    cell.searchSuggestionLbl.text = SearchLocationsSuggestions.instance.addressSuggestion[indexPath.row]
//
//    return cell
  }
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad{
//      return 90
//
//    }
//    else{
//      return 80
//
//    }
//  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let array = searchSuggestionsArray
    guard indexPath.row < array.count else {return}
    let instance = array[indexPath.row].title
    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
    vc.searchKeyword = instance
    self.navigationController?.pushViewController(vc, animated: true)
  }
}


//MARK:- UIPickerView Delegates
extension SearchViewController:UIPickerViewDataSource, UIPickerViewDelegate{
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == propertyTypePickerView{
      return propertyTypeArray.count
    }else if pickerView == spaceTypePickerView{
      return spaceTypeArray.count
    }else if pickerView == minPricePickerView{
      return minPricingArray.count
    }else if pickerView == maxPricePickerView{
      return maxPricingArray.count
    }else if pickerView == minSpacePickerView{
      return minSpaceArray.count
    }else if pickerView == maxSpacePickerView{
      return maxSpaceArray.count
    }else {
      return 0
      
    }
    
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == propertyTypePickerView{
      return propertyTypeArray[row] as String
    }else if pickerView == spaceTypePickerView{
      return spaceTypeArray[row] as String
    }else if pickerView == minPricePickerView{
      return minPricingArray[row] as String
    }else if pickerView == maxPricePickerView{
      return maxPricingArray[row] as String
    }else if pickerView == minSpacePickerView{
      return minSpaceArray[row] as String
    }else if pickerView == maxSpacePickerView{
      return maxSpaceArray[row] as String
    }else {
      return "N/A"
      
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == propertyTypePickerView{
      propertyTypeTf.text = propertyTypeArray[row] as String
      let postType = propertyTypeTf.text
      self.body["post_type"] = postType
    }else if pickerView == spaceTypePickerView{
      spaceTypeTf.text = spaceTypeArray[row] as String
      let spaceType = spaceTypeTf.text
      self.body["property_type"] = spaceType
    }else if pickerView == minPricePickerView{
      minPriceTf.text = minPricingArray[row] as String
      let minPrice = minPriceTf.text
      self.body["pricelowlimit"] = minPrice
    }else if pickerView == maxPricePickerView{
      maxPriceTf.text = maxPricingArray[row] as String
      let maxPrice = maxPriceTf.text
      self.body["pricehighlimit"] = maxPrice
    }else if pickerView == minSpacePickerView{
      minSpaceTf.text = minSpaceArray[row] as String
      let minSpace = minSpaceTf.text
      self.body["spacelowlimit"] = minSpace
    }else if pickerView == maxSpacePickerView{
      maxSpaceTf.text = maxSpaceArray[row] as String
      let maxSpace = maxSpaceTf.text
      self.body["spacehighlimit"] = maxSpace
    }
  }
}

extension SearchViewController: UITextFieldDelegate{



}

//MARK:- UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate{
  

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
      self.topSearchBar.resignFirstResponder()
      if( searchBar.text?.isEmpty)!{
        print("Search text is empty")
      }else{
        
        let searchText = searchBar.text!
        //self.selectedItemText = searchText
        
        //print("search text : \(String(describing: searchText))")
//        searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "moreHomeVC") as! moreHomeVC
        vc.searchKeyword = searchText
        self.navigationController?.pushViewController(vc, animated: true)
        //print("After adding percent to searchtext \(String(describing: searchText))")
//        var params = searchAPIParams()
//        params.query = searchText
//        urlToTableView = params.returnSearchString()
        //self.urlToTableView.append("/" + searchText)
        //print("before adding percentencoding \(self.urlToTableView)" )
        //self.urlToTableView = self.urlToTableView.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//        print("Final text i.e urlToTableView \(self.urlToTableView)")
//        performSegue(withIdentifier: "searchToTableVCProd", sender: self)
      }
      
      
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      if searchBar.text == nil || searchBar.text == ""{
  //      searchActive = false
//        titleview.micBtn.isHidden = false
  //      fidgetSpinner.isHidden = true
        self.searchSuggestionsArray.removeAll()
        
        DispatchQueue.main.async {
          self.searchTblView.reloadData()
        }
        toggleDimView(flag: false)
        
        
      }else {
//        self.titleview.micBtn.isHidden = true
//        let searchUrl = searchLocationsUrl + searchBar.text!
//        print(searchUrl)
  //      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
  //      {
        searchCompleter.queryFragment = searchText
//        getSuggestions(query: searchText)
//          SearchLocationsSuggestions.instance.getLocations(url: searchUrl){
//            (success) in
//            DispatchQueue.main.async {
//              self.searchTblView.reloadData()
//              self.toggleDimView(flag: false)
//            }
//          }
  //      }
      }
      
    }
  
}

extension SearchViewController: MKLocalSearchCompleterDelegate {

  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
      searchSuggestionsArray = completer.results
      searchTblView.reloadData()
  }
  
  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
      // handle error
  }

}
