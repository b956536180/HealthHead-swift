//
//  BaseViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/27.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var mTitle:String?
    var subTitle:String?
    var dateTime:String?
    var img:String?
    var detail:String?
    var imageHost:String = "http://www.yi18.net/"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
self.navigationController?.navigationBar.translucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
