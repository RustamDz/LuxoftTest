//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation


class DataManager {
    
    private static let path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
    
    func fetchMarket(completionHandler: @escaping (Market)->()) {
        guard let url = URL(string: DataManager.path) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if (error == nil) {
                guard let data = data else { return }
                guard let self = self else { return }
                do {
                    var json = try JSONSerialization.jsonObject(with: data)
                    completionHandler(self.parseQuotesFrom(json))
                }
                catch {
                    print("unexpected")
                }
            } else {
                print(error!)
            }
        }
        task.resume()
    }
    
    func parseQuotesFrom(_ json: Any) -> Market {
        let market = Market()
        guard let quotesJson = json as? Array<Dictionary<String, Any>> else { return market }
        let quotesArray = quotesJson.map {
            Quote(key: $0["key"] as? String, symbol: $0["symbol"] as? String, name: $0["name"] as? String, currency: $0["currency"] as? String, readableLastChangePercent: $0["readableLastChangePercent"] as? String, last: $0["lastChange"] as? String, variationColor: $0["variationColor"] as? String, myMarket: market)
        }
        market.quotes = quotesArray
        return market
    }
}
