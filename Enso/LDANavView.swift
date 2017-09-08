//
//  LDACANavView.swift
//  LDAContactApp
//
//  Created by Mac on 5/18/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

public enum LDACANavViewReturnAction : Int
{
    case rightButton
    case leftButton
}
class LDACANavView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    //28 127 230
    var rightButton = UIButton()
    var leftButton = UIButton()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    
    var returnAction:((_ actionType : LDACANavViewReturnAction)->Void)!
    func registerForReturnAction(action:@escaping ( _ actionType : LDACANavViewReturnAction)->Void)
    {
        
        self.returnAction = action
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup()
    {
        
        self.rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.rightButton.addTarget(self, action: "rightButtonDidTouch", for: .touchDown)
        self.leftButton.addTarget(self, action: "leftButtonDidTouch", for: .touchDown)
    }
    func rightButtonDidTouch()
    {
        if self.returnAction != nil
        {

        self.returnAction(.rightButton)
        }
    }
    func leftButtonDidTouch()
    {
        
        if self.returnAction != nil
        {

        self.returnAction(.leftButton)
        }
    }
    func embedToView(view:UIView)
    {
        //setup Anchor
        
        self.addSubview(self.rightButton)
        self.addSubview(self.leftButton)
        
        self.addSubview(self.titleLabel)
        
        
        view.addSubview(self)
        
        
        
        self.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: 60)
        
        
        
        //self.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        
        
        self.rightButton.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: -1)
        
        self.rightButton.setTitle("Done", for: .normal)
        
        
        
        self.leftButton.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 70, heightConstant: 35)
        
        self.leftButton.setTitle("Back", for: .normal)
        
        self.leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.leftButton.imageView?.tintColor = UIColor.white
        
        self.layoutSubviews()
        print(self.frame)
        print(view.frame)
        
        
        self.titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: -1, heightConstant: -1)
        
        self.titleLabel.textAlignment = .center
        
        self.setup()
        
    }
    
}
