//
//  HomeViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

// MARK: - HomeViewModel

class HomeViewModel: ViewModel { }

// MARK: RequestService

extension HomeViewModel: RequestService {
  func requestMovieList() {
    Network.shared.request(router: .movieList) { (result: Result<MovieListModel>) in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        print(error)
      }
    }
  }

}
