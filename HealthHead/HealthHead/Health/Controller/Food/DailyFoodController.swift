//
//  DailyFoodController.swift
//  HealthHead
//
//  Created by Mave on 14/11/28.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyFoodController: RefreshTableViewController {
    var list:NSMutableArray = NSMutableArray()
    var cataID:Int = 0
    var  barTitle:String = "饮食"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = barTitle
        refreshHeadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DailyFoodCell? = tableView.dequeueReusableCellWithIdentifier("dailyfoodcell") as? DailyFoodCell
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell?.fillCell(list.objectAtIndex(indexPath.row) as BaseModel)
        return cell!
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.list.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.performSegueWithIdentifier("daily_food_detail", sender: self.list.objectAtIndex(indexPath.row))
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "daily_food_detail" {
            var controller:DailyFoodDetailController = segue.destinationViewController as DailyFoodDetailController
            controller.item = sender as? DailyFoodModel
            controller.hidesBottomBarWhenPushed = true
        }
        if segue.identifier == "food_catagory" {
            var controller:FoodCatagoryController = segue.destinationViewController as FoodCatagoryController
            controller.foodController = self
            controller.hidesBottomBarWhenPushed = true
            
        }
    }
    override func refreshFootData() {
        super.refreshFootData()
        getDailyFoodList(true)
    }
    override func refreshHeadData() {
        super.refreshHeadData()
        getDailyFoodList(false)
    }
    func getDailyFoodList(isLoadingMore:Bool){
        HHConnectionOperation(URLString: "http://api.yi18.net/cook/list", params: ["page":page,"limit":20,"id":self.cataID], success: { (response, responseObject) -> Void in
            println(responseObject)
            var dict:NSDictionary = responseObject as NSDictionary
            var dataList:NSArray = dict.valueForKey("yi18") as NSArray
            if dataList.count <= 0{
                HHOperationHud.toas(rootView: self.view, message: "此项暂无数据");
                return
            }
            self.title = self.barTitle
            if isLoadingMore == false {
                self.list.removeAllObjects()
            }
            var fcount:Int?
            var count:Int?
            var id:Int?
            var name:String?
            var img:String?
            
            
            for item in dataList {
                var itemDict:NSDictionary = item as NSDictionary
                
                fcount = itemDict.valueForKey("fcount") as? Int
                count = itemDict.valueForKey("count") as? Int
                id = itemDict.valueForKey("id") as? Int
                name   = itemDict.valueForKey("name") as? String
                img = itemDict.valueForKey("img") as? String
                
                var dailyFoodModel:DailyFoodModel = DailyFoodModel(id: id, name: name, count: count, fcount: fcount, img: img)
                self.list.addObject(dailyFoodModel)
            }
            if isLoadingMore == false{
                self.tableView.reloadData()
            } else {
                var from:Int = self.tableView.numberOfRowsInSection(0)
                var to: Int = self.list.count - 1
                var indexPathes:NSMutableArray = NSMutableArray()
                for index in from ... to {
                    var indexPath:NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
                    indexPathes.addObject(indexPath)
                }
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths(indexPathes, withRowAnimation: UITableViewRowAnimation.Fade)
                self.tableView.endUpdates()
            }
            
            }) { (response, error) -> Void in
                
        }
    }
 
    
    @IBAction func choseFoodCatagory(sender: AnyObject) {
        self.performSegueWithIdentifier("food_catagory", sender: nil)
    }
    
}
