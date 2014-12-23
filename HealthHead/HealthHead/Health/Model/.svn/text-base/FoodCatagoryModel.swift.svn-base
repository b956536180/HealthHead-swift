//
//  FoodCatagoryModel.swift
//  HealthHead
//
//  Created by Mave on 14/12/9.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class FoodCatagoryModel: BaseModel {
    var name:String
    var cookClass:Int
    init(cataID:Int, name:String, cookclass:Int){
    self.cookClass = cookclass
        self.name = name
        super.init(id: cataID)
    }
    convenience init(params:NSDictionary){
        var id: Int = params.valueForKey("id") as Int
        var name:String = params.valueForKey("name") as String
        var cookclass:Int = params.valueForKey("cookclass") as Int
        self.init(cataID:id,name:name,cookclass:cookclass)
    }
}
