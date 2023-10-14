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
        setupUI()
        applyTheme()
        self.onUpdated()
    }

    // MARK: Internal

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!

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
        dataSource.defaultRowAnimation = .fade
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
        Publishers.CombineLatest(self.viewModel.movieList, self.viewModel.searchQueryList)
            .sink { [weak self] data, searchQuery in
                guard let self = self else { return }
                if searchQuery.isEmpty {
                    self.updateTableView(data: data)
                } else {
                    self.updateTableView(data: searchQuery)
                }
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
        self.tableView.backgroundColor = .white
    }


    func setupSearchView() {
        self.searchView.delegate = self
        self.searchView.placeholder = Constants.Keys.homeSearchBarPlaceHolder.localized()
        self.searchView.searchBarStyle = .minimal
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

    @objc
    func didSelectFavorite() {
//        let favoriteVC = FavoriteViewController()
//        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchMovieList(query: searchText)
    }

}

// MARK: ApplyTheme

extension HomeViewController: ApplyTheme {
    func applyTheme() {
        self.applyThemeNavBar()
    }

    func applyThemeNavBar() {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(self.didSelectFavorite))

        self.title = Constants.Keys.appName.localized()
    }

}


