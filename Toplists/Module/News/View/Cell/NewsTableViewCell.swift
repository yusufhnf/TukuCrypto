//
//  NewsTableViewCell.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
  private let SourceNewsText: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .darkGray
    
    return label
  }()
  
  private let titleNewsText: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.numberOfLines = 0
    
    return label
  }()
  
  private let bodyNewsText: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 0
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupCell() {
    contentView.addSubviews(SourceNewsText, titleNewsText, bodyNewsText)
    
    SourceNewsText.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, paddingTop: 8, paddingLeading: 16)
    titleNewsText.anchor(top: SourceNewsText.bottomAnchor, leading: SourceNewsText.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 8, paddingTrailing: 16)
    bodyNewsText.anchor(top: titleNewsText.bottomAnchor, leading: titleNewsText.leadingAnchor, bottom: contentView.bottomAnchor, trailing: titleNewsText.trailingAnchor, paddingTop: 8, paddingBottom: 8)
  }
  
  func configure(data: NewsData) {
    SourceNewsText.text = data.sourceData.name
    titleNewsText.text = data.title
    bodyNewsText.text = data.body
  }
  
}
