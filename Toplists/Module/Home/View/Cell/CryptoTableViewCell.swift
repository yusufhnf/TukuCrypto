//
//  CryptoTableViewCell.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 10/02/22.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
  
  private let cryptoNameText : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    label.text = "-"
    return label
  }()
  
  private let cryptoFullNameText: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .left
    label.text = "-"
    return label
  }()
  
  private let cryptoCurrentPriceText : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .right
    label.text = "-"
    return label
  }()
  
  private let cryptoProgressPriceText: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .right
    label.text = "-"
    return label
  }()
  
  private let progressPriceTextContainer: UIView = {
    let view = UIView()
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupCell() {
    addSubview(cryptoNameText)
    addSubview(cryptoFullNameText)
    addSubview(cryptoCurrentPriceText)
    addSubview(progressPriceTextContainer)
    addSubview(cryptoProgressPriceText)
    
    cryptoNameText.anchor(top: topAnchor, leading: leadingAnchor, paddingTop: 8, paddingLeading: 16)
    
    cryptoFullNameText.anchor(top: cryptoNameText.topAnchor, leading: cryptoNameText.leadingAnchor, bottom: bottomAnchor, paddingTop: 32, paddingBottom: 16)
    
    cryptoCurrentPriceText.anchor(trailing: trailingAnchor, paddingTrailing: 16)
    cryptoCurrentPriceText.centerY(inView: cryptoNameText)
    
    cryptoProgressPriceText.anchor(leading: progressPriceTextContainer.leadingAnchor, trailing: progressPriceTextContainer.trailingAnchor, paddingLeading: 8, paddingTrailing: 8)
    cryptoProgressPriceText.centerY(inView: progressPriceTextContainer)
    cryptoProgressPriceText.textColor = .white
    
    progressPriceTextContainer.anchor(trailing: trailingAnchor, paddingTrailing: 16, height: 26)
    progressPriceTextContainer.centerY(inView: cryptoFullNameText)
    progressPriceTextContainer.setWidthForGreaterThanEqual(0)
    progressPriceTextContainer.layer.cornerRadius = 4
    progressPriceTextContainer.backgroundColor = .systemGreen
  }
  
  func configure(displayedCryptos: CryptosModel.DisplayedCryptos) {
    cryptoNameText.text = displayedCryptos.name
    cryptoFullNameText.text = displayedCryptos.fullName
    
    guard !displayedCryptos.hasEmptyPrice,
          let price = displayedCryptos.price,
          let priceChange = displayedCryptos.priceChange,
          let isNegative = displayedCryptos.isNegative
    else
    {
      progressPriceTextContainer.backgroundColor = .gray
      cryptoCurrentPriceText.text = "-"
      cryptoProgressPriceText.text = "-"
      return
    }
    
    cryptoCurrentPriceText.text = price
    cryptoProgressPriceText.text = priceChange
    progressPriceTextContainer.backgroundColor = isNegative ? .systemRed : .systemGreen
  }
}
