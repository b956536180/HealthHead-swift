//
//  TabBarVController.swift
//  HealthHead
//
//  Created by Mave on 14/11/28.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
extension UITabBarController{
    public  func showTabbar(){
        //        self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(UIScreen.mainScreen().bounds))
        if self.tabBar.hidden == true{
            
            self.tabBar.hidden = false
            for controller in self.viewControllers! {
                controller.view!?.frame =  CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(UIScreen.mainScreen().bounds) )
            }
        }
    }
    public  func hiddenTabbar(){
        
        if self.tabBar.hidden == false {
            self.tabBar.hidden = true
            for controller in self.viewControllers! {
                controller.view!?.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(UIScreen.mainScreen().bounds) + 49 )
            }
            self.tabBar.hidden = true
        }
    }
}
public class TabBarVController: UITabBarController ,UITabBarControllerDelegate{
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        self.selectedIndex = 1
        for controller in self.viewControllers! {
            controller.view!?.frame = UIScreen.mainScreen().bounds
            
        }

    }
   

   }
