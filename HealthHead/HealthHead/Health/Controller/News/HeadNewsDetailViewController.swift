//
//  HeadNewsDetailViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/22.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit


//新闻详情页面
class HeadNewsDetailViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {
    var id:Int?
    var headImage:String?
    var detail:HeadDetailView?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        HHOperationHud.showHUDInView(self.view, message: "努力加载中")
        loadData()
        self.title = "健康头条"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func loadData(){
        if self.id != nil {
            HHOperationHud.showHUDInView(self.view, message: "加载中")
            HHConnectionOperation(URLString: "http://api.yi18.net/news/show", params: ["id":self.id!], success: { (response, responseObject) -> Void in
                println(responseObject)
                var webView:UIWebView = UIWebView(frame: CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)))
                webView.delegate = self
                webView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                var data:NSDictionary = responseObject as NSDictionary
                data = data.objectForKey("yi18") as NSDictionary
                var message:String? = data.objectForKey("message") as? String
                var tag:String? = data.objectForKey("tag") as? String
                var title:String? = data.objectForKey("title") as? String
                var time:String? = data.objectForKey("time") as? String
                
                self.title = tag
                if message != nil {
                     self.detail = HeadDetailView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)), title: title, subTitle: tag, dateTime: time, headImage: self.headImage,detail:message)
                    self.detail!.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
                    self.detail!.saveController = self
                    self.view.addSubview(self.detail!)
                }
                HHOperationHud.dismissHUDFromView(self.view)
                }, failure: { (response, error) -> Void in
HHOperationHud.dismissHUDFromView(self.view)
            })
        }
        
    }
    
    
    @IBAction func share(sender: AnyObject) {
        self.detail!.onShare(rootController: self, excludedTypes: nil, weatherSavetoAlubm: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
