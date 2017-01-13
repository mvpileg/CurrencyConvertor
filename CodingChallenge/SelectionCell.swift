//
//  SelectionCell.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell {
 
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var currencyCode: UILabel!
    
    func load(currencyCode: String){
        self.currencyCode.text = currencyCode
        self.flag.image = UIImage(named: currencyCode) ?? UIImage(named: "default")
    }
}
