//
//  NotificationTypes.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

class NotificationHelper{
    
    static func sendNotification(withName: Notification.Name){
        NotificationCenter.default.post(name: withName, object: nil)
    }
    
}

extension Notification.Name {
    static let newRatesAvailable = Notification.Name(rawValue: "new rates available")
    static let errorLoadingRates = Notification.Name(rawValue: "Error loading rates")
    static let noRatesAvailable = Notification.Name(rawValue: "Data unavailable")
}
