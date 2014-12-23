//
//  DailyTopDetailViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/27.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyTopDetailViewController: BaseViewController {
    var id:Int?
    var detailView:HeadDetailView?
    let base_path = "http://api.yi18.net/top/show"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Do any additional setup after loading the view.
        
        HHConnectionOperation(URLString: base_path, params: ["id":id!], success: { (response, responseObject) -> Void in
            var dict:NSDictionary = responseObject as NSDictionary
            var data:NSDictionary = dict.objectForKey("yi18") as NSDictionary
            self.mTitle = data.valueForKey("title") as? String
            self.subTitle = data.valueForKey("keywords") as? String
            var img:String? = data.valueForKey("img") as? String
            if img != nil {
                self.img = self.imageHost + img!
            }
            self.dateTime = data.valueForKey("time") as? String
            self.detail = data.valueForKey("message") as? String
            if self.detailView == nil {
                self.detailView = HeadDetailView(frame: UIScreen.mainScreen().bounds, title:self.mTitle, subTitle: self.subTitle, dateTime: self.dateTime, headImage: self.img, detail: self.detail)
                self.view.addSubview(self.detailView!)
                self.detailView?.saveController = self
            }
            }) { (response, error) -> Void in
                HHOperationHud.toas(rootView: self.view, message: "加载失败,请稍后重试")      
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func share(sender: AnyObject) {
        self.detailView!.onShare(rootController: self, excludedTypes: nil, weatherSavetoAlubm: true)
    }
    
}
