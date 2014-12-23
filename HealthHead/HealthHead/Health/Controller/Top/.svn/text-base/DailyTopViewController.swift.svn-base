//
//  DailyTopViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/27.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyTopViewController: RefreshTableViewController {
    var params:NSMutableDictionary = NSMutableDictionary()
    var data:NSMutableArray = NSMutableArray()
    var isLoadingMore:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "每日头条"
        getDataFromServerBy(nil)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DailyTopCell? = tableView.dequeueReusableCellWithIdentifier("dailytopcell") as? DailyTopCell
        cell?.fillCell( self.data.objectAtIndex(indexPath.row ) as DailyTopModel )
        return cell!
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("daily_top_news_detail", sender: data.objectAtIndex(indexPath.row) as DailyTopModel)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "daily_top_news_detail"{
            var controller:DailyTopDetailViewController = segue.destinationViewController as DailyTopDetailViewController
            var item = sender as DailyTopModel
            controller.id = item.id
            controller.hidesBottomBarWhenPushed = true
        }
    }
    override func refreshFootData() {
        isLoadingMore = true
        super.refreshFootData()
        getDataFromServerBy(nil)
    }
    override func refreshHeadData() {
        isLoadingMore = false
        super.refreshHeadData()
        getDataFromServerBy(nil)
    }
    
    
    
    
    func getDataFromServerBy(id:Int?){
        HHOperationHud.showHUDInView(self.view, message: "加载中")
        HHOperationHud.showHUDInView(UIApplication.sharedApplication().keyWindow!.rootViewController!.view, message: "玩命加载")
        var url:String = self.BASE_PARH + "top/list"
        if id != nil {
            params.removeObjectForKey("id")
            params.setValue(id, forKey: "id")
        }
        params.setValue(self.page, forKey: "page")
        
        HHConnectionOperation(URLString: url, params: params, success: { (response, responseObject) -> Void in
            println(responseObject)
            
            var dict:NSDictionary = responseObject as NSDictionary
            var data:NSArray = dict.objectForKey("yi18") as NSArray
            var models:NSMutableArray = NSMutableArray()
            for item in data {
                var it = item as NSDictionary
                var from:String? = it.valueForKey("from") as? String
                var keywords:String? = it.valueForKey("keywords") as? String
                var id:Int = it.valueForKey("id") as Int
                var img:String? = it.valueForKey("img") as? String
                var time:String? = it.valueForKey("time") as? String
                var title:String? = it.valueForKey("title") as? String
                
                var dailyTop:DailyTopModel = DailyTopModel(id: id, title: title, img: img,time:time,keywords:keywords,from:from)
                models.addObject(dailyTop)
            }
            data = models
            
            if self.isLoadingMore == false {
                self.data.removeAllObjects()
                self.data.addObjectsFromArray(data)
                self.tableView.reloadData()
            } else {
                
                var indexPathes = NSMutableArray()
                var from = self.data.count
                self.data.addObjectsFromArray(data)
                var to = self.data.count-1
                for index in from ... to  {
                    var indexPath = NSIndexPath(forItem: index, inSection: 0)
                    indexPathes.addObject(indexPath)
                }
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths(indexPathes, withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.endUpdates()
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            HHOperationHud.dismissHUDFromView(UIApplication.sharedApplication().keyWindow!.rootViewController!.view)
            
            }) { (response, error) -> Void in
                HHOperationHud.dismissHUDFromView(UIApplication.sharedApplication().keyWindow!.rootViewController!.view)
        }
    }
}
