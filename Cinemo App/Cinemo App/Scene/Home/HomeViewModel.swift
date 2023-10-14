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

    // MARK: Internal

    private(set) var movieList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])
    private(set) var searchQueryList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])

}

// MARK: RequestService

extension HomeViewModel: RequestService {
    func requestMovieList() {
        Network.shared.request(router: .movieList) { (result: Result<MovieListModel>) in
            switch result {
            case .success(let data):
                guard let data = data.movies else { return }
                self.movieList.send(data)
            case .failure(let error):
                Logger.print(error.localizedDescription)
            }
        }
    }

}

// MARK: Logic

extension HomeViewModel: Logic {
    func searchMovieList(query: String) {
        if query.isEmpty {
            self.searchQueryList.send([])
        } else {
            let allMovies = self.movieList.value
            let filteredMovies = allMovies.filter { $0.titleEn?.lowercased().contains(query.lowercased()) == true }
            self.searchQueryList.send(filteredMovies)
        }
    }

}
