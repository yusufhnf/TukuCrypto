//
//  NewsViewController.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import UIKit

class NewsViewController: UIViewController {
  
  private let navBar: UINavigationBar = {
    let navBar = UINavigationBar()
    let navBarTitle = UINavigationItem(title: AppConstants.Title.newsTitle)
    navBar.setBackgroundImage(UIImage(), for: .default)
    navBar.setItems([navBarTitle], animated: true)
    
    return navBar
  }()
  
  private let tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    
    return tv
  }()
  
  private let newsCategories: String
  private let viewModel = NewsViewModel()
  
  init(newsCategories: String) {
    self.newsCategories = newsCategories
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    getData()
    setupTableView()
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(navBar, tableView)
    
    navBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 55)
    
    tableView.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
  }
  
  private func getData() {
    self.showActivityIndicator()
    viewModel.fetchNews(newsCategories) { [weak self] (data, error) in
      guard let self = self else { return }
      
      if error != nil  {
        self.removeActivityIndicator()
        ShowAlert.present(title: "Error", message: error!.localizedDescription, actions: .ok(handler: {
          self.dismiss(animated: true, completion: nil)
        }), from: self)
        return
      }
      
      guard let data = data else {
        return
      }
      
      self.viewModel.newsData.removeAll()
      self.viewModel.newsData = data
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.removeActivityIndicator()
        self.tableView.reloadData()
      }
    }
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: AppConstants.CellIdentifier.newsCell)
  }
  
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.newsData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifier.newsCell, for: indexPath) as! NewsTableViewCell
    cell.selectionStyle = .none
    
    let newsData = viewModel.newsData[indexPath.row]
    cell.configure(data: newsData)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
