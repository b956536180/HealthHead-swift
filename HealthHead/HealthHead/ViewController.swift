//
//  ViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/14.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*
        // Do any additional setup after loading the view, typically from a nib.
        //        var request = NSURLRequest(URL: NSURL(string: "http://api.yi18.net/news/list")!)
        HHConnectionOperation(URLString: "http://api.yi18.net/news/list", params: nil, success: { (response, responseObject) -> Void in
            println(responseObject)
            }) { (response, error) -> Void in
                
        }
        
        var req = NSURLRequest(URL: NSURL(string: "http://api.yi18.net/news/search?_dc=1389418170037&keyword=健康".URLEncoding())!)
        HHConnectionOperation(request: req, success: { (response, responseObject) -> Void in
            println("QQQQQQ \(response) \(responseObject )")
            }, failure: { (response, error) -> Void in
                println("\(error) \(response)")
        })
        
        HHConnectionOperation(URLString: "http://api.yi18.net/drug/show", params: ["id":"1"], success: { (response, responseObject) -> Void in
            println(responseObject)
            }) { (response, error) -> Void in
                println(response)
        }
        
        println("\n\n\n万能的分隔符\n\n\n\n\n")
        
        HHConnectionOperation(URLString: "http://api.yi18.net/drug/show?id=1", params: nil, success: { (response, responseObject) -> Void in
            println(responseObject)
            }) { (response, error) -> Void in
                println(response)
        }
        self.imageView.setImage(NSURL(string: "http://d.hiphotos.baidu.com/image/pic/item/b8014a90f603738d528e3113b01bb051f819ec3f.jpg")!, progress: { (bytesRead, bytesHaveRead, bytesExpected) -> Void in
            
            }, placeHolder: nil)
        
        self.imageView.setImage(NSURL(string: "http://d.hiphotos.baidu.com/image/pic/item/b8014a90f603738d528e3113b01bb051f819ec3f.jpg")!, placeHolder: nil)
        self.webView.loadFromURLString("http://www.baidu.com")
        var req2:NSURLRequest = NSURLRequest(URL: NSURL(string: "http://g.hiphotos.baidu.com/image/pic/item/e4dde71190ef76c62962347c9e16fdfaaf516731.jpg")!)
        HHConnectionOperation(request: req2, progress: { (bytesRead, bytesHaveRead, bytesExpected) -> Void in
            println("\(bytesRead)  \(bytesHaveRead)  \(bytesExpected) \n 进度 \(bytesHaveRead/bytesExpected)")
            }, success: { (response, responseObject) -> Void in
                println("\(response) \n  \n  \n(responseObject)")
            }, failure: { (response, error) -> Void in
                
            }, isJSON: false)
        println("\n\n\n")
        */
        HHConnectionOperation(URLString: "http://api.yi18.net/news/list", params: nil, success: { (response, responseObject) -> Void in
            println("\(response) \n\n\n \(responseObject)")
        }) { (response, error) -> Void in
            
        }
    }
    
    
}

