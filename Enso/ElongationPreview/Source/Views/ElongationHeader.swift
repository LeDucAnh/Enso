//
//  ElongationHeader.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 14/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit


/// Expanded copy of `ElongationCell`.
open class ElongationHeader: UIView, Expandable {
  
  /// Container of all the subviews.
  public var contentView: UIView = UIView()
  
  /// View on top half of `contentView`.
  /// Add here all the views which wont be scaled and must stay on their position.
  public var topView: UIView!
  
  /// This is the front view which can be scaled if `scaleFactor` was configured in `ElongationConfig`.
  /// Also to this view can be applied 'parallax' effect.
  public var scalableView: UIView!
  
  /// The view which comes from behind the cell when you tap on the cell.
  public var bottomView: UIView!
  
  /// `top` constraint of `bottomView`.
  public var bottomViewTopConstraint: NSLayoutConstraint!
    public var aboveGradientView: UIView!

  fileprivate var appearance: ElongationConfig {
    return ElongationConfig.shared
  }
  
  /// :nodoc:
  override open var intrinsicContentSize: CGSize {
    //thisistheproblem
    let height = appearance.topViewHeight + appearance.bottomViewHeight
    let width = UIScreen.main.bounds.width
    return CGSize(width: width, height: height)
  }
  
  /// :nodoc:
  open override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }
}


// MARK: - ElongationCell -> ElongationHeader
extension ElongationCell {
  
  var elongationHeader: ElongationHeader {
    guard let copy = cellCopy else { return ElongationHeader() }
    let elongationHeader = ElongationHeader()
    elongationHeader.contentView = copy.contentView
    elongationHeader.topView = copy.topView
    elongationHeader.scalableView = copy.scalableView
    elongationHeader.bottomView = copy.bottomView
    
    elongationHeader.bottomViewTopConstraint = copy.bottomViewTopConstraint
   //newcode
    
    
    
    elongationHeader.addSubview(copy.contentView)
    return elongationHeader
  }


  
}
extension DemoElongationCell {
    
    
    func setupContent(_ newElongationHeader:ElongationHeader)
    {
        let abovegradient: CAGradientLayer = CAGradientLayer()
        
        abovegradient.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,UIColor.clear.cgColor]
        abovegradient.locations = [0.0 , 1.0]
        abovegradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        abovegradient.endPoint = CGPoint(x: 0.05, y: 0.9)
        abovegradient.frame = CGRect(x: 0.0, y: 0.0, width: aboveContentGradientPastel.frame.size.width, height: aboveContentGradientPastel.frame.size.height )
        
        newElongationHeader.aboveGradientView.layer.insertSublayer(abovegradient, at: 0)
    }
 override var elongationHeader: ElongationHeader {
        guard let copy = cellCopy else { return ElongationHeader() }
        let elongationHeader = ElongationHeader()
        elongationHeader.contentView = copy.contentView
        elongationHeader.topView = copy.topView
        elongationHeader.scalableView = copy.scalableView
        elongationHeader.bottomView = copy.bottomView
    
        elongationHeader.bottomViewTopConstraint = copy.bottomViewTopConstraint
        //newcode
        elongationHeader.aboveGradientView = (copy as! DemoElongationCell).aboveContentGradientPastel
    
    
    
    for subview in elongationHeader.topView.subviews
    {
        for subview in subview.subviews{
            
        for subview in subview.subviews
        {
         if subview.tag == DemoElongationCellBlurLayer.above.rawValue
         {
         let abovegradient: CAGradientLayer = CAGradientLayer()
         
         abovegradient.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,UIColor.clear.cgColor]
         abovegradient.locations = [0.0 , 1.0]
         abovegradient.startPoint = CGPoint(x: 0.0, y: 0.0)
         abovegradient.endPoint = CGPoint(x: 0.05, y: 0.9)
         abovegradient.frame = CGRect(x: 0.0, y: 0.0, width: aboveContentGradientPastel.frame.size.width, height: aboveContentGradientPastel.frame.size.height )
         
         subview.layer.insertSublayer(abovegradient, at: 0)
         
         
                }
            }
        }
    }

    
    
        elongationHeader.addSubview(copy.contentView)
        return elongationHeader
    }
    
}

