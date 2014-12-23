//
//  DailyFoodDetailController.swift
//  HealthHead
//
//  Created by Mave on 14/11/29.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyFoodDetailController: BaseViewController {
    var item:DailyFoodModel?
    var detailView:HeadDetailView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HHConnectionOperation(URLString: "http://api.yi18.net/cook/show", params: ["id":item!.id!], success: { (response, responseObject) -> Void in
            println(responseObject)
            var data:NSDictionary =  (responseObject as NSDictionary)
            data = data.valueForKey("yi18") as NSDictionary
            
            self.detailView = HeadDetailView(frame: self.view.bounds, title: data.valueForKey("name") as? String, subTitle: data.valueForKey("tag") as? String, dateTime: nil, headImage: self.item!.imageHost + (data.valueForKey("img") as String), detail: data.valueForKey("message") as? String )
            self.view.addSubview(self.detailView!)
            self.detailView?.saveController = self
        }) { (response, error) -> Void in
            HHOperationHud.toas(rootView: self.view, message: "加载失败,请稍后重试")
        }
    }

    @IBAction func share(sender: AnyObject) {
        self.detailView!.onShare(rootController: self, excludedTypes: nil, weatherSavetoAlubm: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
