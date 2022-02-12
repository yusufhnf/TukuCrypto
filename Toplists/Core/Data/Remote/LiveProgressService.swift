//
//  WebSocketAPI.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 11/02/22.
//

import Foundation
import Starscream

protocol LiveProgressServiceProtocol {
  func subscribe(subsId: [String], completion: @escaping ((LiveProgressCryptoResponse)->Void))
  func unsubscribe()
}

class LiveProgressService: LiveProgressServiceProtocol {
  var webSocket: WebSocket?
  private init() {}
  static let shared = LiveProgressService()
  
  func subscribe(subsId: [String], completion: @escaping ((LiveProgressCryptoResponse) -> Void)) {
    let subs = subsId.map { sub in
      return "2~Coinbase~\(sub)~USD"
    }
    guard let apiKey = AppConstants.Network.apiKey else {
      return print("API Key not Found")
    }
    var request = URLRequest(url: URL(string: "wss://streamer.cryptocompare.com/v2?api_key=\(apiKey)")!)
    webSocket = WebSocket(request: request)
    
    webSocket?.onEvent = { [weak self] event in
      switch event {
      case .connected(let dictionary):
        print("connected \(dictionary)")
        let liveTickerSub = SubModel(action: "SubAdd", subs: subs)
        let data = try! JSONEncoder().encode(liveTickerSub)
        self?.webSocket?.write(data: data)
      case .disconnected(let message, let closeCode):
        print("disconnect  \(closeCode): \(message)")
      case .text(let string):
        print("received success: \(string)")
        guard let data = self?.handleData(dataString: string) else {
          return
        }
        completion(data)
      case .binary(let binary):
        print("received binary \(binary)")
      case .pong(_):
        print("pong")
      case .ping(_):
        print("ping")
      case .error(let error):
        print("error \(String(describing: error))")
      case .viabilityChanged(_):
        print("viabilityChanged")
      case .reconnectSuggested(_):
        print("reconnectSuggested")
      case .cancelled:
        print("cancelled")
      }
    }
    request.timeoutInterval = 10
    webSocket?.connect()
  }
  
  func handleData(dataString: String) -> LiveProgressCryptoResponse? {
    guard let dataRaw = dataString.data(using: .utf8) else {
      print("Failed dataraw")
      return nil
    }
    
    guard let data = try? JSONDecoder().decode(LiveProgressCryptoResponse.self, from: dataRaw) else {
      return nil
    }
    return data
  }
  
  func unsubscribe() {
    webSocket?.disconnect()
  }
}
