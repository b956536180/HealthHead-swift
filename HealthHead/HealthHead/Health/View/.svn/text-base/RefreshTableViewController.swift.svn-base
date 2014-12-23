//
//  RefreshTableViewController.swift
//  HealthHead
//
//  Created by Mave on 14/11/22.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
public enum RefreshTableViewState:Int{
    case RefreshPulling = 0
    case RefreshNormal = 1
    case RefreshLoading = 2
    case RefreshFinished = 3
}

class RefreshTableViewController: UITableViewController {
    let BASE_PARH = "http://api.yi18.net/"
    var page:Int = 1
    var state:RefreshTableViewState = RefreshTableViewState.RefreshNormal
    private  var isLoading:Bool = false
    internal var isRefresh:Bool = false
    var touch:UITouch = UITouch()
    var local:CGPoint = CGPointZero
    var pre:CGPoint = CGPointZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    /*
    var tracking: Bool { get } // returns YES if user has touched. may not yet have started dragging
    var dragging: Bool { get } // returns YES if user has started scrolling. this may require some time and or distance to move to initiate dragging
    var decelerating: Bool { get } // returns YES if user isn't dragging (touch up) but scroll view is still moving
    
    */
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var offSetY:CGFloat = scrollView.contentOffset.y
        //        println(__FUNCTION__+"\(offSetY) \(scrollView.dragging) \( scrollView.decelerating) \(scrollView.tracking)")
        if touch.phase == UITouchPhase.Moved {
            local = touch.locationInView(scrollView)
        }
        
        if offSetY  > 60  && scrollView.decelerationRate > 2 {
            if self.navigationController?.navigationBarHidden == false {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.tabBarController?.hiddenTabbar()
            }
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.tabBarController!.showTabbar()
        }
        
        if offSetY < -60 && scrollView.dragging == false && scrollView.decelerating == true {
            //            println("下拉\(self.state.rawValue)")
        }
        if ( CGRectGetHeight(scrollView.frame) + offSetY  >  scrollView.contentSize.height + 60 ){
            if self.state == RefreshTableViewState.RefreshLoading && scrollView.decelerating == true && scrollView.dragging == false {
                //                println("上拉加载")
            }
        }
    }
   
   
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var offSetY:CGFloat = scrollView.contentOffset.y
        if scrollView.decelerationRate > 10 && decelerate == true {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        println(scrollView.decelerationRate)

        if offSetY < -65 && !self.isLoading {
            self.isLoading = true
            self.state = RefreshTableViewState.RefreshLoading
            self.isRefresh = true
            self.refreshHeadData()
            UIView.animateWithDuration(1.2, animations: { () -> Void in
                self.tableView.contentInset = UIEdgeInsets(top: 00, left: 0, bottom: 0, right: 0)
            })
        }
        
        if  CGRectGetHeight(scrollView.frame) + offSetY  >  scrollView.contentSize.height + 60  && !self.isLoading{
            self.isLoading = true
            self.state = RefreshTableViewState.RefreshLoading
            self.isRefresh = false
            self.refreshFootData()
            UIView.animateWithDuration(1.2, animations: { () -> Void in
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            })
        }
        
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.state = RefreshTableViewState.RefreshNormal
        self.tabBarController?.showTabbar()

    }
    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.state = RefreshTableViewState.RefreshLoading
        
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.state = RefreshTableViewState.RefreshPulling
        self.isLoading = false
        if touch.phase == UITouchPhase.Began {
            pre = touch.locationInView(scrollView)
        }
    }
    internal func refreshFootData(){
        println(__FUNCTION__)
        page++
    }
    internal func refreshHeadData(){
        println(__FUNCTION__)
        page = 1
    }
}
