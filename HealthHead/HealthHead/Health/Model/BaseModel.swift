//
//  BaseModel.swift
//  HealthHead
//
//  Created by Mave on 14/11/20.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import Foundation
public class BaseModel {
    var id:Int?
    var imageHost:String = "http://www.yi18.net/"
    init(id:Int){
 self.id = id
    }
    deinit{
    
    };
}