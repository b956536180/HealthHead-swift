//
//  SettingViewController.swift
//  HealthHead
//
//  Created by Mave on 14/12/16.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    var settings:NSArray = ["清除缓存","关于我"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return settings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifer = "settingcell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath) as? UITableViewCell
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            UIApplication.clearImageCache(homeAppend:"cache",clearSuccess: { () -> Void in
                HHOperationHud.toas(rootView: self.view, message: "清除缓存成功")
                }, clearFilure: { (error) -> Void in
                    HHOperationHud.toas(rootView: self.view, message: "缓存已经清理过了,亲")
            })
            
            break;
        case 1:
            self.performSegueWithIdentifier("show_about_me", sender: nil)
            break;
        default :
            break;
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller:UIViewController = segue.destinationViewController as UIViewController
        controller.hidesBottomBarWhenPushed = true
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.textLabel.text = settings.objectAtIndex(indexPath.row) as? String
    }
}
