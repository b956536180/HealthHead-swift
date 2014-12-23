//
//  HHRequestSerializer.swift
//  HealthHead
//
//  Created by Mave on 14/11/15.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

public class HHRequestSerializer: NSObject {
    public var stringEncoding:UInt = NSUTF8StringEncoding
    public var cachePolicy:NSURLRequestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
    public var timeInterval:NSTimeInterval = 30.0
    public var baseURLString:String?
    public func paramsSerializer(params:NSDictionary) -> String{
        
        var items:NSMutableArray = NSMutableArray()
        for (key,value) in params {
            items.addObject("\(key)=\(value)")
        }
        return items.componentsJoinedByString("&")
    }
    public func POST(URLString:String, params:NSDictionary) -> NSURLRequest{
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString)!, cachePolicy: self.cachePolicy, timeoutInterval: self.timeInterval)
        request.HTTPBody = self.paramsSerializer(params).dataUsingEncoding(self.stringEncoding, allowLossyConversion: true)
        return request
    }
    public func GET(URLString:String, params:NSDictionary) -> NSURLRequest {
    var itemsString = self.paramsSerializer(params)
    var tmpURL = ""
        if URLString.hasSuffix("?") {
            tmpURL = URLString + itemsString
        } else {
            tmpURL = URLString + "?" + itemsString
        }
        return NSMutableURLRequest(URL: NSURL(string: tmpURL)!, cachePolicy: self.cachePolicy, timeoutInterval: self.timeInterval)
    }
}
