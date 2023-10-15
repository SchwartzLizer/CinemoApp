//
//  HomeViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation
import Combine


// MARK: - HomeViewModelUpdater

class HomeViewModelUpdater {
  static let shared = HomeViewModelUpdater()

  let updateSubject = PassthroughSubject<Void, Never>()
}

// MARK: - HomeViewModel

class HomeViewModel: ViewModel {

  // MARK: Lifecycle

  init() {
    self.requestMovieList()
    self.setupBindings()

    HomeViewModelUpdater.shared.updateSubject
      .sink { [weak self] in
        self?.needtoReload = true
      }
      .store(in: &self.cancellables)
  }

  // MARK: Public

  public var cancellables: [AnyCancellable] = []
  public var isSearching = false
  public var currentOffset = CGPoint()
  public var needtoReload = false

  // MARK: Search
  public var searchText = PassthroughSubject<String, Never>()

  // MARK: Internal

  // MARK: Data
  private(set) var errorState: CurrentValueSubject<ErrorState, Never> = CurrentValueSubject(.none)
  private(set) var movieList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])
  private(set) var searchQueryList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])

  // MARK: Private

  private var savedSearchText = ""
  private var onUpdated: (() -> Void)?

}

// MARK: RequestService

extension HomeViewModel: RequestService {
  func requestMovieList() {
    LoadingManager.shared.showLoading()
    Network.shared.request(router: .movieList) { (result: Result<MovieListModel>) in
      switch result {
      case .success(let data):
        self.errorState.send(.none)
        guard let data = data.movies else { return }
        self.processDataSource(data: data)
        LoadingManager.shared.hideLoading()
      case .failure(let error):
        self.errorState.send(.serviceNotFound)
        self.searchQueryList.send([])
        self.movieList.send([])
        LoadingManager.shared.hideLoading()
        Logger.print(error.localizedDescription)
      }
    }
  }

  func refresh() {
    self.movieList.send([])
    self.searchQueryList.send([])
    self.requestMovieList()
  }

}

// MARK: ProcessDataSource

extension HomeViewModel: ProcessDataSource {

  // MARK: Internal

  func processDataSource(data: [Movie]) {
    if self.isSearching {
      self.movieList.send(data)
      searchMovieList(query: self.savedSearchText)
    } else {
      self.movieList.send(data)
    }
  }

  // MARK: Private

  private func setupBindings() {
    self.searchText
      .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
      .sink { [weak self] query in
        self?.savedSearchText = query
        self?.searchMovieList(query: query)
      }
      .store(in: &self.cancellables)
  }

}

// MARK: Logic

extension HomeViewModel: Logic {
  func searchMovieList(query: String) {
    if query.isEmpty {
      self.errorState.send(.none)
      self.isSearching = false
      self.searchQueryList.send([])
    } else {
      self.isSearching = true
      let allMovies = self.movieList.value
      let filteredMovies = allMovies.filter { $0.titleEn?.lowercased().contains(query.lowercased()) == true }
      if filteredMovies.isEmpty {
        self.errorState.send(.notFound)
      } else {
        self.errorState.send(.none)
      }
      self.searchQueryList.send(filteredMovies)
    }
  }

}

