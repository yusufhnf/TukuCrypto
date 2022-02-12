//
//  ActivityIndicator+Ext.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 10/02/22.
//

import UIKit
private var activityIndicatorPage: UIView?
extension UIViewController {
  func showActivityIndicator() {
    activityIndicatorPage = UIView(frame: self.view.bounds)
    activityIndicatorPage?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    activityIndicatorView.center = activityIndicatorPage!.center
    activityIndicatorView.startAnimating()
    activityIndicatorPage?.addSubview(activityIndicatorView)
    self.view.addSubview(activityIndicatorPage!)
  }
  func removeActivityIndicator() {
    DispatchQueue.main.async {
      activityIndicatorPage?.removeFromSuperview()
      activityIndicatorPage = nil
    }
  }
}
