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
  
  init() {
    self.requestMovieList()
  }

  public var cancellables: [AnyCancellable] = []
  private (set) var movieList: CurrentValueSubject<[Movie], Never> = CurrentValueSubject([])

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
