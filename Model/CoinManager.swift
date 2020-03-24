//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Muneeb ur rehman on 11/09/2019.
//  Copyright © 2019 Muneebs. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager:CoinManager,coinModel:CoinModel)
    func didFailWithError(error:Error)
}


struct CoinManager {
    
    var delegate:CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "88EDACBC-D727-4D68-ABF0-ACE29C1AC290"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency:String){
        let urlString=generateUrlString(for: currency)
        performRequest(with: urlString)
        
    }
    
    
    func generateUrlString(for currency:String)->String{
        return String(stringLiteral: "\(baseURL)/\(currency)?apikey=\(apiKey)")
    }
    
    
    func performRequest(with urlString:String){
        if let url=URL(string: urlString){
            let urlSession=URLSession(configuration: .default)
            let task=urlSession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData=data{
                    let coinModel=self.parseJSON(data: safeData)
                    if let safeCoinModel=coinModel{
                        self.delegate?.didUpdateCurrency(self, coinModel: safeCoinModel)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data:Data)->CoinModel?{
        
        let decoder=JSONDecoder()
        do {
            let coinData=try decoder.decode(CoinData.self, from: data)
            let coinModel=CoinModel(rate: coinData.rate, asset_id_quote: coinData.asset_id_quote)
            return coinModel
        } catch  {
            delegate?.didFailWithError(error: error)
        }
        
        return nil
    }
    
}
