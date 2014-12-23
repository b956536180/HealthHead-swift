//
//  HHOperationHud.swift
//  HealthHead
//
//  Created by Mave on 14/11/25.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

struct HHUD {
    static var hudView:HHOperationHud?
    static var  once:dispatch_once_t = 0
    static func shareInstance() ->HHOperationHud {
        dispatch_once(&once) { () -> Void in
            var size:CGSize = UIScreen.mainScreen().bounds.size
            self.hudView = HHOperationHud(frame: CGRectMake(0, 0, 80, 45))
        }
        return hudView!
    }
}
class HHOperationHud: UIView {
    private  var indicator:UIActivityIndicatorView?
    var promot:UILabel?
    override var frame:CGRect {
        didSet{
            println(frame)
        }
    }
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.grayColor()
        //        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, CGRectGetWidth(frame) * CGFloat(0.8), CGRectGetHeight(frame) * CGFloat(0.8) ))
        indicator = UIActivityIndicatorView()
        indicator?.center = CGPointMake(CGRectGetWidth(indicator!.frame)/2, CGRectGetHeight(indicator!.frame)/2)
        indicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        indicator?.hidesWhenStopped = true
        addSubview(indicator!)
        
        promot = UILabel(frame: CGRectMake(0, CGRectGetHeight(indicator!.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) * CGFloat(0.2) ))
        promot?.numberOfLines = 0
        promot?.adjustsFontSizeToFitWidth = true
        promot?.textAlignment = NSTextAlignment.Center
        promot?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        addSubview(promot!)
    }
    let XX:CGFloat = 0.3
    func changeFrame(frame:CGRect){
        self.frame = CGRectMake(0, 0, 80, 45)
        //        indicator?.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) * CGFloat(XX), CGRectGetHeight(self.frame) * CGFloat(XX) )
        indicator?.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(indicator!.frame)/2+20)
        indicator?.startAnimating()
        
        promot?.frame = CGRectMake(0, CGRectGetHeight(indicator!.frame) , CGRectGetWidth(self.frame), 35)
        self.center = CGPointMake(CGRectGetWidth(frame)/2 - 20, CGRectGetHeight(frame)/3 + 20)
        self.layer.cornerRadius = 2.0
    }
    class func getInstance() -> HHOperationHud{
        return HHUD.shareInstance()
    }
    
    class func showHUDInView(rootView:UIView, message:String) ->HHOperationHud{
        getInstance().changeFrame(rootView.frame)
        rootView.addSubview(getInstance())
        getInstance().promot?.text = message
        getInstance().promot?.textAlignment = NSTextAlignment.Center
        
        var msgSize: CGSize = NSString(string: message).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16)])
        getInstance().promot?.frame = CGRectMake(0, 0, msgSize.width, msgSize.height)
        getInstance().promot?.textAlignment = NSTextAlignment.Center
        
        var center:CGPoint = HHUD.shareInstance().center
        
        HHUD.shareInstance().frame = CGRectMake(0, 0, max(msgSize.width, 100), max(msgSize.height, 44))
        
        HHUD.shareInstance().center  = center
        getInstance().promot?.center = CGPointMake(CGRectGetWidth(HHUD.shareInstance().frame)/2, CGRectGetHeight(HHUD.shareInstance().frame)/2)
        
        return HHUD.shareInstance()
    }
    class func dismissHUDFromView(rootView:UIView) {
        for view in rootView.subviews {
            if view is HHOperationHud {
                view.removeFromSuperview()
            }
        }
    }
    class func toas(rootView root:UIView, message:String){
        HHOperationHud.cancelPreviousPerformRequestsWithTarget(self)
        var hud:HHOperationHud =   HHOperationHud.showHUDInView(root, message: message)
        var size:CGSize = hud.promot!.text!.sizeOfString([NSForegroundColorAttributeName:UIFont.systemFontOfSize(CGFloat(13))])
        hud.indicator?.stopAnimating()
        
        hud.center = CGPointMake(hud.center.x, CGRectGetHeight(UIScreen.mainScreen().bounds) - hud.center.y)
        HHOperationHud.performSelector("dismissHUDFromView:", withObject: root, afterDelay: 1.25)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
