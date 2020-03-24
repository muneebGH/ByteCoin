//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Muneeb Ur Rehman on 11/09/2019.
//  Copyright © 2019 Muneebs. All rights reserved.
//
import Foundation


struct CoinModel {
    var rate:Double
    var asset_id_quote:String
    var rateString:String{
        String(format:"%.2f",rate)
    }
}
