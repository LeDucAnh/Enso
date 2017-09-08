//
//  LDASingletonBlurView.swift
//  Enso
//
//  Created by Mac on 8/12/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

class LDASingletonBlurView {

    static var shared = LDASingletonBlurView()

    let blurDarkEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))

    let blurLightEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
    let blurRegularEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.regular))
    
    var emptyDictionary = [UIView: UIVisualEffectView]()
    

    
    func addBlurToView(view:UIView)
    {
        
        
        
        if emptyDictionary[view] == nil
        {
            print("add blurview")
            
            
            let blurDarkEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))

            blurDarkEffectView.frame = view.bounds
            blurDarkEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurDarkEffectView)
            view.sendSubview(toBack: blurDarkEffectView)
            
             emptyDictionary[view] = blurDarkEffectView

        }

    }
}
