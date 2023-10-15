//
//  HomeViewController.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit
import Combine

// MARK: - HomeViewController

class HomeViewController: UIViewController {

  // MARK: Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.applyTheme()
    self.onInitialized()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      LoadingManager.shared.showLoading() // First time load
    }
  }

  override func viewWillDisappear(_: Bool) {
    self.viewModel.currentOffset = self.tableView.contentOffset // Save lastest offset
  }

  override func viewWillAppear(_: Bool) {
    self.checkUpdateListner()
  }

  deinit {
    self.viewModel.cancellables.forEach { $0.cancel() }
  }

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchView: UISearchBar!

  // MARK: Private

  private enum TableSection {
    case main
  }

  private var viewModel = HomeViewModel()
  private let refreshControl = UIRefreshControl()

  private lazy var dataSource: UITableViewDiffableDataSource<TableSection, Movie>? = {
    guard let tableView = self.tableView else {
      fatalError("TableView is nil")
    }
    let dataSource = UITableViewDiffableDataSource<TableSection, Movie>(
      tableView: tableView)
    { tableView, indexPath, data -> UITableViewCell? in
      switch self.viewModel.errorState.value {
      case .notFound:
        let cell = tableView.dequeueReusableCell(
          withIdentifier: EmptyStateTableViewCell.identifier,
          for: indexPath) as! EmptyStateTableViewCell
        cell.viewModel = EmptyStateViewModel(type: .notFound)
        cell.selectionStyle = .none
        return cell
      case .serviceNotFound:
        let cell = tableView.dequeueReusableCell(
          withIdentifier: EmptyStateTableViewCell.identifier,
          for: indexPath) as! EmptyStateTableViewCell
        cell.viewModel = EmptyStateViewModel(type: .serviceNotFound)
        cell.selectionStyle = .none
        return cell
      case .unknown:
        let cell = tableView.dequeueReusableCell(
          withIdentifier: EmptyStateTableViewCell.identifier,
          for: indexPath) as! EmptyStateTableViewCell
        cell.viewModel = EmptyStateViewModel(type: .unknown)
        cell.selectionStyle = .none
        return cell
      case .favouriteEmpty:
        let cell = tableView.dequeueReusableCell(
          withIdentifier: EmptyStateTableViewCell.identifier,
          for: indexPath) as! EmptyStateTableViewCell
        cell.viewModel = EmptyStateViewModel(type: .favouriteEmpty)
        cell.selectionStyle = .none
        return cell
      case .none:
        let cell = tableView.dequeueReusableCell(
          withIdentifier: MovieTableViewCell.identifier,
          for: indexPath) as! MovieTableViewCell
        cell.viewModel = MovieTableViewModel(data: data)
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = self.theme.tableViewBackgroundColor
        cell.delegate = self
        return cell
      }
    }
    dataSource.defaultRowAnimation = .fade
    return dataSource
  }()

  private lazy var theme = StyleSheetManager.currentTheme()
  private lazy var font = StyleSheetManager.currentFontTheme()

  private var cellList: [(identifier: String, nib: UINib)] {
    return [
      (
        identifier: MovieTableViewCell.identifier,
        nib: MovieTableViewCell.nib),
      (
        identifier: EmptyStateTableViewCell.identifier,
        nib: EmptyStateTableViewCell.nib),
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
  func onInitialized() {
    Publishers.CombineLatest3(self.viewModel.movieList, self.viewModel.searchQueryList, self.viewModel.errorState)
      .sink { [weak self] data, searchQuery, errorState in
        guard let self = self else { return }
        if errorState != .none {
          self.updateTableView(data: [Movie.placeholderError])
        } else if searchQuery.isEmpty {
          self.updateTableView(data: data)
        } else {
          self.updateTableView(data: searchQuery)
        }
        self.refreshControl.endRefreshing()
      }.store(in: &self.viewModel.cancellables)
  }

  func updateTableView(data: [Movie]) {
    var snapshot = NSDiffableDataSourceSnapshot<TableSection, Movie>()
    snapshot.appendSections([.main])
    snapshot.appendItems(data)
    self.dataSource?.apply(snapshot, animatingDifferences: true)
  }

  func checkUpdateListner() {
    if self.viewModel.needtoReload {
      self.tableView.reloadData()
      self.viewModel.needtoReload = false
    }
    self.tableView.layoutIfNeeded() // Force layout update
    self.tableView.setContentOffset(self.viewModel.currentOffset, animated: false)
  }

}


// MARK: UserInterfaceSetup, UITableViewDelegate, UISearchBarDelegate

extension HomeViewController: UserInterfaceSetup,UITableViewDelegate,UISearchBarDelegate {
  func setupUI() {
    self.setupSearchView()
    self.setupTableView()
  }

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
    self.tableView.backgroundColor = self.theme.tableViewBackgroundColor
    self.refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    self.tableView.refreshControl = self.refreshControl
    self.tableView.accessibilityIdentifier = Constants.AccessibilityIdentifier.HomeViewController.homeTableView
  }

  func setupSearchView() {
    self.searchView.delegate = self
    self.searchView.placeholder = Constants.Keys.homeSearchBarPlaceHolder.localized()
    self.searchView.searchBarStyle = .minimal
    self.searchView.searchTextField.font = self.font.searchFont
    self.searchView.accessibilityIdentifier = Constants.AccessibilityIdentifier.HomeViewController.homeSearchBar
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
    headerView.headerLabel.text = Constants.Keys.homeHeaderTBC.localized()
    return headerView
  }

  func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
    return Height.header.rawValue
  }

}

// MARK: Action, MovieTableViewCellDelegate

extension HomeViewController: Action,MovieTableViewCellDelegate {
  func didSelectFavourite() {
    HapticFeedback.successNotification()
  }

  func didSelectViewMore(data: Movie) {
    HapticFeedback.lightImpact()
    let detailVC = DetailViewController(viewModel: DetailViewModel(data: data))
    self.navigationController?.pushViewController(detailVC, animated: true)
  }

  @objc
  func didSelectFavorite() {
    HapticFeedback.mediumImpact()
    let favoriteVC = FavouriteViewController(viewModel: FavouriteViewModel())
    self.navigationController?.pushViewController(favoriteVC, animated: true)
  }

  func searchBar(_: UISearchBar, textDidChange searchText: String) {
    HapticFeedback.lightImpact()
    self.viewModel.searchText.send(searchText)
  }

  @objc
  func handleRefresh() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.viewModel.refresh()
    }
  }

  @objc
  func didSelectChangeMode() {
    HapticFeedback.mediumImpact()
    AppUtility().toggleMode()
  }


}

// MARK: ApplyTheme

extension HomeViewController: ApplyTheme {
  func applyTheme() {
    self.applyThemeNavBar()
  }

  func applyThemeNavBar() {
    let favoriteButton = UIBarButtonItem(
      image: UIImage(systemName: Constants.SystemImage.heartFill),
      style: .plain,
      target: self,
      action: #selector(self.didSelectFavorite))
    favoriteButton.tintColor = self.theme.heartColor

    let changeModeButton = UIBarButtonItem(
      image: UIImage(systemName: Constants.SystemImage.moonFill),
      style: .plain,
      target: self,
      action: #selector(self.didSelectChangeMode))
    changeModeButton.tintColor = self.theme.moonColor

    self.navigationItem.leftBarButtonItem = changeModeButton
    self.navigationItem.rightBarButtonItem = favoriteButton
    self.title = Constants.Keys.appName.localized()
  }

}


