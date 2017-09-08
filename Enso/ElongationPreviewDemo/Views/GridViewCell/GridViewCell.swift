//
//  GridViewCell.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 20/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


class GridViewCell: UITableViewCell {
    @IBOutlet weak var cellBlurView: UIVisualEffectView!
  
    @IBOutlet weak var cellBackGroundImage: UIImageView!
    @IBOutlet weak var controlView: UIView!
  @IBOutlet var stackView: UIStackView!
    
    
    var webVC :  LDAWebVC!
     
   
    var cellImage = UIImage()

  var url = ""
  {
    didSet {
        
        
        }
    }

    let aboveContentGradientPastel = UIView()
    let abovegradient: CAGradientLayer = CAGradientLayer()

  override func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    
    
    
    self.controlView.addSubview(self.aboveContentGradientPastel)
    
    
   let _ =  self.aboveContentGradientPastel.anchor(self.controlView.topAnchor, left: self.controlView.leftAnchor, bottom: nil, right: self.controlView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: 55)
    
    self.controlView.sendSubview(toBack: self.aboveContentGradientPastel)
    
    
    self.controlView.layoutSubviews()
   
    DispatchQueue.main.async {
        
        //above
        
        self.contentView.backgroundColor = UIColor.clear
        self.abovegradient.colors = [UIColor.black.withAlphaComponent(0.55).cgColor,UIColor.clear.cgColor]
       // self.abovegradient.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,UIColor.clear.cgColor]
        
        self.abovegradient.locations = [0.0 , 1.0]
        self.abovegradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        self.abovegradient.endPoint = CGPoint(x: 0.05, y: 1)
        self.abovegradient.frame = CGRect(x: 0.0, y: 0.0, width: self.aboveContentGradientPastel.frame.size.width, height: self.aboveContentGradientPastel.frame.size.height )
        
        self.aboveContentGradientPastel.layer.insertSublayer(self.abovegradient, at: 0)
    }

    
   // self.bringSubview(toFront: self.aboveContentGradientPastel)
    
    self.bringSubview(toFront: self.controlView)
   // self.bringSubview(toFront: self.cellBackGroundImage)
   // self.bringSubview(toFront: self.cellBlurView)
    self.stackView.removeFromSuperview()
    
    


      self.webVC =  LDAWebVC(urlString: url)
     self.webVC.view.frame = self.frame
    
    
    self.webVC.view.frame.size = CGSize(width: EnglishSocietyConfigurateVaribles.SharedInstance.ScreenSize.width, height: EnglishSocietyConfigurateVaribles.SharedInstance.ScreenSize.height)
     
     webVC.delegate.registerFordidSelectaWord(callbackAction: { (word) in
     
     
     ESVocabularyOptionView.sharedInstante.show(word: word)
     
     })
    
   // self.addSubview(self.webVC.view)
    
    print(webVC.webView.scrollView.contentSize)
    webVC.webView.scrollView.contentSize = CGSize(width: EnglishSocietyConfigurateVaribles.SharedInstance.Screenwidth, height: webVC.webView.scrollView.contentSize.height)
    

    
    
    iterateSubviews(of: stackView)
    for case let stack as UIStackView in stackView.arrangedSubviews {
      iterateSubviews(of: stack)
    }
  }
  
  private func iterateSubviews(of view: UIStackView) {
    
    
    
    for case let imageView as UIImageView in view.arrangedSubviews {
      let imageName = String(arc4random_uniform(8) + 1)
      imageView.image = UIImage(named: imageName)
    }
  }
  
}
