//
//  UIWebView+HHConnection.swift
//  HealthHead
//
//  Created by Mave on 14/11/15.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import Foundation
import UIKit
let charset =   CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))

extension UIWebView{
    func loadFromURLString(urlString:String){
        loadURL(NSURL(string: urlString)!)
    }
    func loadData(data:NSData?,baseURL base:String){
        if data != nil {
            var string = NSString(data: data!, encoding: NSUTF8StringEncoding)
            println(string)
            self.loadData( data, MIMEType: "text/html", textEncodingName:charset , baseURL:NSURL(string: base))
            self.scalesPageToFit = true
        }
    }
    func loadURL(url:NSURL){
        HHConnectionOperation(request: NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30), success: { (response, responseObject) -> Void in
            var string = NSString(data: responseObject as NSData, encoding: NSUTF8StringEncoding)
            println(string)
            self.loadData(responseObject as NSData, MIMEType: "text/html", textEncodingName:charset , baseURL:url)
            self.scalesPageToFit = true
            }, failure: { (response, error) -> Void in
                
            }, isJSON: false)
    }
//    func loadFrom(remoteURLString:String, progress:HHOPerationProgress){
//        HHConnectionOperation(request: NSURLRequest(URL: NSURL(string: remoteURLString)!), progress: { (byteRead, byteCount, ByteExcepted) -> Void in
//            progress(byteRead: byteRead, byteCount: byteCount, ByteExcepted: ByteExcepted)
//            }, success: { (response, responseObject) -> Void in
//                self.loadData(responseObject as? NSData, baseURL: remoteURLString)
//            }) { (response, error) -> Void in
//                
//        }
//    }
}