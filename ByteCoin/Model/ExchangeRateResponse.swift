//
//  ExchangeRateResponse.swift
//  ByteCoin
//
//  Created by Muhammad Shayan on 03/09/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeRateResponse: Codable {
    
    let time: String?
    let assetId: String?
    let currency: String?
    let exchangeRate: Double?
    
    enum CodingKeys: String, CodingKey {
        case time
        case assetId = "asset_id_base"
        case currency = "asset_id_quote"
        case exchangeRate = "rate"
    }
    
}
