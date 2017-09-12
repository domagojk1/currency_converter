//
//  ConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import ReachabilitySwift
import NotificationCenter

class ConverterPresenter: ConverterPresenterProtocol {
    weak var view: ConverterViewProtocol?
    var interactor: ConverterInteractorProtocol?
    let reachability = Reachability()!
    var currenciesFetched = false
    
    func viewDidLoad() {
        view?.showLoading()
        fetchCurrencies()
    }
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,object: self.reachability)
        do {
            try self.reachability.startNotifier()
        } catch {}
    }
    
    func viewWillDisappear() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            if reachability.isReachable {
                if !self.currenciesFetched {
                    self.fetchCurrencies()
                }
            }
        }
    }
    
    func convert(from fromCurrency: Currency, to toCurrency: Currency, amount: Double) {
        interactor?.fetchConvertedCurrency(from: fromCurrency, to: toCurrency, amount: amount)
    }
    
    func fetchCurrencies() {
        if reachability.isReachable {
            interactor?.fetchLiveCurrencies()
        } else {
            interactor?.fetchSavedCurrencies()
        }
    }
}

extension ConverterPresenter: CurrenciesInteractorOutputProtocol {
    
    func onCurrenciesLoaded(currencies: [Currency]) {
        currenciesFetched = true
        view?.hideLoading()
        view?.didFetchCurrencies(currencies: currencies)
    }
    
    
    func onCurrenciesLoadedError() {
        view?.hideLoading()
        view?.showError(error: NSLocalizedString("Error fetching data.", comment: ""))
    }
}

extension ConverterPresenter: ConverterInteractorOutputProtocol {
    
    func onConversionError() {
        view?.showError(error: NSLocalizedString("Error converting currency.", comment: ""))
    }
    
    func onCurrencyConverted(result: String) {
        view?.showConverted(output: result)
    }
}


