//
//  MovieTableViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

class MovieTableViewModel: Codable {

  init(movies: Movie) {
    self.movies = movies
  }

  let movies: Movie
}
