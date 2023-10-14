//
//  FavouriteViewController.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit
import Combine

// MARK: - FavouriteViewController

class FavouriteViewController: UIViewController {

    // MARK: Lifecycle

    required init(viewModel: FavouriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: FavouriteViewController.identifier, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyTheme()
        self.onInitialized()
    }

    // MARK: Public


    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }

    // MARK: Internal

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!

    // MARK: Private

    private enum TableSection {
        case main
    }

    private var viewModel : FavouriteViewModel
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
                cell.viewModel = MovieTableViewModel(movies: data)
                cell.selectionStyle = .none
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

extension FavouriteViewController: Updated {
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
}


// MARK: UserInterfaceSetup, UITableViewDelegate, UISearchBarDelegate

extension FavouriteViewController: UserInterfaceSetup,UITableViewDelegate,UISearchBarDelegate {
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
        self.tableView.backgroundColor = .white
        self.refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }

    func setupSearchView() {
        self.searchView.delegate = self
        self.searchView.placeholder = Constants.Keys.homeSearchBarPlaceHolder.localized()
        self.searchView.searchBarStyle = .minimal
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        headerView.headerLabel.text = "My Favourite"
        return headerView
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 30
    }

}

// MARK: Action, MovieTableViewCellDelegate

extension FavouriteViewController: Action,MovieTableViewCellDelegate {
    func didSelectViewMore(data: Movie) {
        let detailVC = DetailViewController(viewModel: DetailViewModel(data: data))
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchText.send(searchText)
    }

    @objc
    func handleRefresh() {
        self.viewModel.refresh()
    }


}

// MARK: ApplyTheme

extension FavouriteViewController: ApplyTheme {
    func applyTheme() {
        self.applyThemeNavBar()
    }

    func applyThemeNavBar() {
        self.title = Constants.Keys.appName.localized()
    }

}


