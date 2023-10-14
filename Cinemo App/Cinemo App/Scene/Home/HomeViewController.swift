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
    applyTheme()
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
      cell.selectionStyle = .none
      cell.delegate = self
      return cell
    }
    dataSource.defaultRowAnimation = .automatic
    return dataSource
  }()

  private lazy var themeManager = ThemeManager.currentTheme()

  private var cellList: [(identifier: String, nib: UINib)] {
    return [
      (
        identifier: MovieTableViewCell.identifier,
        nib: MovieTableViewCell.nib),
    ]
  }

  private var cellHeaderList: [(identifier: String, nib: UINib)] {
    return [
      (
        identifier: HeaderTableViewCell.identifier,
        nib: HeaderTableViewCell.nib),
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

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
  func setupTableView() {
    self.cellList.forEach { identifier, nib in
      self.tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    self.cellHeaderList.forEach { identifier, nib in
      self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    self.tableView.delegate = self
    self.tableView.dataSource = self.dataSource
    self.tableView.separatorStyle = .none
    self.tableView.selectionFollowsFocus = false
    self.tableView.allowsSelection = false
    self.tableView.backgroundColor = .white
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
    headerView.headerLabel.text = "Movie Finder"
    return headerView
  }

  func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
    return 30
  }

}

// MARK: Action, MovieTableViewCellDelegate

extension HomeViewController: Action,MovieTableViewCellDelegate {
  func didSelectViewMore(data: Movie) {
    let detailVC = DetailViewController(viewModel: DetailViewModel(data: data))
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}

// MARK: ApplyTheme

extension HomeViewController: ApplyTheme {
  func applyTheme() {
    self.applyThemeNavBar()
  }

  func applyThemeNavBar() {
      
    self.title = "Cinemo"
  }
}


