//
//  GoogleNewsLocalAPI.swift
//  Enso
//
//  Created by Mac on 8/22/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit

import Kanna
import Foundation
import URLEmbeddedView

class GoogleNewsLocalAPI:NSObject
{
    static var shareInstance = GoogleNewsLocalAPI()
    var GoogleSearchNewsAPI_URL = "http://www.google.com.vn/search?q=GOOGLESEARCHQUERY&start=GOOGLESEARCHSTART&tbm=nws&hl=GOOGLESEARCHLANGUAGE"
    var webview = UIWebView()
    var helloWorldTimer :Timer?
    var currentword = ""
    func refreshWebview()
    {
        
        /*
         let myURLString = "http://www.google.com.vn/search?q=GOOGLESEARCHQUERY&start=GOOGLESEARCHSTART&tbm=nws"
         
         if    let myURL = URL(string: myURLString) {
         
         let req = URLRequest(url: myURL)
         //  webview.delegate = self
         webview.loadRequest(req as URLRequest)
         //
         
         }
         */
    }
    
    @objc   func sayHello()
    {
        
        NSLog("hello World")
        let string = self.webview.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")!
        // let word = ";body=" + self.currentCheckingWord!
        
        //this might cause error
        
        //   if !string.contains(word)
        // {
        //   return
        //}
        
        
        
        let checkString = "url=/search?q=GOOGLECHECKWORD"
        
        //   if (!string.contains(checkString.replacingOccurrences(of: "GOOGLECHECKWORD", with: currentword)))
        if (!string.contains("g") ||  !string.contains("_hJs") ||   !string.contains("l _PMs") ||  !string.contains("st") )
            // if (!string.contains("_H1p _IBh") || !string.contains("_i2p") || !string.contains("_h2p") || !string.contains("_k2p") )
            //image _h2p
            
        {
            
            /*  mobile user-agent structure
             _H1p _IBh  -- root
             _i2p image
             "_h2p" image url
             _k2p title
             
             
             */
        }
        else{
            
            
            //stop
            let doc = try HTML(html: string, encoding: String.Encoding.utf8)
            
            
            var   resultArray = [GoogleSearchItem]()
            for item in (doc?.xpath("//div[@class=\"g\"]"))!
            {
                
                
                /*    for link in doc.xpath("//a | //link") {
                 print(link.text)
                 print(link["href"])
                 }
                 */
                
                for parsed in (item.xpath("*/div[@class=\"_hJs\"]"))
                {
                    let newitem = GoogleSearchItem()
                    
                    
                    for value in (item.xpath("*/*/img[@class=\"th _RGs\"]"))
                    {
                        newitem.GoogleSearchImageURL = value["src"]
                        
                    }
                    
                    for value in (parsed.xpath("*/a[@class=\"l _PMs\"]"))
                    {
                        
                        
                        //  print(image.text)
                        //GoogleSearchImageURL	String!	"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAGQAZAMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUCAwYBB//EACoQAAICAgEDAgUFAQAAAAAAAAABAgMEEQUSIUEGMVFhcYGRExQiMkIV/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/APhoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACZg8Zn8h1/scO/I6FuX6Vblr8EWUXCTjJNNPTT90BiCTHCypY7yVj2OiPvYovpX1ZprhKySjBbbAwBMlx2SsaWRGMbKYtKU65KSi37b17e3ks/TnAz5W3wkltt+yXxAoAdzZ6TxMnFunxudi5c6knOFNsZOPz7ePn7HIX4V1WX+36G7G9JICKCTPDthXKxdE4Q11Oual07+OjTGuc1Jxi2orcmvCAwB7oylXOMYylFqMv6tr3+gGAPQBtx77sa+u7HtnVbXLqhOL04v4om+o+Qq5Tm8vNor6IXT6kta29JN/dpv7laAJnFZf7LL/Wl3g65wnHW1NSi1p/Lua8J19c67ZqEbIOKm1vpfuvt219yOALXF5C7jsLNxq8iLhmVqudcHtS1JNN9vGu31Or9Ifo8hwufxqtqx7sqh112z7JSfx14etP5M+fm/EzLsSfVTJoDufTXDZvpzPu5DlJU0whRZXGMbozdrktf5b0vPfvtIq+Py+MyPUdv/AFLZ04ttNlTtrj1ODlFpSS+uily+by8qHTZN6+pWt7e2+4Fk1HBdz"...	some
                        
                        // print(value["src"])
                        newitem.GoogleSearchItemURL = value["href"]
                        //   print(value["href"])
                        
                        newitem.GoogleSearchTitle = value.text
                        
                        
                    }
                    
                    for description in (parsed.xpath("div[@class=\"st\"]"))
                    {
                        newitem.GoogleSearchItemDescription = description.text
                        
                    }
                    
                    
                    resultArray.append(newitem)
                    
                    
                }
            }
            
            /*
             for item in (doc?.xpath("//g-card-section[@class=\"_H1p _IBh\"]"))!
             {
             let newitem = GoogleSearchItem()
             
             
             
             for imageroot in (item.xpath("a[@class=\"_i2p\"]"))
             {
             
             for image in (imageroot.xpath("img[@class=\"_h2p\"]"))
             {
             
             //  print(image.text)
             
             
             print(image["src"])
             newitem.GoogleSearchImageURL = image["src"]
             //  print(image["href"])
             
             }
             
             }
             for title in (item.xpath("a[@class=\"_k2p\"]"))
             {
             newitem.GoogleSearchTitle = title.text
             newitem.GoogleSearchItemURL = title["href"]
             }
             resultArray.append(newitem)
             }
             */
            
            UserDefaults.standard.register(defaults: ["UserAgent": AppDelegate.SharedInstance.sourceUserAgent])
            
            
            var ogDataArr = [OGData]()
            for item in resultArray
            {
                item.getWith(url: item.GoogleSearchItemURL, completion: { (OGData) in
                        ogDataArr.append(OGData)
                        if ogDataArr.count == resultArray.count
                        {
                            self.returnAction(resultArray,nil)

                        }
                    
                    
                    
                })
            }
            
            
            //   self.helloWorldTimer?.invalidate()
            //     self.helloWorldTimer = nil
            // self.webview.delegate =  nil
            self.refreshWebview()
            
            
            
        }
    }
    
    /*
     private  func readFromCurrentWebview()
     {
     
     
     //       let when = DispatchTime.now() + 0.2 // change 2 to desired number of seconds
     // DispatchQueue.main.asyncAfter(deadline: when) {
     //self.sayHello()
     
     if self.helloWorldTimer == nil
     {
     // self.helloWorldTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.sayHello), userInfo: nil, repeats: true)
     }
     let when = DispatchTime.now() + 10 // change 2 to desired number of seconds
     DispatchQueue.main.asyncAfter(deadline: when) {
     
     //  DispatchQueue.main.async {
     
     
     self.helloWorldTimer?.invalidate()
     self.helloWorldTimer = nil
     
     // self.refreshWebview()
     //   }      //  }
     
     }
     
     
     return
     
     
     
     
     // }
     
     }
     */
    var returnAction : GoogleSearchAPICompletionHandler!
    
    func RequestGoogleNewsAPI(_ word:String,start:Int,language:String = "vi", completion: GoogleSearchAPICompletionHandler!)
        
    {
        UserDefaults.standard.register(defaults: ["UserAgent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11"])
        self.returnAction = completion
        
        self.currentword = word
        
        if !((UIApplication.shared.keyWindow! as UIWindow).rootViewController?.view.subviews.contains(self.webview))!
        {
            
            (UIApplication.shared.keyWindow! as UIWindow).rootViewController?.view.addSubview(webview)
        }
        
        webview.frame  = CGRect(x: 0, y: 320, width: 320, height: 200)
        webview.frame  = CGRect(x: -3333, y: -3333, width: 0, height: 0)
        
        
        
        
        (UIApplication.shared.keyWindow! as UIWindow).rootViewController?.view.bringSubview(toFront: webview)
        
        
        var myURLString = GoogleSearchNewsAPI_URL
        myURLString = myURLString.replacingOccurrences(of: "GOOGLESEARCHSTART", with: String(start))
        
        myURLString = myURLString.replacingOccurrences(of: "GOOGLESEARCHLANGUAGE", with: String(EnglishSocietyConfigurateVaribles.SharedInstance.AppLanguage))
        
        let URLString = myURLString.replacingOccurrences(of: "GOOGLESEARCHQUERY", with: word.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)
        
        
        if    let myURL = URL(string: URLString) {
            
            let req = URLRequest(url: myURL)
            webview.delegate = self
            
            
            webview.loadRequest(req as URLRequest)
            // https://translate.google.com/m/translate
            
            
            //  DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            // self.currentCheckingWord = word
            
            // self.readFromCurrentWebview()
            //}
            
            
            
            
        }
    }
    
    
    
}
extension GoogleNewsLocalAPI: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading {
            // still loading
            return
        }
        
        print("finished")
        
        self.sayHello()
        
        
        // finish and do something here
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: Error?) {
        print("didFailLoadWithErrofr \(String(describing: error?.localizedDescription))")
        // error happens
    }
}

