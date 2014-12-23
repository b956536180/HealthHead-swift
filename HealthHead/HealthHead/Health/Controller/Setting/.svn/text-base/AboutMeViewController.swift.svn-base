//
//  AboutMeViewController.swift
//  HealthHead
//
//  Created by Mave on 14/12/16.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class AboutMeViewController: BaseViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.dataDetectorTypes = UIDataDetectorTypes.None
        // Do any additional setup after loading the view.
        var infoPath = NSBundle.mainBundle().pathForResource("info", ofType: "html")
        var localURL = NSURL(fileURLWithPath: infoPath!)
        self.webView.loadURL(localURL!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none';")
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout='none';")
        
        
    }
}
