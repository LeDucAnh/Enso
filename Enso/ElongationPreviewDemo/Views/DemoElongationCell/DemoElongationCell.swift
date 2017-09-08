//
//  DemoElongationCell.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 09/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit
import ElongationPreview

import URLEmbeddedView
public enum DemoElongationCellBlurLayer:Int
{
    case above = 900
    case below = 901
}
public enum DemoElongationCellBottomAction : Int
{
    case web
    case comment
    case note
    
}
class DemoElongationCell: ElongationCell {
    
    
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    @IBOutlet weak var bottomContentBlurView: UIVisualEffectView!
    var canRemoveBlurView = false
    
    @IBOutlet weak var contentLayer: UIView!
    internal lazy var blurView: FXBlurView = {
        let blurView = FXBlurView(frame: .zero)
        blurView.blurRadius = 8
        blurView.isDynamic = true
        blurView.tintColor = UIColor.clear
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return blurView
    }()
    @IBOutlet weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBlurOverlay: UIVisualEffectView!

    @IBOutlet weak var imageBlackOverlay: UIView!
    
    @IBOutlet weak var fuckview: UIView!

    @IBOutlet var topImageView: UIImageView!
  @IBOutlet var localityLabel: UILabel!
  @IBOutlet var countryLabel: UILabel!
  
  @IBOutlet var aboutTitleLabel: UILabel!
  @IBOutlet var aboutDescriptionLabel: UILabel!
    let pastelView = PastelView()
    let embeddedView = URLEmbeddedView()
    
    
var loadFinish =  false
    override func awakeFromNib() {
        super.awakeFromNib()
        

        
        // Initialization code
        self.embeddedView.frame =  self.bounds
        self.embeddedView.frame.size = CGSize(width: self.embeddedView.frame.size.width, height: 150)
        
       // scalableView.addSubview(self.blurView)
            imageBlackOverlay.backgroundColor = UIColor.clear
        scalableView.sendSubview(toBack: self.pastelView)
        scalableView.bringSubview(toFront: topImageView)
        scalableView.bringSubview(toFront: imageBlackOverlay)

        topView.bringSubview(toFront: self.localityLabel)
        topView.bringSubview(toFront: self.countryLabel)
        
        self.fuckview.sendSubview(toBack: self.contentLayer)
        
        
        self.bringSubview(toFront: fuckview)
        
        self.setupPastel()
        self.setupContentGradientPastel()
        
        
        
        
        

    }
    var focus = false
    func stopFocusing(model:GoogleSearchItem)
    {
        
        self.contentLayer.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
        focus = false
        self.descriptionLabelHeightConstraint.constant = self.frame.size.height - 65
        let attributedLocality = NSMutableAttributedString(string:  model.GoogleSearchTitle.uppercased(), attributes: [
            NSFontAttributeName: UIFont.robotoFont(ofSize: 15, weight: .bold),
            
            NSForegroundColorAttributeName: UIColor.white
            ])
        
        
        self.localityLabel?.attributedText = attributedLocality
        
        self.countryLabel.isHidden =  true
        self.aboveContentGradientPastel.isHidden = false
        self.belowContentGradientPastel.isHidden = true
        self.imageBlackOverlay.isHidden =  false
        
    self.aboveContentGradientPastel.tag = DemoElongationCellBlurLayer.above.rawValue
print(self.abovegradient.frame)
        
     //  self.aboveContentGradientPastel.backgroundColor = UIColor.black
    }
    
    
    func focusReading(model:GoogleSearchItem)
    {
        
        focus = true
        self.contentLayer.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        
        
        
        self.imageBlurOverlay.isHidden  =  true
        
        
        self.countryLabel.isHidden = false
        
        self.imageBlackOverlay.isHidden =  true
        
        self.descriptionLabelHeightConstraint.constant = 35 + 15
        
        
        
        let attributedLocality = NSMutableAttributedString(string: model.GoogleSearchTitle.uppercased(), attributes: [
            NSFontAttributeName: UIFont.robotoFont(ofSize: 20, weight: .bold),
            NSKernAttributeName: 2.2,
            NSForegroundColorAttributeName: UIColor.white
            ])
        
        
        self.localityLabel?.attributedText = attributedLocality
        self.aboveContentGradientPastel.isHidden = true
        self.belowContentGradientPastel.isHidden = false
        

    }
    let aboveContentGradientPastel = UIView()
    let belowContentGradientPastel = UIView()
    let abovegradient: CAGradientLayer = CAGradientLayer()

    func setupContentGradientPastel()
    {
        // self.blurView.removeFromSuperview()
        
        
        
        self.fuckview.addSubview(self.aboveContentGradientPastel)
        self.aboveContentGradientPastel.anchor(self.fuckview.topAnchor, left: self.fuckview.leftAnchor, bottom: nil, right: self.fuckview.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: self.localityLabel.frame.height * 4/3)
        
        self.fuckview.sendSubview(toBack: self.aboveContentGradientPastel)

        
        
        self.fuckview.addSubview(self.belowContentGradientPastel)
        self.belowContentGradientPastel.anchor(nil, left: self.fuckview.leftAnchor, bottom: self.fuckview.bottomAnchor, right: self.fuckview.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: self.countryLabel.frame.height * 4/3)
        
        self.fuckview.sendSubview(toBack: self.belowContentGradientPastel)
        
        

        
        
        self.fuckview.layoutIfNeeded()
       
        
        
        DispatchQueue.main.async {
            
            //above

            
            self.abovegradient.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,UIColor.clear.cgColor]
            self.abovegradient.locations = [0.0 , 1.0]
            self.abovegradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            self.abovegradient.endPoint = CGPoint(x: 0.05, y: 0.9)
            self.abovegradient.frame = CGRect(x: 0.0, y: 0.0, width: self.aboveContentGradientPastel.frame.size.width, height: self.aboveContentGradientPastel.frame.size.height )
            
            self.aboveContentGradientPastel.layer.insertSublayer(self.abovegradient, at: 0)
            
            //below
            let belowgradient: CAGradientLayer = CAGradientLayer()
            
            belowgradient.colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(1.0).cgColor]
            belowgradient.locations = [0.0 , 1.0]
            belowgradient.startPoint = CGPoint(x: 0.05, y: 0.0)
            belowgradient.endPoint = CGPoint(x: 0.0, y: 0.9)
            belowgradient.frame = CGRect(x: 0.0, y: 0.0, width: self.belowContentGradientPastel.frame.size.width, height: self.belowContentGradientPastel.frame.size.height )
            
            self.belowContentGradientPastel.layer.insertSublayer(belowgradient, at: 0)
            self.belowContentGradientPastel.isHidden = true
            
        }
        self.topImageView.backgroundColor = UIColor.clear
        
        
        

    }
    func setupBlurView()
    {
        
        
        
       // self.blurView.removeFromSuperview()

    
    if   !self.scalableView.subviews.contains(self.blurView)
            
        {
            
            
            self.scalableView.addSubview(self.blurView)
            self.blurView.anchor(self.scalableView.topAnchor, left: self.scalableView.leftAnchor, bottom: self.scalableView.bottomAnchor, right: self.scalableView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: -1)
            
            
            self.scalableView.layoutSubviews()
            
            self.scalableView.bringSubview(toFront: self.imageView!)
            self.scalableView.bringSubview(toFront: self.blurView)
            self.blurView.isDynamic =  true
            print(self.blurView.frame)

            

        }
        

    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }

  @IBOutlet var topImageViewTopConstraint: NSLayoutConstraint!
    func setupPastel()
    {
        
        
        self.scalableView.addSubview(self.pastelView)
        self.pastelView.anchor(self.scalableView.topAnchor, left: self.scalableView.leftAnchor, bottom: self.scalableView.bottomAnchor, right: self.scalableView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: -1)
        
        self.scalableView.sendSubview(toBack: self.pastelView)

    
        self.scalableView.layoutSubviews()
        pastelView.frame =  self.frame
        
        pastelView.frame.size = CGSize(width: pastelView.frame.size.width, height: ElongationConfig.shared.topViewHeight)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration

        
        // Custom Color
        

        
  
        
        DispatchQueue.main.async {

        
        
         self.pastelView.setColors(EnglishSocietyConfigurateVaribles.SharedInstance.gradientArray.shuffled())
        self.pastelView.animationDuration = 2
        self.pastelView.startAnimation()
             }
        self.topImageView.backgroundColor = UIColor.clear
        
       
        //topView.insertSubview(pastelView, at: 0)
        //topView.bringSubview(toFront: self.pastelView)
    }
    
}
