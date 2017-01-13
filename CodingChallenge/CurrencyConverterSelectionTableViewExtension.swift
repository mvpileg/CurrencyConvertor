//
//  CurrencyConverterSelectionTableViewExtension.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

extension CurrencyConverterSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRate = model.rates[indexPath.row]
        
        if isCurrentlySelectingBaseCurrency {
            isCurrentlySelectingBaseCurrency = false
            model.pullData(baseCurrencyCode: selectedRate.countryCode)
        } else {
            if model.currentBase != nil {
                self.performSegue(withIdentifier: "open convertor", sender: selectedRate)
            } else {
                NotificationHelper.sendNotification(withName: .noRatesAvailable)
            }
        }
    }
    
    
    //MARK: Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.rates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isCurrentlySelectingBaseCurrency ? "Select base currency" : nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let file = model.rates[indexPath.row]
        
        if isCurrentlySelectingBaseCurrency {
            let selectionCell = tableView.dequeueReusableCell(withIdentifier: "selection cell") as! SelectionCell
            selectionCell.load(currencyCode: file.countryCode)
            return selectionCell
        } else {
            let conversionCell = tableView.dequeueReusableCell(withIdentifier: "conversion cell") as! ConversionCell
            conversionCell.load(currencyCode: file.countryCode, exchangeRate: file.conversionFactor)
            return conversionCell
        }
    }
    
}
