//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let converterModule = ConverterWireframe.createConverterModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = converterModule
        window?.makeKeyAndVisible()

        return true
    }

}

