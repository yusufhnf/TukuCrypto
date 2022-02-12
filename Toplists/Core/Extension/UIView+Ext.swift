//
//  UIView+Ext.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 11/02/22.
//
import UIKit
extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach{ addSubview($0) }
  }
  
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              leading: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              trailing: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeading: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingTrailing: CGFloat = 0,
              width: CGFloat? = nil,
              height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
    }
    
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func center(inView view: UIView, yConstant: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
  }
  
  func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
    }
  }
  
  func centerY(inView view: UIView, leadingAnchor: NSLayoutXAxisAnchor? = nil,
               paddingLeading: CGFloat = 0, constant: CGFloat = 0) {
    
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    if let leading = leadingAnchor {
      anchor(leading: leading, paddingLeading: paddingLeading)
    }
  }
  
  func setDimensions(height: CGFloat, width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func setHeight(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func setHeightForGreaterThanEqual(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
  }
  
  func setWidth(_ width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func setWidthForGreaterThanEqual(_ width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
  }
  
}
