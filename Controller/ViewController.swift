//
//  ViewController.swift
//  ByteCoin
//
//  Created by Muneeb ur rehman on 11/09/2019.
//  Copyright © 2019 Muneebs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var coinManager=CoinManager()
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate=self
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
    }
    
    
}



//MARK: - UIPickerViewDataSource




extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
}


//MARK: - UIPickerViewDelegate



extension ViewController:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
}



//MARK: - CoinManagerDelegate




extension ViewController:CoinManagerDelegate{
    func didUpdateCurrency(_ coinManager:CoinManager,coinModel:CoinModel){
        DispatchQueue.main.async {
            self.currencyLabel.text=coinModel.asset_id_quote
            self.bitcoinLabel.text=coinModel.rateString
        }
        
    }
    
    func didFailWithError(error:Error){
        print(error)
    }
}
