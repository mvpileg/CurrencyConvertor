//
//  StringExtension.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

extension Double {
    
    func getStringRepresentationWithTwoDecimals()->String{
        return String(format: "%.2f", self)
    }
}
