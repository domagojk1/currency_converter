//
//  ConverterProtocols.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import UIKit

protocol ConverterWireframeProtocol: class {
    static func createConverterModule() -> UIViewController
}

protocol ConverterViewProtocol: class {
    var presenter: ConverterPresenterProtocol? { get set }
    
    func didFetchCurrencies(currencies: [Currency])
    func showLoading()
    func hideLoading()
    func showError(error: String)
    func showConverted(output: String)
}

protocol ConverterPresenterProtocol: class {
    var view: ConverterViewProtocol? { get set }
    var interactor: ConverterInteractorProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func convert(from fromCurrency: Currency, to toCurrency: Currency, amount: Double)
    func fetchCurrencies()
}

protocol ConverterInteractorProtocol: class {
    var currencyManager: CurrenciesInteractorOutputProtocol? { get set }
    var converterManager: ConverterInteractorOutputProtocol? { get set }
    var remoteDataManager: RemoteDataManager? { get set }
    var localDataManager: LocalDataManager? { get set }
    
    func fetchConvertedCurrency(from fromCurrency: Currency, to toCurrency: Currency, amount: Double)
    func fetchLiveCurrencies()
    func fetchSavedCurrencies()
}

protocol CurrenciesInteractorOutputProtocol: class {
    func onCurrenciesLoaded(currencies: [Currency])
    func onCurrenciesLoadedError()
}

protocol ConverterInteractorOutputProtocol: class {
    func onCurrencyConverted(result: String)
    func onConversionError()
}


