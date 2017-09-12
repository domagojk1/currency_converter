//
//  ConverterInteractor.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation

class ConverterInteractor: ConverterInteractorProtocol {
    var currencyManager: CurrenciesInteractorOutputProtocol?
    var converterManager: ConverterInteractorOutputProtocol?
    var remoteDataManager: RemoteDataManager?
    var localDataManager: LocalDataManager?
    
    func fetchLiveCurrencies() {
        
        remoteDataManager?.fetchCurrentRates { [weak self] currencies in
            guard let currencies = currencies else {
                self?.currencyManager?.onCurrenciesLoadedError()
                return
            }
            
            self?.currencyManager?.onCurrenciesLoaded(currencies: currencies)
            self?.localDataManager?.saveCurrencies(currencies: currencies)
        }
    }
    
    func fetchSavedCurrencies() {
        if let currencies = localDataManager?.loadCurrencies() {
            currencyManager?.onCurrenciesLoaded(currencies: currencies)
        } else {
            currencyManager?.onCurrenciesLoadedError()
        }
    }
    
    func fetchConvertedCurrency(from fromCurrency: Currency, to toCurrency: Currency, amount: Double) {
        guard let sellingRateValue = Double(fromCurrency.sellingRate!),
            let buyingRateValue = Double(toCurrency.buyingRate!) else {
                converterManager?.onConversionError()
                return
        }
        
        let HRK = amount * sellingRateValue
        let result = HRK / buyingRateValue
        converterManager?.onCurrencyConverted(result: "\(result.rounded(toPlaces: 2)) \(toCurrency.currencyCode!)")
    }
}
