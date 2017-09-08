//
//  AppNavigatorHandler.swift
//  Enso
//
//  Created by Mac on 8/13/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

public enum AppNavigatorHandlerVCKey : Int
{
    case rootMenuViewController
    case googleSearchViewController
    case googleNewsViewController

}
class AppNavigatorHandler: NSObject {
    static var shared = AppNavigatorHandler()
    var rootMenuVC  : MenuContentViewController!
    var newsVC : MainViewController!
    var searchVC : MainViewController!
    

}
