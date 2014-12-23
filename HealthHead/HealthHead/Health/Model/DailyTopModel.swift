//
//  DailyTopModel.swift
//  HealthHead
//
//  Created by Mave on 14/11/27.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyTopModel: BaseModel {
    var from:String?
    var keywords:String?
    var img:String?
    var title:String?
    var time:String?
    init(id: Int?, title: String?, img: String?,time:String?,keywords:String?, from:String?) {
        super.init(id: id!)
        self.title = title
        if img != nil{
            self.img = self.imageHost +  img!
        }
        self.time = time!.componentsSeparatedByString(", ").last
        self.keywords = keywords
        self.from = from
    }
   
}
