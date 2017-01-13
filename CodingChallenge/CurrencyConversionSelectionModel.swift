//
//  CurrencyConversionModel.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct CurrencyConversionRate{
    let countryCode: String
    let conversionFactor: Double
}

class CurrencyConversionSelectionModel {
    
    private(set) var rates = [CurrencyConversionRate]()
    private(set) var currentBase: String?
    
    init(){
        pullData()
    }
    
    func pullData(baseCurrencyCode: String? = nil){
        let parameters = getParameters(base: baseCurrencyCode)
        
        Alamofire.request("https://api.fixer.io/latest", parameters: parameters).responseData { response in
            
            if let data = response.data {
                
                let newRates = self.mapDataToRateObjects(data: data)
                
                if newRates.count > 0 {
                    self.rates = newRates
                    NotificationHelper.sendNotification(withName: .newRatesAvailable)
                    return
                }
                
            }
            NotificationHelper.sendNotification(withName: .errorLoadingRates)
        }
    }
    
    private func mapDataToRateObjects(data: Data)->[CurrencyConversionRate]{
        var conversionRates = [CurrencyConversionRate]()
        
        let json = JSON(data: data)
        
        currentBase = json["base"].string
        let jsonRates = json["rates"]
        
        for(key, rate):(String, JSON) in jsonRates {
            if let conversionRate = rate.number {
                conversionRates.append(CurrencyConversionRate(countryCode: key, conversionFactor: Double(conversionRate)))
            }
        }
        return conversionRates
    }
    
    private func getParameters(base: String?)->[String: Any]? {
        if let base = base {
            return ["base": base]
        } else {
            return nil
        }
    }
}
