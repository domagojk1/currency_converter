//
//  ConverterWireframe.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import UIKit

class ConverterWireframe: ConverterWireframeProtocol {
    
    class func createConverterModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ConverterNavController")
        
        if let view = navController.childViewControllers.first as? ConverterView {
            let presenter: ConverterPresenterProtocol & ConverterInteractorOutputProtocol & CurrenciesInteractorOutputProtocol = ConverterPresenter()
            let interactor: ConverterInteractorProtocol = ConverterInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            let remoteDataManager = RemoteDataManager()
            let localDataManager = LocalDataManager()
            interactor.remoteDataManager = remoteDataManager
            interactor.converterManager = presenter
            interactor.currencyManager = presenter
            interactor.localDataManager = localDataManager
            
            return navController
        }
        
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
