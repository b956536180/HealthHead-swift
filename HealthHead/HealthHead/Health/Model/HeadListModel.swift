//
//  HeadListModel.swift
//  HealthHead
//
//  Created by Mave on 14/11/21.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import Foundation

class HeadListCellModel: BaseModel {
    var author:String?
    var count:Int?
    var fcount:Int?
    var focal:Int?
    var img:String?
    var rcount:Int?
    var tag:String?
    var time:String?
    var title:String?
    init(params:NSDictionary){
        var id:Int? = params.valueForKey("id") as? Int
        super.init(id: id!)
        self.author = params.valueForKey("author") as? String
        self.count = params.valueForKey("count") as? Int
        self.fcount = params.valueForKey("fcount") as? Int
        self.focal = params.valueForKey("focal") as? Int
        self.rcount = params.valueForKey("rcount") as? Int
        self.tag = params.valueForKey("tag") as? String
        self.time = (params.valueForKey("time") as? String)?.componentsSeparatedByString(", ").last
        self.title = params.valueForKey("title") as? String
        var image:String? = params.valueForKey("img") as? String
        if image != nil{
            self.imageHost += image!
            self.img = self.imageHost
            println(self.imageHost)
        }
    }
}