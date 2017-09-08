//
//  GoogleSearchAPI.swift
//  Enso
//
//  Created by Mac on 8/1/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import URLEmbeddedView
public typealias GoogleSearchAPICompletionHandler = ( [GoogleSearchItem], Error?) -> Swift.Void
public typealias GoogleSearchItemOGDataLoadCompletionHandler = ( OGData) -> Swift.Void
public class GoogleSearchItem
{
    var GoogleSearchItemURL : String!
    {
        didSet {
        
        self.GoogleSearchWebsiteTitle = self.GoogleSearchItemURL.components(separatedBy: "/")[2]
        
        }
    }
    var GoogleSearchItemDescription : String!
    var GoogleSearchTitle : String!
    var GoogleSearchImageURL : String!

    var GoogleSearchWebsiteTitle :String!
    
    var GoogleSearchOGData: OGData!
    {
        didSet
        {
            if GoogleSearchTitle == "" &&  GoogleSearchOGData.pageTitle != nil {
                self.GoogleSearchTitle = GoogleSearchOGData.pageTitle
            }
            if GoogleSearchItemDescription == "" &&  GoogleSearchOGData.pageDescription != nil {
                self.GoogleSearchItemDescription = GoogleSearchOGData.pageDescription
            }
            if self.GoogleSearchImageURL == "" && GoogleSearchOGData.imageUrl != nil
            {
                self.GoogleSearchImageURL = GoogleSearchOGData.imageUrl
            }


        }
    }
    init()
    {
        self.GoogleSearchItemURL = ""
        self.GoogleSearchItemDescription = ""
        self.GoogleSearchTitle = ""
        self.GoogleSearchImageURL = ""

        
    }
    init(dict : NSDictionary)
    {
        
        self.GoogleSearchItemURL = ""
        self.GoogleSearchItemDescription = ""
        self.GoogleSearchTitle = ""
        self.GoogleSearchImageURL = ""
        
        

        if let url  = dict["url"] as? String
        {
        self.GoogleSearchItemURL =    dict["url"] as! String
        }
        
        if let description  = dict["description"] as? String
        {

        self.GoogleSearchItemDescription = dict["description"] as! String
        
        }
        
        if let title  = dict["title"] as? String
        {

        
        self.GoogleSearchTitle = dict["title"] as! String

        }
        
        
    }
    
    func getWith(url:String,completion:@escaping GoogleSearchItemOGDataLoadCompletionHandler)
    {
       

        let view = URLEmbeddedView()
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 150)

        
    
        var validatedurl = url
        print(validatedurl.characters.last)
        if validatedurl.characters.last == "/"
        {
            print("yes")
            
            
            validatedurl.remove(at: validatedurl.index(before: validatedurl.endIndex))
        }
        print(validatedurl)

        view.loadURL(validatedurl) { (error) in
            
            self.GoogleSearchOGData = view.ogData
            print(view.ogData.imageUrl)
            completion(self.GoogleSearchOGData)
            
        }
        
        /*
        OGDataProvider.shared.fetchOGData(urlString: url) { [weak self] ogData, error in
        
         self?.GoogleSearchOGData = ogData
            
            print(ogData.debugDescription)
            print(ogData.imageUrl)
            print(ogData.sourceUrl)
            completion(ogData)
        }
         */

    }
    
}

class GoogleNewsAPI
{
    
    static var shareInstance = GoogleNewsAPI()
    
    var GoogleSearchAPI_URL = "https://lda1995flask.herokuapp.com/googlenews?query=GoogleSearchAPI_KEY&start=GoogleSearchAPI_START"
    
    func executewith(key:String,startvalue:Int, completion: GoogleSearchAPICompletionHandler!)
    {
        var urlString = GoogleSearchAPI_URL.replacingOccurrences(of: "GoogleSearchAPI_KEY", with: key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        urlString = urlString.replacingOccurrences(of: "GoogleSearchAPI_START", with: String(startvalue))
        
        let url = URL(string: urlString)
        
        
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let results = parsedData["results"] as! NSArray
                    
                    
                    var resultArr = [GoogleSearchItem]()
                    for item in results
                    {
                        if let dict =  item as? NSDictionary
                        {
                            let newtopic =   GoogleSearchItem(dict: dict)
                            resultArr.append(newtopic)
                            
                        }
                    }
                    completion(resultArr ,error)
                    
                    print("--------------------------------")
                    print(results)
                    
                    print("--------------------------------")
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }

    
}
class GoogleSearchAPI: NSObject {
 
    static var shareInstance = GoogleSearchAPI()
    var GoogleSearchAPI_URL = "https://lda1995flask.herokuapp.com/googlesearch?query=GoogleSearchAPI_KEY&start=GoogleSearchAPI_START"
    func executewith(key:String,startvalue:Int, completion: GoogleSearchAPICompletionHandler!)
    {
        var urlString = GoogleSearchAPI_URL.replacingOccurrences(of: "GoogleSearchAPI_KEY", with: key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        urlString = urlString.replacingOccurrences(of: "GoogleSearchAPI_START", with: String(startvalue))

        let url = URL(string: urlString)
        


        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let results = parsedData["results"] as! NSArray
                    
                    
                    var resultArr = [GoogleSearchItem]()
                    for item in results
                    {
                        if let dict =  item as? NSDictionary
                        {
                         let newtopic =   GoogleSearchItem(dict: dict)
                        resultArr.append(newtopic)
                            
                        }
                    }
                    completion(resultArr ,error)
                    
                    print("--------------------------------")
                    print(results)
                    
                    print("--------------------------------")
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()

    }
}
