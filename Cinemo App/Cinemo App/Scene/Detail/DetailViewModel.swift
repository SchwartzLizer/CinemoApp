//
//  DetailViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

final class DetailViewModel: ViewModel {

  init(data: Movie) {
    self.data = data
  }

  private (set) var data: Movie
}
