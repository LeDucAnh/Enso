//
//  ViewController.swift
//  Enso
//
//  Created by Mac on 7/19/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import URLEmbeddedView
import YNSearch
import Navigation_stack
public enum GoogleTopicViewControllerType: String
{
    case googlesearch = "Search"
    case googlenews = "News Search"
}

class MainViewController: UIViewController {
    
    
    var cacheGoogleSearchItem = [[GoogleSearchItem]]()
    var    cacheGooglePostCellHeight = [[CGFloat]]()
    public var VCType  = GoogleTopicViewControllerType.googlenews
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Hide the navigation bar on the this view controller
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.view.bringSubview(toFront: self.navView)
    }
    
    
    let googletopicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoogleTopicElongationViewController") as! GoogleTopicElongationViewController
    
    var googletopicVCArr = [GoogleTopicElongationViewController]()
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
   
        
        
    }
    let urlList: [String] = [
        
        "https://www.soccer.com/","http://www.espnfc.us/","http://www.espnfc.us/scores", "https://en.wikipedia.org/wiki/Association_football","https://www.theatlantic.com/international/archive/2014/06/why-we-call-soccer-soccer/372771/","https://www.nytimes.com/2016/04/22/sports/soccer/usmnt-uswnt-soccer-equal-pay.html", "https://www.theguardian.com/football/2017/aug/01/didier-drogba-eden-hazard-owners-us-soccer-usl-nasl", "http://www.foxsports.com/soccer/schedule","https://www.mlssoccer.com/"
    ]
    
    let navView = LDACANavView()
    let searchViewController = LDAYNSearchViewController()
    
    func displaySearchViewController()
    {
        LDASingletonBlurView.shared.addBlurToView(view: self.searchViewController.view)
        LDASingletonBlurView.shared.addBlurToView(view: self.navView)
        
        self.searchViewController.view.layoutIfNeeded()
        
        
        UIView.animate(withDuration: 1, animations: {
            
            self.searchViewController.view.alpha = 1.0
        })
        self.view.bringSubview(toFront: self.searchViewController.view)
        self.searchViewController.view.frame = self.googletopicVC.view.frame
        print(self.searchViewController.ynSearchTextfieldView.frame)
        
        
        print(self.searchViewController.ynSearchView.frame)
        
        print(self.searchViewController.view.frame)
        
    }
    func hideSearchViewController()
    {
        UIView.animate(withDuration: 1, animations: {
            
            self.searchViewController.view.alpha = 0.0
        })
        self.view.sendSubview(toBack: self.searchViewController.view)
        
        
        self.searchViewController.view.frame = self.googletopicVC.view.frame
        
    }
    var options :BusyNavigationBarOptions!
    
    var nextBtn = UIButton()
    var backBtn  = UIButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
            navigationController!.interactivePopGestureRecognizer?.delegate = self
        
        self.view.addSubview(nextBtn)
        self.view.addSubview(backBtn)
        nextBtn.setTitle("Next", for: .normal)
        
        backBtn.setTitle("back", for: .normal)
        
        nextBtn.add(for: .touchUpInside) {
            //self.reloadTopicTableview(reloadTopicTableview)
            if let index =   self.cacheGoogleSearchItem.index(where: {$0.first === self.googletopicVC.webpages.first})
            {
                let real = index + 1
                
                
                
                
                self.cacheGooglePostCellHeight[index] = self.googletopicVC.heightValues
                self.reloadTableView(atIndex: real)
                
                self.loadmoreHandler()
                
                
                
                
            }
        }
        backBtn.add(for: .touchUpInside) {
            
            //self.reloadTopicTableview(reloadTopicTableview)
            if  let index =   self.cacheGoogleSearchItem.index(where: {$0.first === self.googletopicVC.webpages.first})
            {
                let real = index - 1
                
                self.cacheGooglePostCellHeight[index] = self.googletopicVC.heightValues
                
                self.reloadTableView(atIndex: real)
            }
            
            
        }
        
        
        let _ =  nextBtn.anchor(nil, left: self.backBtn.rightAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: -1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        let  _ = backBtn.anchor(nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.nextBtn.leftAnchor, topConstant: -1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: 60)
        
        self.searchViewController.view.alpha = 0.0
        self.searchViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.searchViewController.view.backgroundColor = UIColor.clear
        self.searchViewController.ynSearchView.backgroundColor = UIColor.clear
        
        self.navView.registerForReturnAction { (returnAction) in
            if returnAction == .leftButton
            {
                
                
                AppNavigatorHandler.shared.rootMenuVC.showMenu()
                //AppDelegate.SharedInstance.rootVC.showMenu()
                
            }
            if returnAction == .rightButton
            {
                self.searchViewController.ynSearchTextfieldView.cancelButton.cornerWithRadius(value: 15.0)
                self.searchViewController.ynSearchTextfieldView.ynSearchTextField.cornerWithRadius(value: 15.0)
                
                self.searchViewController.ynSearchTextfieldView.ynSearchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                self.searchViewController.ynSearchTextfieldView.cancelButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                
                
                
                let str = NSAttributedString(string: "Search", attributes: [NSForegroundColorAttributeName:UIColor.lightText])
                
                
                
                self.searchViewController.ynSearchTextfieldView.ynSearchTextField.attributedPlaceholder = str
                
                
                self.searchViewController.ynSearchTextfieldView.ynSearchTextField.tintColor = UIColor.lightText
                self.searchViewController.ynSearchTextfieldView.ynSearchTextField.textColor = UIColor.white
                
                if self.searchViewController.view.alpha == 0.0
                {
                    self.displaySearchViewController()
                }
                else
                {
                    self.hideSearchViewController()
                }
            }
            
        }
        
        LDAKeyboardHanlder.shareInstance.register(viewController: self, backgroundviews: [self.view,self.googletopicVC.tableView,self.googletopicVC.view])
        //setup navview
        self.navView.backgroundColor = UIColor.init(red: 38/255, green: 38/255, blue: 58/255, alpha: 0.8)
        self.navView.backgroundColor = UIColor.clear
        navView.embedToView(view: self.view)
        options = BusyNavigationBarOptions()
        navView.titleLabel.textColor = UIColor.white
        options.animationType = .stripes
        
        self.navView.titleLabel.text = self.VCType.rawValue
        
        
        
        //self.present(googletopicVC, animated:true, completion: nil)
        googletopicVC.view.backgroundColor = UIColor.white
        googletopicVC.tableView.backgroundColor = UIColor.clear
        googletopicVC.view.frame =  CGRect.zero
        
        
        
        self.view.addSubview(googletopicVC.view)
        googletopicVC.view.anchor(self.navView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: -1)
        googletopicVC.view.layoutSubviews()
        googletopicVC.view.layoutIfNeeded()
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        self.view.sendSubview(toBack: googletopicVC.view)
        
        print(googletopicVC.view.frame)
        print(googletopicVC.tableView.frame)
        
        /*
         GoogleNewsAPI.shareInstance.executewith(key: "hài hước", startvalue: 0, completion:
         {
         (array, error) -> Void in
         
         
         self.googletopicVC.webpages = array as! [GoogleSearchItem]
         
         
         
         self.googletopicVC.tableView.reloadData()
         
         
         
         })
         */
        
        let pastelView = PastelView()
        
        pastelView.frame =  self.view.frame
        
        pastelView.frame.size = CGSize(width: pastelView.frame.size.width, height: ElongationConfig.shared.topViewHeight)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        
        
        pastelView.setColors(EnglishSocietyConfigurateVaribles.SharedInstance.gradientArray.shuffled())
        pastelView.animationDuration = 1
        pastelView.startAnimation()
        
        self.view.addSubview(pastelView)
        self.view.sendSubview(toBack: pastelView)
        pastelView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: -1)
        
        
        
        self.view.addSubview(self.searchViewController.view)
        self.view.sendSubview(toBack: self.searchViewController.view)
        self.searchViewController.registerForReturnAction { (text) in
            
            self.currentsearchText = text
          
            self.navView.start(self.options)
            
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
                
             
                self.navigationController?.navigationBar.stop()
                self.navView.stop()
                
                
            }
            self.hideSearchViewController()
            
            self.searchHanlder()
            
            
        }
        
        self.googletopicVC.registerhanldeLoadMoreData {
            if self.currentsearchText != nil
            {
                
                //self.loadmoreHandler()
                
                
            }
            
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func searchHanlder()
    {
        if self.VCType.rawValue == GoogleTopicViewControllerType.googlesearch.rawValue
        {
            
            GoogleSearchAPI.shareInstance.executewith(key: self.currentsearchText, startvalue:0, completion:
                {
                    (array, error) -> Void in
                    
                
                    
                        
                        self.googletopicVC.webpages.removeAll()
                        self.googletopicVC.webpages.append(contentsOf: (array as! [GoogleSearchItem]))
                        
                        self.googletopicVC.setupCellHeights()
                        self.googletopicVC.isloadingMore = false
                        self.googletopicVC.tableView.reloadData()
                        
                        
                      
                        
                        self.navigationController?.navigationBar.stop()
                        self.navView.stop()
                        
                        
                        //save caching
                        self.cacheGoogleSearchItem = [self.googletopicVC.webpages]
                        self.cacheGooglePostCellHeight = [self.googletopicVC.heightValues]
                    
                    
                    
                    
            })
        }
        
        
        if self.VCType.rawValue == GoogleTopicViewControllerType.googlenews.rawValue
        {
            GoogleNewsLocalAPI.shareInstance.RequestGoogleNewsAPI(self.currentsearchText, start: 0, completion: { (array, err) in
                
              
                self.googletopicVC.webpages.removeAll()
                    self.googletopicVC.webpages.append(contentsOf: (array as! [GoogleSearchItem]))
                    self.googletopicVC.setupCellHeights()
                    
                    self.googletopicVC.isloadingMore = false
                    self.googletopicVC.tableView.reloadData()
                    
                    
                  
                    self.navigationController?.navigationBar.stop()
                    self.navView.stop()
                    
                    //save caching
                    self.cacheGoogleSearchItem = [self.googletopicVC.webpages]
                    self.cacheGooglePostCellHeight = [self.googletopicVC.heightValues]
                    self.loadmoreHandler()
                    
                    
              
                
                
            })
            
            /*
             GoogleNewsAPI.shareInstance.executewith(key: self.currentsearchText, startvalue: 0, completion:
             {
             (array, error) -> Void in
             
             DispatchQueue.main.async {
             self.googletopicVC.webpages.removeAll()
             self.googletopicVC.webpages.append(contentsOf: (array as! [GoogleSearchItem]))
             self.googletopicVC.setupCellHeights()
             
             self.googletopicVC.isloadingMore = false
             self.googletopicVC.tableView.reloadData()
             
             
             SwiftSpinner.hide()
             self.navigationController?.navigationBar.stop()
             self.navView.stop()
             
             //save caching
             self.cacheGoogleSearchItem = [self.googletopicVC.webpages]
             self.cacheGooglePostCellHeight = [self.googletopicVC.heightValues]
             
             }
             
             
             
             })
             */
        }
    }
    
    func reloadTableView( atIndex:Int)
    {
        self.googletopicVC.tableView.setContentOffset(CGPoint.zero, animated: false)
        
        self.googletopicVC.isloadingMore = false
        if atIndex <  self.cacheGoogleSearchItem.count &&  atIndex >= 0
        {
            
            
            
            self.googletopicVC.webpages =  (self.cacheGoogleSearchItem[atIndex])
            
            
            if self.cacheGooglePostCellHeight[atIndex] == nil
            {
                //load new
                
                self.googletopicVC.setupCellHeights()
                
                
            }
            else
            {
                
                //load previous one
                self.googletopicVC.heightValues = self.cacheGooglePostCellHeight[atIndex]
                
            }

            
            self.googletopicVC.tableView.reloadData()
            

            
        }
        
    }
    func savedToCache( _ array :   [GoogleSearchItem])
    {
        
        //self.googletopicVC.webpages.append(contentsOf: (array as! [GoogleSearchItem]))
        
        
        if array.count != 0
        {
            
            
            var heightArray = [CGFloat]()
            
            for item in array{
                heightArray.append(0)
            }
            // self.cacheGooglePostCellHeight.append(self.googletopicVC.heightValues)
            
            self.cacheGooglePostCellHeight.append(heightArray)
            
            self.cacheGoogleSearchItem.append((array as! [GoogleSearchItem]))
        }
        
        
        self.navigationController?.navigationBar.stop()
        self.navView.stop()
        
    }
    func loadmoreHandler()
    {
        
        
        
        if !(self.cacheGoogleSearchItem.last!.first === self.googletopicVC.webpages.first)
        {
            
            
            
            return
        }
        

        self.navView.start(self.options)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
            
      
            self.navigationController?.navigationBar.stop()
            self.navView.stop()
            
            
            
        }
        
        
        
        var i = 0
        for item in self.cacheGoogleSearchItem
        {
            for post in item{
                i += 1
            }
        }
        if self.VCType.rawValue == GoogleTopicViewControllerType.googlesearch.rawValue
        {
            
            GoogleSearchAPI.shareInstance.executewith(key: self.currentsearchText, startvalue: i, completion:
                {
                    (array, error) -> Void in
                    
                   
                    self.savedToCache(array)
                        
                    
                    
                    
                    
            })
        }
        if self.VCType.rawValue == GoogleTopicViewControllerType.googlenews.rawValue
        {
            
            GoogleNewsLocalAPI.shareInstance.RequestGoogleNewsAPI(self.currentsearchText, start: i, completion:
                {
                    (array, error) -> Void in
                    
                  
                    self.savedToCache(array)
                    
                    
                    
                    
            })
        }
        
        
    }
    var currentsearchText : String!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if navigationController?.viewControllers.count == 2 {
            return true
        }
        
        if let navigationController = self.navigationController as? NavigationStack {
            navigationController.showControllers()
        }
        
        return false
    }
}








