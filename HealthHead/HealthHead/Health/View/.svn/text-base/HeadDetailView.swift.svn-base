//
//  HeadDetailView.swift
//  HealthHead
//
//  Created by Mave on 14/11/24.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit
extension String {
    func sizeOfString(attribute:[NSObject : AnyObject]?) ->CGSize {
        if attribute != nil{
            return NSString(string: self).sizeWithAttributes(attribute)
        }
        return NSString(string: self).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16)])
    }
}
/*!
@brief  新闻头条的详情页面
当图片的 URL 为空的时候不加载 tupian
,能容使用 web 加载,当加载完成之后,根据子类的 contentSize 在重新更改 HeadDetailView的 frame
*/

/*!
@brief  新闻详情页,包含标题,和 web
*/
class HeadDetailView: UIScrollView,UIWebViewDelegate {
    var title:String?
    var subTitle:String?
    var dateTime:String?
    var headImageURL:String?
    var headDetailContent:String?
    let imageY:CGFloat = 0,imageWidth:CGFloat = 160
    var titleHeight:CGFloat = 25*2
    var imageHeight:CGFloat = 0
    var image:String?
    var webView:UIWebView?
    weak  var saveController:UIViewController?{
        set(newValue){
            println("完成赋值")
            self.detailImageView?.userInteractionEnabled = true
            var longTap:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
            longTap.numberOfTouchesRequired = 1
            longTap.minimumPressDuration = 1.0
            longTap.allowableMovement = 10
            
            self.detailImageView?.addGestureRecognizer(longTap)
            
            var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "save:")
            self.detailImageView?.addGestureRecognizer(tap)
        }
        get{
            return self.saveController
        }
    }
    func longPress(press:UILongPressGestureRecognizer){
        println("长按")
        
        // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
        //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
        
        var imageView:UIImageView = press.view as UIImageView
        if imageView.image != nil && press.state == UIGestureRecognizerState.Ended{
            //            -(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
            UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
            //            imageView.removeGestureRecognizer(press)
        }
    }
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:UnsafeMutablePointer<Void>){
        if error == nil{
            println("保存成功≥≥≥")
            HHOperationHud.toas(rootView: self, message: "保存成功")
        } else{
            println(error)
            HHOperationHud.toas(rootView: self, message: "保存失败")
        }
    }
    func save(save:UITapGestureRecognizer){
        println("敲击数据")
        
    }
    var detailImageView:UIImageView?
    init(frame: CGRect,title:String?, subTitle:String?,dateTime:String?, headImage:String?, detail:String?) {
        self.title = title
        self.subTitle = subTitle
        self.dateTime = dateTime
        self.headDetailContent = detail
        self.image = headImage
        super.init(frame: frame)
        setUpViews()
    }
    func setUpViews(){
        
        if title != nil {
            //            var tempSize:CGSize = NSString(string: title!).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16)])
            
            //            titleHeight = tempSize.height
            initLabel(CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), titleHeight), text: title, fontSize: 16)
            
        }
        
        if subTitle != nil {
            
            var tempSize:CGSize = NSString(string: subTitle!).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(10)])
            initLabel(CGRectMake(0, titleHeight,tempSize.width, 20), text: subTitle, fontSize: 10)
            if dateTime != nil {
                initLabel(CGRectMake(tempSize.width + 10 , titleHeight, CGRectGetWidth(self.frame), 20), text:dateTime , fontSize: 10)
            }
        }
        
        if  image != nil {
            imageHeight = CGFloat(90)
            self.detailImageView = UIImageView(frame: CGRectMake(CGRectGetWidth(self.frame)/2 - imageWidth/2 , titleHeight + 20 , imageWidth, imageHeight))
            self.addSubview(self.detailImageView!)
            self.detailImageView!.setImage(NSURL(string: self.image!)!, placeHolder: nil)
            
            self.addSubview(self.detailImageView!)
        }
        
        if headDetailContent != nil {
            
            self.webView = UIWebView(frame: CGRectMake(0, titleHeight + 20 + imageHeight , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)))
            self.webView?.loadHTMLString(headDetailContent!, baseURL: nil)
            self.webView?.delegate = self
            self.addSubview(self.webView!)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        for view in webView.subviews {
            if view is UIScrollView {
                
                var scroll:UIScrollView = view as UIScrollView
                
                var size:CGSize = scroll.contentSize
                webView.frame = CGRectMake(0, titleHeight + 20 + self.imageHeight, CGRectGetWidth(self.frame), size.height)
                //                self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), size.height + 30 + 20 + 45)
                self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), size.height + titleHeight + 35 + self.imageHeight + 44)
            }
        }
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none';")
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout='none';")
    }
    func initLabel(frame:CGRect, text:String?, fontSize:CGFloat) ->UILabel {
        var label:UILabel = UILabel(frame: frame)
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(fontSize)
        label.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        NSString(string: text!).boundingRectWithSize(frame.size, options: NSStringDrawingOptions.UsesFontLeading, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)], context: nil)
        self.addSubview(label)
        return label
    }
    func selfToImage(){
        
    }
    func onShare(rootController controller:UIViewController?, excludedTypes:[AnyObject]?, weatherSavetoAlubm isSaved:Bool) {
        if controller != nil{
            var items:[AnyObject]
            if self.detailImageView?.image != nil {
                items = [self.title!,self.detailImageView!.image!]
            } else {
                items = [self.title!]
                
            }
            var share:UIActivityViewController = UIActivityViewController(activityItems: items , applicationActivities: nil)
            controller!.presentViewController(share, animated: true, completion: { () -> Void in
                
            })
            share.excludedActivityTypes = excludedTypes
        }
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
