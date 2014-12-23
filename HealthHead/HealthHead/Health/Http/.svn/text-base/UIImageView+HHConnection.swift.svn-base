//
//  UIImageView+HHConnection.swift
//  HealthHead
//
//  Created by Mave on 14/11/15.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication{
    class func clearImageCache(homeAppend append:String, clearSuccess success:()->Void, clearFilure failure: (error:NSError?)->Void){
        var error:NSError? = nil
        var fileManger:NSFileManager = NSFileManager.defaultManager()
        var path:String = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(append)")
        println(path)
        var clearSuccess:Bool = fileManger.removeItemAtPath(path, error: &error)
        
        if error != nil {
        failure(error: error)
        } else{
        success()
        }
    }
}

extension UIImageView{
    public func setImage(url:NSURL,progress:HHOperationProgress?, placeHolder holder:UIImage?){
        var (path, isExist) =   isImageCacheExist(url.description)
        if isExist == true {
            var image:UIImage? = UIImage(contentsOfFile: path)
            if image != nil {
                self.image = image!
            }
            return
        }
        if holder != nil {
            
            self.image = holder!
            println("有默认图片")
        }
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.addValue("image/*", forHTTPHeaderField: "Accept")
        HHConnectionOperation(request: request, progress: progress, success: { (response, responseObject) -> Void in
            
            var data:NSData? = responseObject as? NSData
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if data != nil {
                    var fileManger = NSFileManager.defaultManager()
                    fileManger.createFileAtPath(path, contents: data, attributes: nil)
                    var image = UIImage(data: data!)
                    self.image = image!
                }
            })
            }, failure: { (response, error) -> Void in
                if holder != nil {
                    self.image = holder!
                }
            }, isJSON: false)
    }
    public func setImage(url:NSURL, placeHolder holder:UIImage?){
        self.setImage(url, progress: nil, placeHolder: holder)
        return
        if holder != nil {
            self.image = holder!
        }
        var (path, isExist) =   isImageCacheExist(url.description)
        if isExist == true {
            self.image = UIImage(contentsOfFile: path)!
            return
        }
        
        var request:NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        
        var connection = HHConnectionOperation(request: request, success: { (response, responseObject) -> Void in
            var data:NSData? = responseObject as? NSData
            if data != nil {
                var fileManger = NSFileManager.defaultManager()
                fileManger.createFileAtPath(path, contents: data, attributes: nil)
                var image = UIImage(data: data!)!
                self.image = image
            }
            }, failure: { (response, error) -> Void in
                if holder != nil {
                    self.image = holder!
                }
            }, isJSON: false)
    }
    //判断指定文件创建 和 最后 修改时间 ,判断是否应该删除
    func controlCache(cachePath:String) ->Bool{
        var fileManger = NSFileManager.defaultManager()
        //            println(fileManger.attributesOfItemAtPath(path, error: nil))
        //NSFileCreationDate: 2014-11-15 13:36:23 +0000, NSFileType: NSFileTypeRegular, NSFileGroupOwnerAccountName: admin, NSFileReferenceCount: 1, NSFileModificationDate: 2014-11-15 13:43:12 +0000])
        var attributes =  fileManger.attributesOfItemAtPath(cachePath, error: nil)
        var modifyDate : NSDate = attributes![NSFileModificationDate] as NSDate
        var createDate: NSDate = attributes![NSFileCreationDate] as NSDate
        //    func components(unitFlags: NSCalendarUnit, fromDate date: NSDate) -> NSDateComponents
        var modifyDateComponents:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitDay, fromDate: modifyDate)
        var createDateComponents:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitDay, fromDate: createDate)
        if modifyDateComponents.month - createDateComponents.month >= 1 {
            return fileManger.removeItemAtPath(cachePath, error: nil)
        } else {
            fileManger.setAttributes([NSFileModificationDate:NSDate()], ofItemAtPath: cachePath, error: nil)
        }
        return false
    }
    //判断文件是否存在,同时遍历文件夹下面的文件创建/访问日期,进行 cache 缓存管理
    func isImageCacheExist(imageName:String) -> (cache:String , isExist:Bool) {
        var fileManger:NSFileManager = NSFileManager.defaultManager()
        var name = queralURLStringToName(imageName)
        var cachePath = NSHomeDirectory().stringByAppendingPathComponent("Documents/cache/")
        if  fileManger.fileExistsAtPath(cachePath) == false {
            fileManger.createDirectoryAtPath(cachePath, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
        if cachePath.hasSuffix("/") == false {
            cachePath = cachePath + "/"
        }
        
        controlCache(cachePath)
        //        var images:[AnyObject]? = fileManger.subpathsOfDirectoryAtPath(cachePath, error: nil)
        //        //        println(images)
        //        for item in images! {
        //            println(item as String)
        //            var itemPath = cachePath + (item as String)
        //            //暂时屏蔽
        //
        //               self.controlCache(itemPath)
        //        }
        
        cachePath += name
        println(cachePath)
        return (cachePath,fileManger.fileExistsAtPath(cachePath))
    }
    //将 URL 转化为 文件名称
    func queralURLStringToName(URLString:String) -> String {
        var items = URLString.pathComponents
        var path = ""
        var index:Int = 1
        for index ;index < items.count ; index++ {
            path += items[index]
        }
        return path
    }
}