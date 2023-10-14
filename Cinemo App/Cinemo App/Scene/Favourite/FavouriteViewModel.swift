//
//  FavouriteViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//


import Foundation
import Combine

// MARK: - FavouriteViewModel

class FavouriteViewModel: ViewModel {

    // MARK: Lifecycle

    init() {
        getFavourite()
        self.setupBindings()
    }

    // MARK: Public

    public var cancellables: [AnyCancellable] = []
    public var isSearching = false

    // MARK: Search
    public var searchText = PassthroughSubject<String, Never>()

    // MARK: Internal

    // MARK: Data
    private(set) var errorState: CurrentValueSubject<ErrorState, Never> = CurrentValueSubject(.none)
    private(set) var movieList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])
    private(set) var searchQueryList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])

    // MARK: Private

    private var savedSearchText = ""
    private var isNoFavorite = false

}

// MARK: RequestService

extension FavouriteViewModel: RequestService {
    func getFavourite() {
        if UserDefault().getFavorite().isEmpty {
            self.isNoFavorite = true
            self.errorState.send(.favouriteEmpty)
        } else {
            self.isNoFavorite = false
            self.errorState.send(.none)
            self.movieList.send(UserDefault().getFavorite())
        }
    }

    func refresh() {
        self.movieList.send([])
        self.searchQueryList.send([])
        self.getFavourite()
    }
}

// MARK: ProcessDataSource

extension FavouriteViewModel: ProcessDataSource {

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

extension FavouriteViewModel: Logic {
    func searchMovieList(query: String) {
        if self.isNoFavorite {
            self.errorState.send(.favouriteEmpty)
        } else {
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

}
