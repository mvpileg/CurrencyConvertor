//
//  ConversionCell.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

class ConversionCell: UITableViewCell {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var exchangeRate: UILabel!
    
    func load(currencyCode: String, exchangeRate: Double){
        self.currencyCode.text = currencyCode
        self.exchangeRate.text = exchangeRate.getStringRepresentationWithTwoDecimals()
        self.flag.image = UIImage(named: currencyCode) ?? UIImage(named: "default")
    }
}
