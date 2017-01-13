//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Matthew Pileggi on 1/13/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

class CurrencyConverterSelectionViewController: UIViewController {

    
    //MARK: Fields
    
    var isCurrentlySelectingBaseCurrency = false
    var model: CurrencyConversionSelectionModel!

    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedBaseCurrencyFlag: UIImageView!
    @IBOutlet weak var selectedBaseCurrencyCode: UILabel!
    @IBOutlet weak var selectedBaseCurrencyView: UIView!
    
    
    //MARK: Actions
    
    func toggle(recognizer: UITapGestureRecognizer) {
        isCurrentlySelectingBaseCurrency = !isCurrentlySelectingBaseCurrency
        tableView.reloadData()
    }
    
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupTableView()
        setupObservers()
        setupTappableCurrencySelector()
        
        model = CurrencyConversionSelectionModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: Setup
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupObservers(){
        let nc = NotificationCenter.default
        nc.addObserver(forName: .newRatesAvailable, object: nil, queue: nil, using: updateViewWithNewRates)
        nc.addObserver(forName: .errorLoadingRates, object: nil, queue: nil, using: presentErrorLoadingRatesPrompt)
        nc.addObserver(forName: .noRatesAvailable, object: nil, queue: nil, using: presentErrorLoadingRatesPrompt)
    }
    
    private func setupTappableCurrencySelector(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggle))
        self.selectedBaseCurrencyView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    //MARK: Observers
    
    private func updateViewWithNewRates(notification: Notification){
        DispatchQueue.main.async {
            self.updateCurrencySelectionView()
            self.tableView.reloadData()
        }
    }
    
    private func presentErrorLoadingRatesPrompt(notification: Notification){
        DispatchQueue.main.async {
            let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                self.pullDataFromModel()
            }
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            
            let alert = UIAlertController(title: "Error", message: notification.name.rawValue, preferredStyle: .alert)
            
            alert.addAction(retryAction)
            alert.addAction(dismissAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: Helper
    
    private func updateCurrencySelectionView(){
        if let currentCountryCode = model.currentBase {
            selectedBaseCurrencyCode.text = currentCountryCode
            selectedBaseCurrencyFlag.image = UIImage(named: currentCountryCode) ?? UIImage(named: "default")
        }
    }
    
    private func pullDataFromModel(){
        model.pullData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "open convertor" {
            let convertorRate = sender as! CurrencyConversionRate
            let destination = segue.destination as! ConvertorViewController
            destination.model = ConvertorModel(rate: convertorRate.conversionFactor, baseCurrencyCode: model.currentBase!, targetCurrencyCode: convertorRate.countryCode)
        }
    }
    

}



