//
//  HomeTableViewController.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 10/02/22.
//

import UIKit

class HomeTableViewController: UIViewController {
  var cellId = AppConstants.CellIdentifier.cryptoCell
  private let viewModel = HomeViewModel()
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    return tableView
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshCtrl = UIRefreshControl()
    refreshCtrl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    
    return refreshCtrl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    getData()
    setupTable()
  }
  
  private func setupUI() {
    title = AppConstants.Title.homeTitle
    self.extendedLayoutIncludesOpaqueBars = true
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
  }
  
  func getData() {
    self.showActivityIndicator()
    viewModel.fetchCryptosData()
    viewModel.delegate = self
  }
  
  private func setupTable() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.refreshControl = refreshControl
  }
  
  @objc
  private func didPullRefresh() {
    viewModel.fetchCryptosData()
  }
}

extension HomeTableViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CryptoTableViewCell
    cell.configure(displayedCryptos: viewModel.cryptosData[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cryptosData.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

extension HomeTableViewController: HomeViewModelDelegate {
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.refreshControl?.endRefreshing()
      self.removeActivityIndicator()
      self.tableView.reloadData()
    }
  }
  
  func handleError(error: NetworkingErrorResponse) {
    switch error {
    case .invalidResponse:
      ShowAlert.present(title: "Error", message: error.localizedDescription, actions: .close, from: self)
      
    case .invalidRequest:
      showActivityIndicator()
      ShowAlert.present(title: "Error", message: error.localizedDescription, actions: .retry(handler: {
        self.viewModel.fetchCryptosData()
      }), from: self)
    }
  }
  
  func displayPriceChangeUpdate(viewModel: CryptosModel.SubscribePriceChange.ViewModel) {
    let indexPath = IndexPath(item: viewModel.index, section: 0)
    self.viewModel.cryptosData[viewModel.index] = viewModel.displayedCryptos
    DispatchQueue.main.async { [weak self] in
      UIView.performWithoutAnimation {
        self?.tableView.reconfigureRows(at: [indexPath])
      }
    }
  }
}
