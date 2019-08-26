//
//  ItemCell.swift
//  Homepwner
//
//  Created by xionghao on 2019/8/1.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var value: UILabel!
    
    // 响应系统字体大小变化
    override func awakeFromNib() {
        super.awakeFromNib()
        title.adjustsFontForContentSizeCategory = true
        serialNumber.adjustsFontForContentSizeCategory = true
        value.adjustsFontForContentSizeCategory = true
    }
}
