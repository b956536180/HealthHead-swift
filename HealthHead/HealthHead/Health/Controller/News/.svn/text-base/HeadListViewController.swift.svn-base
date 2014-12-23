//
//  HeadListViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/20.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
/*!
@brief  头条新闻列表页面
*/
class HeadListViewController: RefreshTableViewController,ScrollTitleViewDelegate {
    var segment:UISegmentedControl?
    var headers:NSMutableArray? = NSMutableArray()
    var cellData:NSMutableArray? = NSMutableArray()
    var limitCount:Int? = 20
    var id:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.translucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.brownColor()
       var hh:ScrollTitleView = ScrollTitleView(frame: CGRectMake(0, 0, 320,30), delegate:self)
     self.navigationItem.titleView = hh
//        getDataFromServer(1, limitCount: 20)
    }
    func getDataFromServer(id:Int?, limitCount limit:Int) {
        
        HHOperationHud.showHUDInView(self.view, message: "加载中")

        var url:String = self.BASE_PARH + "news/list"
        HHConnectionOperation(URLString: url, params: ["limit":limit,"id":id!], success: { (response, responseObject) -> Void in
            println(response)
            var dict:NSDictionary = responseObject as NSDictionary
            var data:NSArray = dict.objectForKey("yi18") as NSArray
            if self.isRefresh == true {
            self.cellData?.removeAllObjects()
            }
            for item in data {
                var cellItem:HeadListCellModel = HeadListCellModel(params: item as NSDictionary)
                self.cellData?.addObject(cellItem)
            }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.isRefresh == true {
                        self.tableView.reloadData()
//                        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
                     return
                    }
                    //加载更多的时候分行更新
                    var index:Int = self.tableView.numberOfRowsInSection(0)
                    var moreRows:NSMutableArray = NSMutableArray()
                    for more in index ... self.cellData!.count-1 {
                    
                        moreRows.addObject(NSIndexPath(forItem: more, inSection: 0))
                    }
                    
                    self.tableView.beginUpdates()
                    self.tableView.insertRowsAtIndexPaths(moreRows, withRowAnimation: UITableViewRowAnimation.None)
                    self.tableView.endUpdates()
                })
            }) { (response, error) -> Void in
                
        }
        HHOperationHud.dismissHUDFromView(self.view)
    }
    func ScrollTitleViewDefault() -> Int? {
        return 1
    }
    func ScrollTitleViewDidSlected(titleItem item: AnyObject) {
        println(item )
        var selected:NSDictionary =  item as NSDictionary
        self.id = selected.valueForKey("id") as? Int
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
//            self.getDataFromServer(self.id!, limitCount:20)
            self.isRefresh = true
            self.refreshHeadData()
            
        })
    }
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if self.cellData?.count > 0 {
            return 1
        }
        return 0
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var item:HeadListCellModel = self.cellData!.objectAtIndex(indexPath.row) as HeadListCellModel
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.performSegueWithIdentifier("head_news_detail", sender: item)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "head_news_detail"{
            var item:HeadListCellModel = sender as HeadListCellModel
            var controller:HeadNewsDetailViewController = segue.destinationViewController as HeadNewsDetailViewController
            controller.id = item.id
            controller.headImage = item.img
            controller.hidesBottomBarWhenPushed = true
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if self.cellData?.count > 0 {
            return self.cellData!.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:HeadListCell = tableView.dequeueReusableCellWithIdentifier("headlistcell") as HeadListCell
        //        cell.fillheadListCell(self.cellData!.objectAtIndex(indexPath.row) as NSDictionary)
        cell.fillCell(self.cellData!.objectAtIndex(indexPath.row) as BaseModel)
        var view = UIView(frame: cell.frame)

        cell.selectedBackgroundView = view
        view.backgroundColor = UIColor.cyanColor()
        return cell
    }
    override func refreshHeadData() {
        self.getDataFromServer(self.id, limitCount: 20)
    }
    override func refreshFootData() {
        self.getDataFromServer(self.id, limitCount: self.cellData!.count + 20)
    }
}
