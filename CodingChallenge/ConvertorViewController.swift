//
//  ConvertorViewController.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

class ConvertorViewController: UIViewController {
    
    
    //MARK: Model
    
    var model: ConvertorModel!
    
    
    //MARK: Outlets
    
    @IBOutlet weak var baseCurrencyAmountEntry: UITextField!
    @IBOutlet weak var convertedCurrencyAmount: UILabel!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrencyLabel: UILabel!
    
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        baseCurrencyLabel.text = model.baseCurrencyCode
        convertedCurrencyLabel.text = model.targetCurrencyCode
        
        baseCurrencyAmountEntry.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
        baseCurrencyAmountEntry.text = zeroDollarRepresentation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        baseCurrencyAmountEntry.becomeFirstResponder()
    }
    
    
    //MARK: Events
    
    func textChanged(){
        formatInput()
        convertAndDisplay()
    }
    
    
    //MARK: Helper
    
    private func formatInput(){
        baseCurrencyAmountEntry.text = getShiftingDecimalString(fromString: baseCurrencyAmountEntry.text)
    }
    
    private func convertAndDisplay(){
        if let text = baseCurrencyAmountEntry.text {
            let convertedAmount = model.convert(amount: Double(text) ?? 0.0)
            convertedCurrencyAmount.text = convertedAmount.getStringRepresentationWithTwoDecimals()
        } else {
            convertedCurrencyAmount.text = zeroDollarRepresentation
        }
    }

    private func getShiftingDecimalString(fromString: String?)->String{
        guard let input = fromString else { return zeroDollarRepresentation }
        
        let noDecimalString = input.replacingOccurrences(of: ".", with: "")
       
        let number = (Double(noDecimalString) ?? 0.0) / 100.0
        return number.getStringRepresentationWithTwoDecimals()
    }
    
    private let zeroDollarRepresentation = "0.00"
}
