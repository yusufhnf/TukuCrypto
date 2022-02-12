//
//  HomeViewModel.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
  func reloadData()
  func handleError(error: NetworkingErrorResponse)
  func displayPriceChangeUpdate(viewModel: CryptosModel.SubscribePriceChange.ViewModel)
}

class HomeViewModel {
  private let cryptosRepository: CryptosRepository
  private let numberFormat = NumberFormat()
  private let liveProgressService: LiveProgressServiceProtocol
  private var cryptoResponse: [ToplistData]?
  weak var delegate: HomeViewModelDelegate?
  var cryptosData: [CryptosModel.DisplayedCryptos] = []
  
  init(cryptosRepository: CryptosRepository = CryptosRepository.shared,
       liveProgressService: LiveProgressServiceProtocol = LiveProgressService.shared) {
    self.cryptosRepository = cryptosRepository
    self.liveProgressService = liveProgressService
  }
  
  func fetchCryptosData() {
    DispatchQueue.global().async {
      self.cryptosRepository.getCryptosData { [weak self] result in
        switch result {
        case let .success(data):
          do {
            let dataObj = try JSONDecoder().decode(CryptosResponse.self, from: data)
            let cryptosData = dataObj.data
            self?.cryptoResponse = cryptosData
            let responseCryptos = cryptosData.map{ (crypto) -> CryptosModel.ResponseCryptos in
              guard let raw = crypto.raw else {
                return CryptosModel.ResponseCryptos(hasEmptyPrice: true,
                                                    name: crypto.coinInfo.name,
                                                    fullName: crypto.coinInfo.fullName,
                                                    price: nil,
                                                    priceChangePct: nil,
                                                    priceChange: nil,
                                                    isNegative: nil)
              }
              guard let calculatedPriceChange = self?.numberFormat.calculatePriceChanges(currentPrice: raw.usd.price,
                                                                                         openHourPrice: raw.usd.open24Hour) else {
                fatalError()
              }
              return CryptosModel.ResponseCryptos(hasEmptyPrice: false,
                                                  name: crypto.coinInfo.name,
                                                  fullName: crypto.coinInfo.fullName,
                                                  price: crypto.raw?.usd.price,
                                                  priceChangePct: calculatedPriceChange.priceChangePct,
                                                  priceChange: calculatedPriceChange.priceChange,
                                                  isNegative: calculatedPriceChange.isNegative)
            }
            self?.cryptosData.removeAll()
            self?.cryptosData = self?.getDisplayedCryptos(cryptos: responseCryptos) ?? []
            self?.delegate?.reloadData()
            self?.subscribeToPriceChanges()
          } catch {
            self?.delegate?.handleError(error: .invalidResponse)
          }
        case .failure(let error):
          print("Error: \(error)")
          self?.delegate?.handleError(error: .invalidRequest)
        }
      }
    }
  }
  
  private func getDisplayedCryptos(cryptos: [CryptosModel.ResponseCryptos]?) -> [CryptosModel.DisplayedCryptos]? {
    guard let cryptos = cryptos else {
      return nil
    }
    
    let displayedCryptoss: [CryptosModel.DisplayedCryptos] =  cryptos.map { (crypto) -> CryptosModel.DisplayedCryptos in
      var totalPriceChange: String? = nil
      var price: String? = nil
      
      if !crypto.hasEmptyPrice {
        let formattedPrice = numberFormat.formatPrice(price: crypto.price!,
                                                      priceChange: crypto.priceChange!,
                                                      priceChangePct: crypto.priceChangePct!,
                                                      isNegative: crypto.isNegative!)
        price = formattedPrice.price
        totalPriceChange = formattedPrice.priceChangeTotal
      }
      
      let displayedCryptos = CryptosModel.DisplayedCryptos(
        name: crypto.name,
        fullName: crypto.fullName,
        price: price,
        priceChange: totalPriceChange,
        isNegative: crypto.isNegative,
        hasEmptyPrice: crypto.hasEmptyPrice
      )
      return displayedCryptos
    }
    return displayedCryptoss
  }
  
  func subscribeToPriceChanges() {
    liveProgressService.unsubscribe()
    guard let cryptos = cryptoResponse else {
      return
    }
    let subscribtionsId: [String] = cryptos.map({ cryptosItem in
      return cryptosItem.coinInfo.name
    })
    liveProgressService.subscribe(subsId: subscribtionsId) { [weak self] response in
      let indexToUpdate = cryptos.firstIndex{$0.coinInfo.name == response.fromSymbol}
      let topListToUpdate = cryptos[indexToUpdate!]
      var openHourPrice = topListToUpdate.raw?.usd.open24Hour
      
      if let newOpenHourPRice = response.open24Hour {
        openHourPrice = newOpenHourPRice
      }
      
      let updatedPriceChanges = self?.numberFormat.calculatePriceChanges(currentPrice: response.price, openHourPrice: openHourPrice!)
      let isNegative = updatedPriceChanges?.priceChange.sign == .minus
      
      let updatedTopList = CryptosModel.ResponseCryptos(hasEmptyPrice: false,
                                                        name: topListToUpdate.coinInfo.name,
                                                        fullName: topListToUpdate.coinInfo.fullName,
                                                        price: response.price,
                                                        priceChangePct: updatedPriceChanges!.priceChangePct,
                                                        priceChange: updatedPriceChanges!.priceChange,
                                                        isNegative: isNegative)
      
      let response = CryptosModel.SubscribePriceChange.Response(updatedCryptos: updatedTopList,index: indexToUpdate!)
      self?.presentPriceChangeUpdate(response: response)
    }
  }
  
  func presentPriceChangeUpdate(response: CryptosModel.SubscribePriceChange.Response) {
    let formattedPrice = numberFormat.formatPrice(price: response.updatedCryptos.price!, priceChange: response.updatedCryptos.priceChange!, priceChangePct: response.updatedCryptos.priceChangePct!, isNegative: response.updatedCryptos.isNegative!)
    
    let displayedCryptos = CryptosModel.DisplayedCryptos(name: response.updatedCryptos.name, fullName: response.updatedCryptos.fullName, price: formattedPrice.price, priceChange: formattedPrice.priceChangeTotal, isNegative: response.updatedCryptos.isNegative, hasEmptyPrice: response.updatedCryptos.hasEmptyPrice)
    
    let viewModel = CryptosModel.SubscribePriceChange.ViewModel(index: response.index, displayedCryptos: displayedCryptos)
    
    self.delegate?.displayPriceChangeUpdate(viewModel: viewModel)
  }
}
