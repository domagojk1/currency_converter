//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Domagoj Kopić on 12/09/2017.
//  Copyright © 2017 Domagoj Kopić. All rights reserved.
//

import UIKit
import PKHUD

class ConverterView: UIViewController {
    var presenter: ConverterPresenterProtocol?
    var currencies = [Currency]()
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var labelFrom: UILabel!
    @IBOutlet weak var labelTo: UILabel!
    @IBOutlet weak var pickerFrom: UIPickerView!
    @IBOutlet weak var pickerTo: UIPickerView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var buttonConvert: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        self.pickerFrom.delegate = self
        self.pickerTo.delegate = self
        self.pickerFrom.dataSource = self
        self.pickerTo.dataSource = self
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    func setupViews() {
        navigationItem.title = NSLocalizedString("Currency converter", comment: "")
        labelFrom.text = NSLocalizedString("Convert from:", comment: "")
        labelTo.text = NSLocalizedString("Convert to:", comment: "")
        txtAmount.placeholder = NSLocalizedString("Enter your amount", comment: "")
        buttonConvert.setCornerRadius(false)
        buttonConvert.addShadow()
        pickerFrom.setCornerRadius(true)
        pickerTo.setCornerRadius(true)
        buttonConvert.isEnabled = false
        resultLabel.isHidden = true
    }
    
    @IBAction func onConvert(_ sender: UIButton) {
        let currFrom = currencies[pickerFrom.selectedRow(inComponent: 0)]
        let currencyTo = currencies[pickerTo.selectedRow(inComponent: 0)]
        
        guard let txt = txtAmount.text, let amount = Double(txt) else {
            showError(error: NSLocalizedString("Input error", comment: ""))
            return
        }
    
        presenter?.convert(from: currFrom, to: currencyTo, amount: amount)
    }
}

extension ConverterView: ConverterViewProtocol {
    
    func hideLoading() {
        HUD.hide()
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConverted(output: String) {
        resultLabel.isHidden = false
        resultLabel.text = output
    }
    
    func didFetchCurrencies(currencies: [Currency]) {
        self.currencies = currencies
        pickerTo.reloadAllComponents()
        pickerFrom.reloadAllComponents()
        buttonConvert.isEnabled = true
    }
}

extension ConverterView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].currencyCode
    }
}

