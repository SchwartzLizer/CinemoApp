//
//  HomeViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation
import Combine

// MARK: - HomeViewModel

class HomeViewModel: ViewModel {

    // MARK: Lifecycle

    init() {
        self.requestMovieList()
    }

    // MARK: Public

    public var cancellables: [AnyCancellable] = []
    public var isSearching = false

    // MARK: Internal

    private(set) var errorState: CurrentValueSubject<ErrorState, Never> = CurrentValueSubject(.none)
    private(set) var movieList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])
    private(set) var searchQueryList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])

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
                self.movieList.send(data)
                LoadingManager.shared.hideLoading()
            case .failure(let error):
                self.errorState.send(.serviceNotFound)
                self.movieList.send([])
                LoadingManager.shared.hideLoading()
                Logger.print(error.localizedDescription)
            }
        }
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
