//
//  HeadListCell.swift
//  HealthHead
//
//  Created by Mave on 14/11/20.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

public class HeadListCell: BaseTableViewCell {

    @IBOutlet weak var headTitle: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var headTag: UILabel!
    
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var headHotImg: UIImageView!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     override public func fillCell(cellItem:BaseModel){
        print(cellItem as HeadListCellModel)
        var item:HeadListCellModel = cellItem as HeadListCellModel
        self.author.text = item.author
        self.headTag.text = item.tag
        self.headTitle.text = item.title
        self.time.text = item.time

        self.count.text = "浏览:\(item.count!)"
        if item.img != nil {
                self.loadImage(item.img!, holder: UIImage(named: "hintimage"))
        }
    }
    func loadImage(imageString:String, holder:UIImage?){
    self.headHotImg.setImage(NSURL(string: imageString)!, placeHolder: holder)
    }
    func fillheadListCell(params:NSDictionary) {
    println(params)
        self.headHotImg.image = nil
        self.author!.text  = params.objectForKey("author") as? String
        self.headTag.text = params.objectForKey("tag") as? String
        self.headTitle.text = params.objectForKey("title") as? String
        var format:NSDateFormatter = NSDateFormatter()
//        format.dateStyle = NSDateFormatterStyle.LongStyle
       format.dateFormat = "yyyy年MM月dd日#EEEE"
        var time:String = params.valueForKey("time") as String
       self.time.text = (time.componentsSeparatedByString(", ") as NSArray).objectAtIndex(1) as? String
        var count:Int = params.valueForKey("count") as Int
        self.count.text = "浏览:\(count)"
    }
    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    deinit{
self.headHotImg = nil
    };
}
