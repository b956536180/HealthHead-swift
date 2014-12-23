//
//  ScrollTitleView.swift
//  HealthHead
//
//  Created by Mave on 14/11/21.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
public protocol ScrollTitleViewDelegate{
    /*!
    选中的头的数据
    
    :param: item 选中项目的全部信息
    */
    func ScrollTitleViewDidSlected(titleItem item:AnyObject)
    func ScrollTitleViewDefault() ->Int?
}

/*!
@brief  head 滑动标题
*/
class ScrollTitleView: UIView {
    var indictor:UILabel = UILabel(frame: CGRectZero)
    var segment:UILabel?
    var scroll:UIScrollView?
    var titles:NSMutableArray = NSMutableArray()
    var delegate:ScrollTitleViewDelegate?
    var headers:NSMutableDictionary? = NSMutableDictionary()
    var attribute:NSMutableAttributedString?
    
    init(frame: CGRect, delegate:ScrollTitleViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        HHConnectionOperation(URLString: "http://api.yi18.net/news/newsclass", params: nil, success: { (response, responseObject) -> Void in
            var dict:NSDictionary = responseObject as NSDictionary
            var headers:NSArray = dict.objectForKey("yi18") as NSArray
            var index:Int = 0
            self.scroll = UIScrollView(frame: frame)
            for it in headers {
                self.titles.addObject(it.valueForKey("name") as String )
                var item:UILabel = UILabel(frame: CGRectMake(CGFloat(index) * CGRectGetWidth(frame) / CGFloat(4), 0, CGRectGetWidth(frame) / CGFloat(4), CGRectGetHeight(frame)-2))
                item.text = self.titles.objectAtIndex(index) as? String
                item.userInteractionEnabled = true
                var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didSelectedItem:")
                item.addGestureRecognizer(tap)
                self.scroll?.addSubview(item)
                self.headers?.setObject(it, forKey: item.text!)
                index++
            }
            self.defautlSelectedItem()
            
            self.scroll!.userInteractionEnabled = true
            self.scroll?.showsHorizontalScrollIndicator = false
            self.scroll?.contentSize = CGSizeMake(CGFloat(index) * CGRectGetWidth(frame) / CGFloat(4)+5, CGRectGetHeight( self.frame))
            self.addSubview(self.scroll!)
            self.scroll?.addSubview(self.indictor)
            self.indictor.backgroundColor = UIColor.redColor()
            }) { (response, error) -> Void in
        }
    }
    func defautlSelectedItem(){
        var defaultIndex:Int? =  self.delegate!.ScrollTitleViewDefault()
        if defaultIndex != nil {
            //            self.delegate!.ScrollTitleViewDidSlected(titleItem: self.headers!.valueForKey( self.titles.objectAtIndex(defaultIndex!) as String )!)
            self.selectedItemBy(titleInfo: self.headers!.valueForKey(self.titles.objectAtIndex(defaultIndex!) as String )!)
        }
    }
    func didSelectedItem(sender:UITapGestureRecognizer){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            }) { (finished:Bool) -> Void in
                var selected:UILabel = sender.view as UILabel
                for item in self.scroll!.subviews {
                    if item is UILabel   {
                        
                        var label:UILabel = item as UILabel
                        if (item as UILabel) == selected {
                            if label.text != nil {
                                label.attributedText = self.underLine(label.text!, color: UIColor.redColor())
                            }
                        } else {
                            if label.text != nil {
                                label.attributedText = self.underLine(label.text!, color: UIColor.clearColor())}
                        }
                    } else {
                        
                        var view:UIView = item as UIView
                        view.layer.borderWidth = 0.0
                        view.layer.backgroundColor = UIColor.clearColor().CGColor
                    }
                }
        }
        if self.delegate != nil {
            self.delegate!.ScrollTitleViewDidSlected(titleItem: self.headers!.valueForKey((sender.view as UILabel).text!)!)
        }
    }
    func selectedItemBy( titleInfo info:AnyObject) {
        for subView in self.scroll!.subviews {
            if (subView is UILabel ) {
                var iLabel:UILabel = subView as UILabel
                var selected:NSDictionary =  info as NSDictionary
                if iLabel.text! == selected.valueForKey("name")! as NSString {
                    
                    segment = iLabel
                    //                    iLabel.layer.borderWidth = 1
                    //                    iLabel.layer.backgroundColor = UIColor.redColor().CGColor
                    //                    iLabel.layer.cornerRadius = 3.0
                    
                    iLabel.attributedText = underLine(iLabel.text!, color: UIColor.redColor())
                    
                } else {
                    iLabel.attributedText = underLine(iLabel.text!, color: UIColor.clearColor())
                }
            } else {
                var view:UIView = subView as UIView
                view.layer.borderWidth = 0.0
                view.layer.backgroundColor = UIColor.clearColor().CGColor
            }
        }
        self.delegate!.ScrollTitleViewDidSlected(titleItem: info)
    }
    func underLine(string:String,color:UIColor)->NSAttributedString {
        return NSMutableAttributedString(string: string, attributes: [NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleThick.rawValue,NSUnderlineColorAttributeName:color,NSBackgroundColorAttributeName:UIColor.clearColor()])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
