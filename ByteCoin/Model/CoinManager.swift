//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func onSuccess(exchangeRateModel: ExchangeRateResponse)
    func onFailure(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A277B39D-A897-4746-93E9-30B8DDA00CE3"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.onFailure(error: error!)
                    return
                }
                if let safeData = data {
                    if let modelData = self.parseJSON(safeData) {
                        self.delegate?.onSuccess(exchangeRateModel: modelData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data?) -> ExchangeRateResponse? {
        let jsonDecoder = JSONDecoder()
        do {
            let parsedData = try jsonDecoder.decode(ExchangeRateResponse.self, from: data ?? Data())
            return parsedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
