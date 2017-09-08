
//
//  TaskContainable.swift
//  Enso
//
//  Created by Mac on 8/28/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import Foundation

protocol TaskContainable {
    associatedtype Completion
    
    var uuidString: String { get }
    var task: URLSessionDataTask { get }
    var completion: Completion? { get set }
    
    init(uuidString: String, task: URLSessionDataTask, completion: Completion?)
}
