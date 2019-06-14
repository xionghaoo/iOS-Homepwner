//
//  ItemStore.swift
//  Homepwner
//
//  Created by xionghao on 2019/6/14.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let item = Item(random: true)
        allItems.append(item)
        return item
    }
}
