//
//  HHRefreshView.swift
//  HealthHead
//
//  Created by Mave on 14/11/23.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
internal enum HHRefreshViewState:Int{
    case Pulling = 0
    case Normal
    case Loading
}
class HHRefreshView: UIView {
    var lastUpdateLabel:UILabel?
    var statusLabel:UILabel?
    var arrowImage:CALayer?
    var activityView:UIActivityIndicatorView?
    var state:HHRefreshViewState?
    
    var size:CGSize = UIScreen.mainScreen().bounds.size
    
    internal    var arrowPullingTransform:CATransform3D? = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
    internal   var arrowNormalTransform:CATransform3D? = CATransform3DIdentity
    
    internal   var releaseText:String? = "松开即可刷新..."
    internal   var pullingText:String? = "下拉即可刷新..."
    internal  var loadingText:String? = "加载中..."
    private let userDefaultKey = "HHRefreshView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.lastUpdateLabel = UILabel(frame: CGRectMake(0, 0, size.width, 20))
        self.lastUpdateLabel?.text = self.releaseText
        self.addSubview(self.lastUpdateLabel!)
        self.activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.activityView?.frame = CGRectMake(25.0, frame.size.height - 38.0, 20.0, 20.0)
        self.addSubview(self.activityView!)
        self.setUpState(HHRefreshViewState.Normal)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpState(state:HHRefreshViewState){
        switch(state){
        case HHRefreshViewState.Pulling:
            CATransaction.begin()
            CATransaction.setAnimationDuration(10.18)
            self.arrowImage?.transform = self.arrowPullingTransform!
            CATransaction.commit()
            break
        case HHRefreshViewState.Normal:
            if self.state == HHRefreshViewState.Pulling {
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.18)
                self.arrowImage?.transform = CATransform3DIdentity
                CATransaction.commit()
            }
            
            self.activityView?.stopAnimating()
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanFalse, forKey: kCATransactionDisableActions)
            CATransaction.commit()
            
            break
        case HHRefreshViewState.Loading:
            self.activityView?.startAnimating()
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            CATransaction.commit()
            break
        default:
            break
        }
        self.state = state
    }
}
