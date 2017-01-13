//
//  ConvertorModel.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

class ConvertorModel {
    
    
    private let rate: Double
    let baseCurrencyCode: String
    let targetCurrencyCode: String
    
    init(rate: Double, baseCurrencyCode: String, targetCurrencyCode: String) {
        self.rate = rate
        self.baseCurrencyCode = baseCurrencyCode
        self.targetCurrencyCode = targetCurrencyCode
    }
    
    func convert(amount: Double)->Double{
        return rate * amount
    }
}
