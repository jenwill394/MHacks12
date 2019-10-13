//
//  ItemCell.swift
//  MHacks12
//
//  Created by Andreea Serban on 10/12/19.
//  Copyright © 2019 Jennifer Williams. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var Item: UILabel!
    
    func setItem(item: String){
        Item.text = item
    }

}
