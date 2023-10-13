//
//  HomeViewController.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

// MARK: - HomeViewController

class HomeViewController: UIViewController {

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    self.onUpdated()
  }

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!

  // MARK: Private

  private enum TableSection {
    case main
  }

  private var viewModel = HomeViewModel()

  private lazy var dataSource: UITableViewDiffableDataSource<TableSection, Movie>? = {
    guard let tableView = self.tableView else {
      fatalError("TableView is nil")
    }
    let dataSource = UITableViewDiffableDataSource<TableSection, Movie>(
      tableView: tableView)
    { tableView, indexPath, data -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MovieTableViewCell.identifier,
        for: indexPath) as! MovieTableViewCell
      cell.viewModel = MovieTableViewModel(movies: data)
      return cell
    }
    dataSource.defaultRowAnimation = .automatic
    return dataSource
  }()

  private var cellList: [(identifier: String, nib: UINib)] {
    return [
      (
        identifier: MovieTableViewCell.identifier,
        nib: MovieTableViewCell.nib),
    ]
  }

}

// MARK: Updated

extension HomeViewController: Updated {
  func onUpdated() {
    self.viewModel.movieList.sink { [weak self] data in
      guard let self = self else { return }
      var snapshot = NSDiffableDataSourceSnapshot<TableSection, Movie>()
      snapshot.appendSections([.main])
      snapshot.appendItems(data)
      self.dataSource?.apply(snapshot, animatingDifferences: true)
    }.store(in: &self.viewModel.cancellables)
  }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate {
  func setupTableView() {
    self.cellList.forEach { identifier, nib in
      self.tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    self.tableView.delegate = self
    self.tableView.dataSource = dataSource
    self.tableView.separatorStyle = .none
  }
//
//  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//    return 10
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard
//      let cell = tableView
//        .dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else
//    {
//      return UITableViewCell()
//    }
//    return cell
//  }


}


