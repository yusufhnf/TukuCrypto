//
//  NumberFormat.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

class NumberFormat {
  let formatter = NumberFormatter()
  func formatPrice(price: Double,
                   priceChange: Double,
                   priceChangePct: Double,
                   isNegative: Bool) -> (price: String, priceChangeTotal: String) {
    
    var priceChangeFormatted = String(format:"%.2f", priceChange)
    priceChangeFormatted = isNegative ? priceChangeFormatted : "+\(priceChangeFormatted)"
    var priceChangePctFormatted = String(format:"%.2f", priceChangePct)
    priceChangePctFormatted = isNegative ? priceChangePctFormatted + "%" : "+" + priceChangePctFormatted + "%"
    let priceChangeTotal = "\(priceChangeFormatted)(\(priceChangePctFormatted))"
    
    formatter.locale = Locale(identifier: "en_US")
    formatter.numberStyle = .currency
    if (price < 1) {
      formatter.minimumFractionDigits = 4
    }
    let priceFormatted = formatter.string(from: price as NSNumber)
    return (price: priceFormatted!,priceChangeTotal: priceChangeTotal)
  }
  
  func calculatePriceChanges(currentPrice: Double, openHourPrice: Double)
  -> (priceChange: Double, priceChangePct: Double, isNegative: Bool) {
    let priceChange = currentPrice-openHourPrice
    let priceChangePct = (priceChange/openHourPrice) * 100
    let isNegative = priceChange.sign == .minus
    return (priceChange,priceChangePct,isNegative)
  }
}
