//
//  GoogleSearchAPI.swift
//  Enso
//
//  Created by Mac on 8/1/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

class GoogleSearchAPI: NSObject {
 
    static var shareInstance = GoogleSearchAPI()
    var GoogleSearchAPI_URL = "https://lda1995flask.herokuapp.com/googlesearch?query=GoogleSearchAPI_KEY&start=GoogleSearchAPI_START"
    func executewith(key:String,startvalue:Int)
    {
        var urlString = GoogleSearchAPI_URL.replacingOccurrences(of: "GoogleSearchAPI_KEY", with: key)
        urlString = urlString.replacingOccurrences(of: "GoogleSearchAPI_START", with: String(startvalue))
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let currentConditions = parsedData["results"] as! String
                    
                    print("--------------------------------")
                    print(currentConditions)
                    
                    print("--------------------------------")
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()

    }
}
