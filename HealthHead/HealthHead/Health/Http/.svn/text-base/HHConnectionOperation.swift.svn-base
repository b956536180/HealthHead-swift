//
//  HHConnectionOperation.swift
//  HealthHead
//
//  Created by Mave on 14/11/14.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit



public let kHHNetWorkLockName = "yulonglee"
public enum HHNetWorkState{
    case Ready
    case Executing
    case Finished
}

internal struct HHCGDAndThread{
    static var queue:NSOperationQueue = NSOperationQueue()
    static var once:dispatch_once_t = 0
    static var thread:NSThread?
  var queue_t:dispatch_queue_t?
    init(){
        var once:dispatch_once_t = 0
        dispatch_once(&once, { () -> Void in
            self.queue_t = dispatch_queue_create("com.yulonglee", nil)
        })
    }
}
public typealias HHOperationSuccess = (response:NSHTTPURLResponse?,responseObject:AnyObject)->Void
public typealias HHOperationFailure = (response:NSHTTPURLResponse?,error:NSError?)->Void

public typealias HHOperationProgress = (bytesRead:Int, bytesHaveRead:Int, bytesExpected:Int) ->Void

public class HHConnectionOperation: NSOperation,NSURLConnectionDelegate,NSURLConnectionDataDelegate {
    var request:NSURLRequest?
    var lock:NSRecursiveLock?
    var runLoopModes:NSSet
    var state:HHNetWorkState
    var connection:NSURLConnection?
    var success:HHOperationSuccess?
    var failure:HHOperationFailure?
    var progress:HHOperationProgress?
    
    var queue:dispatch_queue_t = dispatch_queue_create("com.lee", nil)
    var error:NSError?
    var responseObject:AnyObject?
    var data:NSMutableData?
    var response:NSHTTPURLResponse?
    var isJSON:Bool = true
    var requestSerializer:HHRequestSerializer = HHRequestSerializer()
    public override var ready:Bool {
        return self.state == HHNetWorkState.Ready
    }
    public override var finished:Bool{
        return self.state == HHNetWorkState.Finished
    }
    public override  var executing: Bool {
        return self.state == HHNetWorkState.Executing
    }
    
    public override func cancel() {
        self.lock!.lock()
        if !self.finished && !self.cancelled {
            super.cancel()
            if self.executing {
                
            }
        }
        
        self.lock!.unlock()
    }
    
    class func netWorkEnterPoint(id:AnyObject?){
        var current:NSThread = NSThread.currentThread()
        current.name = "lee"
        var runLoop:NSRunLoop = NSRunLoop()
        runLoop.addPort(NSMachPort(), forMode: NSDefaultRunLoopMode)
        runLoop.run()
    }
    class func netWorkThread()->NSThread{
    dispatch_once(&HHCGDAndThread.once, { () -> Void in
        HHCGDAndThread.thread = NSThread(target: self, selector: "netWorkEnterPoint:", object: nil)
        HHCGDAndThread.thread?.start()
    })
        return HHCGDAndThread.thread!
    }
    
    init(request:NSURLRequest, progress:HHOperationProgress?, success:HHOperationSuccess?, failure:HHOperationFailure?, isJSON:Bool) {
        self.request = request
        self.lock = NSRecursiveLock()
        self.lock!.name = kHHNetWorkLockName
        self.runLoopModes = NSSet(objects: NSRunLoopCommonModes)
        self.state = HHNetWorkState.Ready
        self.success = success
        self.failure = failure
        self.progress = progress
        self.isJSON = isJSON
        //需要初始化,自身,然后才可以调用父类
        super.init()
        dispatch_async(HHCGDAndThread().queue_t!, { () -> Void in
            
            HHCGDAndThread.queue.addOperation(self)
        })
    }
    
    func operationDidStart(){
    }
    override public func start() {
        println(__FILE__)
        self.lock!.lock()
        dispatch_async(HHCGDAndThread().queue_t!, { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.connection = NSURLConnection(request: self.request!, delegate: self, startImmediately: false)
                var runLoop:NSRunLoop = NSRunLoop.currentRunLoop()
                for runLoopMode in self.runLoopModes {
                    self.connection?.scheduleInRunLoop(runLoop, forMode: runLoopMode as String)
                }
                self.connection!.start()
            })
        })
        self.lock!.unlock()
    }
    public func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.lock!.lock()
        self.data?.appendData(data)
        self.lock!.lock()
        if self.progress != nil {
            self.progress!(bytesRead: data.length,bytesHaveRead: self.data!.length,bytesExpected: Int(self.response!.expectedContentLength))
        }
    }
    public func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.lock!.lock()
        self.state = HHNetWorkState.Executing
        self.responseObject = response
        self.response = response as? NSHTTPURLResponse
        self.data = NSMutableData()
        self.lock!.unlock()
        
    }
    public func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.lock!.lock()
        self.state = HHNetWorkState.Finished
        self.error = error
        if self.failure != nil {
            self.failure!(response: self.response,error: self.error)
        }
        self.lock!.unlock()
    }
    public func connectionDidFinishLoading(connection: NSURLConnection) {
        self.lock!.lock()
        self.state = HHNetWorkState.Finished
        if self.success != nil {
            self.serializerData(self.data!, isJSON: self.isJSON)
        }
        self.lock!.unlock()
    }
    private func serializerData(responseData:NSData, isJSON:Bool){
        self.lock!.lock()
        if isJSON == true {
            var object:AnyObject? = NSJSONSerialization.JSONObjectWithData(self.data!, options: NSJSONReadingOptions.MutableLeaves, error: nil)
            self.success!(response: self.response,responseObject:object! )
        } else {
            self.success!(response: self.response,responseObject:self.data! )
        }
        self.lock!.unlock()
    }
}


extension HHConnectionOperation{
    convenience init(url:NSURL, progress:HHOperationProgress?, success:HHOperationSuccess?, failure:HHOperationFailure?, isJSON:Bool) {
        var request = NSURLRequest(URL: url)
        self.init(request:request,progress:progress,success:success,failure:failure,isJSON:isJSON)
    }
    convenience init(url get:String, progress:HHOperationProgress?, success:HHOperationSuccess?, failure:HHOperationFailure?, isJSON:Bool) {
        var URL:NSURL = NSURL(string: get)!
        self.init(url:URL,progress:progress,success:success,failure:failure,isJSON:isJSON)
    }
    convenience  init(request:NSURLRequest, success:HHOperationSuccess?, failure:HHOperationFailure?, isJSON:Bool) {
        self.init(request:request,progress:nil,success:success,failure:failure,isJSON:isJSON)
    }
    convenience  init(request:NSURLRequest, success:HHOperationSuccess?, failure:HHOperationFailure?) {
        self.init(request:request,success:success,failure:failure,isJSON:true)
        //        self.request = request
        //        self.lock = NSRecursiveLock()
        //        self.lock!.name = kHHNetWorkLockName
        //        self.runLoopModes = NSSet(objects: NSRunLoopCommonModes)
        //        self.state = HHNetWorkState.Ready
        //        self.success = success
        //        self.failure = failure
        //        super.init()
        //        HHCGDAndThread.queue.addOperation(self)
    }
    
    convenience  init(request:NSURLRequest){
        self.init(request:request,success:nil,failure:nil)
    }
    convenience init(URLString:String, params:NSDictionary?, success:HHOperationSuccess, failure:HHOperationFailure) {
        var request:NSURLRequest?
        var requestSerializer = HHRequestSerializer()
        
        if params == nil {
            request = NSURLRequest(URL: NSURL(string: URLString)!, cachePolicy: requestSerializer.cachePolicy, timeoutInterval: requestSerializer.timeInterval)
        } else{
            request =   requestSerializer.GET(URLString, params: params!)
        }
        
        self.init(request:request!,success:success  ,failure:failure)
    }
}
