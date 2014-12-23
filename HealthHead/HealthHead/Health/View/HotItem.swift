//
//  HotItem.swift
//  HealthHead
//
//  Created by Mave on 14/11/20.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

let scal = CGFloat(0.8)
public class HotItem: UIView {
    private   var hotImage:UIImageView?
    private  var hotTitle:UILabel?
    var hotLink:String
    var delegate:HotItemDelegate?
    init(frame: CGRect,hotTile title:String, hotImageURLString urlString:String?,hotLink link:String, delegate:HotItemDelegate?) {
        
        self.hotLink = link
        self.delegate = delegate
        
        self.hotImage = UIImageView()
        self.hotTitle = UILabel()
        
        self.hotImage!.frame = CGRectMake(0, 0, CGRectGetWidth(frame) * scal , CGRectGetHeight(frame) * scal)
        self.hotTitle?.frame = CGRectMake(0, CGRectGetHeight(frame)*scal, CGRectGetWidth(frame), CGRectGetHeight(frame) * (1-scal))
        
        super.init(frame: frame)
        self.addSubview(self.hotTitle!)
        self.addSubview(self.hotImage!)
        self.hotImage?.userInteractionEnabled = true
        self.hotImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "itemSelected"))
        if urlString != nil {
        self.hotImage?.setImage(NSURL(string: urlString!)!, placeHolder: nil)
        }
    }
    
    convenience init(frame:CGRect, hotModel model:HotItemModel, delegate:HotItemDelegate){
        self.init(frame:frame,hotTile:model.hotTitle!,hotImageURLString:model.hotImageURLString!,hotLink:model.hotLink!,delegate:delegate)
    }
    func itemSelected(){
        if self.delegate != nil {
            self.delegate?.didSelectItem(selectedItem: self.hotLink)
        }
    }
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
public class HotItemModel {
    var hotLink:String?
    var hotTitle:String?
    var hotImageURLString:String?
    init(title:String?, link:String?, imageURLStr:String){
        self.hotLink = link
        self.hotImageURLString = imageURLStr
        self.hotTitle = title
    }
}

public protocol HotItemDelegate{
    func didSelectItem(selectedItem link:String)
}
