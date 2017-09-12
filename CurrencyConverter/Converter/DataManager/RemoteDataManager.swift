//
//  RemoteDataManager.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RemoteDataManager {
    
    func fetchCurrentRates(completionHandler: @escaping ([Currency]?) -> Void) {
        Alamofire.request(ApiConstants.baseUrl, method: .get)
            .responseArray { (response: DataResponse<[Currency]>) in
                
                let currencies = response.result.value
                completionHandler(currencies)
        }
    }
}
