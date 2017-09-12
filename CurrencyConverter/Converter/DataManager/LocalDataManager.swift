//
//  LocalDataManager.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation

class LocalDataManager {
    let userDefaults = UserDefaults.standard
    
    func loadCurrencies() -> [Currency]? {
        if let decoded = userDefaults.object(forKey: DefaultsConstants.currenciesKey) as? Data {
            if let decodedCurrencies = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Currency] {
                return decodedCurrencies
            }
        }
        return nil
    }
    
    func saveCurrencies(currencies: [Currency]) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: currencies)
        userDefaults.set(encodedData, forKey: DefaultsConstants.currenciesKey)
        userDefaults.synchronize()
    }
}

