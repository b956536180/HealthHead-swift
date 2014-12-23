//
//  DailyFoodCell.swift
//  HealthHead
//
//  Created by Mave on 14/11/28.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyFoodCell: BaseTableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var fcount: UILabel!
    
    
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func fillCell(cellItem: BaseModel) {
        self.foodImage.image = nil
        var item:DailyFoodModel = cellItem as DailyFoodModel
        self.foodName.text = item.name
        self.fcount.text = "关注:\(item.fcount!)"
        self.count.text = "浏览:\(item.count!)"
        if item.img != nil {
            self.foodImage.setImage(NSURL(string: item.imageHost + item.img!)!, placeHolder: UIImage(named: "hintimg")!)
        }
//        self.contentView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.brownColor().CGColor
        self.contentView.layer.cornerRadius = 10
//        truct UIEdgeInsets {
//            var top: CGFloat // specify amount to inset (positive) for each of the edges. values can be negative to 'outset'
//            var left: CGFloat
//            var bottom: CGFloat
//            var right: CGFloat
//        }

    }
    deinit{
    self.foodImage.image = nil
    };
}
