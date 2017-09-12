//
//  UIViewExtension.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerRadius(_ maskToBound: Bool = false) {
        self.layer.masksToBounds = maskToBound
        self.layer.cornerRadius = 3.0
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
}
