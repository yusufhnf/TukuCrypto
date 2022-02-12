//
//  ShowAlert+Ext.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import UIKit

struct ShowAlert {
  static func present(title: String?, message: String, actions: ShowAlert.Action..., from controller: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for action in actions {
      alertController.addAction(action.alertAction)
    }
    controller.present(alertController, animated: true, completion: nil)
  }
}

extension ShowAlert {
  enum Action {
    case ok(handler: (() -> Void)?)
    case retry(handler: (() -> Void)?)
    case close
    
    private var title: String {
      switch self {
      case .ok:
        return "OK"
      case .retry:
        return "Coba lagi"
      case .close:
        return "Tutup"
      }
    }
    
    private var handler: (() -> Void)? {
      switch self {
      case .ok(let handler):
        return handler
      case .retry(let handler):
        return handler
      case .close:
        return nil
      }
    }
    
    var alertAction: UIAlertAction {
      return UIAlertAction(title: title, style: .default, handler: { _ in
        if let handler = self.handler {
          handler()
        }
      })
    }
  }
}
