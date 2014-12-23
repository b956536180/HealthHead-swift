//
//  DailyTopCell.swift
//  HealthHead
//
//  Created by Mave on 14/11/27.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import UIKit

class DailyTopCell: BaseTableViewCell {
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var keywords: UILabel!
    
    @IBOutlet weak var from: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func fillCell(cellItem: BaseModel) {
        super.fillCell(cellItem)
        self.img.image = nil
        var item:DailyTopModel = cellItem as DailyTopModel
        self.title.text = item.title
        self.keywords.text = item.keywords
        self.from.text = item.from
        self.time.text = item.time
        if item.img != nil {
            if item.img!.hasSuffix("jpg"){
        self.img.setImage(NSURL(string: item.img!)!, placeHolder: UIImage(named: "hintimg")!)
            }}
    }
    deinit{
    self.img.image = nil
    };
}
