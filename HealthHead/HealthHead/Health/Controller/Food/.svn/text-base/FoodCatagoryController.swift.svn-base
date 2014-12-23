//
//  FoodCatagoryController.swift
//  HealthHead
//
//  Created by Mave on 14/12/9.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class FoodCatagoryController: UITableViewController {
    var listData:NSMutableArray = NSMutableArray()
    var catagoryID:Int = 0
   weak var foodController:DailyFoodController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getDataFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.listData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foodcatagorycell") as UITableViewCell
        var item:FoodCatagoryModel = listData.objectAtIndex(indexPath.row) as FoodCatagoryModel
        
        cell.textLabel.text = item.name
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var item:FoodCatagoryModel = self.listData.objectAtIndex(indexPath.row) as FoodCatagoryModel
        if item.cookClass == 0{
            self.catagoryID = item.id!
            getDataFromServer()
        } else{
            self.navigationController?.popToRootViewControllerAnimated(true)
            if self.foodController != nil {
                self.foodController?.cataID = item.id!
                self.foodController?.barTitle = item.name
            self.foodController!.getDailyFoodList(false)
            }
        }
    }
    
    func getDataFromServer(){
        HHOperationHud.showHUDInView(self.view, message: "努力加载中")
        HHConnectionOperation(URLString: "http://api.yi18.net/cook/cookclass", params: ["id":self.catagoryID], success: { (response, responseObject) -> Void in
            
            HHOperationHud.dismissHUDFromView(self.view)
            var dict:NSDictionary = responseObject as NSDictionary
            var list = dict.valueForKey("yi18") as NSArray
            if self.listData.count > 0  {
                self.listData.removeAllObjects()
            }
            for item in list{
                var cataItem:FoodCatagoryModel = FoodCatagoryModel(params: item as NSDictionary)
                self.listData.addObject(cataItem)
            }
            self.tableView.reloadData()
            }) { (response, error) -> Void in
                
                HHOperationHud.dismissHUDFromView(self.view)
                HHOperationHud.toas(rootView: self.view, message: "加载失败")
        }
    }
    
}
