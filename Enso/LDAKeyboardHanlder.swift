//
//  LDAKeyboardHanlder.swift
//  LDAContactApp
//
//  Created by Mac on 6/16/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

extension UIViewController {
    func keyboardWillBeShow(sender: NSNotification) {

LDAKeyboardHanlder.shareInstance.keyboardIsShowing = true
    }
    
    func keyboardWillBeHide(sender: NSNotification) {
       LDAKeyboardHanlder.shareInstance.keyboardIsShowing = false
    }

    
    func setupKeyboardNoti()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillBeShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillBeHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
func hideKeyboardWhenTappedAround() {
    
    setupKeyboardNoti()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func hideKeyboardWhenTappedAround(backgroundview:UIView) {
        
        setupKeyboardNoti()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        backgroundview.addGestureRecognizer(tap)
    }
    
    func hideKeyboardWhenTappedAround(views:[UIView]) {

        setupKeyboardNoti()
        for item in views
        {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            
        tap.cancelsTouchesInView = false
        item.addGestureRecognizer(tap)
        }
    }
    


    
    func dismissKeyboard() {
        
        if LDAKeyboardHanlder.shareInstance.keyboardIsShowing
        {
            LDAKeyboardHanlder.shareInstance.justDidMiss = true
        
        view.endEditing(true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            LDAKeyboardHanlder.shareInstance.justDidMiss =  false
        }

        
    }
}

class LDAKeyboardHanlder: NSObject {
  
    var keyboardIsShowing = false
    var justDidMiss = false
   static var shareInstance = LDAKeyboardHanlder()

    var curerntViewController = UIViewController()
    
    
    var backgroundView : UIView!
    let TapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    
    
    func register(viewController : UIViewController,backgroundviews:[UIView])
    {
        viewController.hideKeyboardWhenTappedAround(views: backgroundviews)
        
    }
    
    
    func register(viewController : UIViewController,withBackGroundView: UIView)
    {
        curerntViewController = viewController
       // curerntViewController.hideKeyboardWhenTappedAround()
        
        curerntViewController.hideKeyboardWhenTappedAround(backgroundview: withBackGroundView)

    }

    
    
    func register(viewController : UIViewController)
    {
        
        
        curerntViewController = viewController
        curerntViewController.hideKeyboardWhenTappedAround()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(LDAKeyboardHanlder.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(LDAKeyboardHanlder.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /*
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            
            
            
            self.curerntViewController.view.addGestureRecognizer(TapGestureRecognizer)
            
         //   curerntViewController.view.addTarget(self, action: #selector(self.tapBlurButton(_:)), forControlEvents: .TouchUpInside)
            

        }
    }
    
    func dismissKeyboard() {

    
    self.curerntViewController.view.endEditing(true)
    
    }

    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            
            
            if (curerntViewController.view.gestureRecognizers?.contains(TapGestureRecognizer))!
            {
                
                curerntViewController.view.removeGestureRecognizer(TapGestureRecognizer)
            }

            
            
            
        }
    }

 */
    
    /*override func viewDidLoad() {
     super.viewDidLoad()
     NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
     NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
     }
     
     func keyboardWillShow(notification: NSNotification) {
     if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
     if self.view.frame.origin.y == 0{
     self.view.frame.origin.y -= keyboardSize.height
     }
     }
     }
     
     func keyboardWillHide(notification: NSNotification) {
     if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
     if self.view.frame.origin.y != 0{
     self.view.frame.origin.y += keyboardSize.height
     }
     }
     }
*/
}
