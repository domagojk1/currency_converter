//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import ObjectMapper

class Currency: NSObject, NSCoding, Mappable {
    var medianRate: String?
    var currencyCode: String?
    var buyingRate: String?
    var sellingRate: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        medianRate <- map["median_rate"]
        currencyCode <- map["currency_code"]
        buyingRate <- map["buying_rate"]
        sellingRate <- map["selling_rate"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        medianRate = aDecoder.decodeObject(forKey: "median") as? String
        currencyCode = aDecoder.decodeObject(forKey: "currency") as? String
        buyingRate = aDecoder.decodeObject(forKey: "buying") as? String
        sellingRate = aDecoder.decodeObject(forKey: "selling") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(medianRate, forKey: "median")
        aCoder.encode(currencyCode, forKey: "currency")
        aCoder.encode(buyingRate, forKey: "buying")
        aCoder.encode(sellingRate, forKey: "selling")
    }
}

