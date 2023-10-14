//
//  Router.swift
//  Template Project
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

enum Router {
  case movieList

  // MARK: Internal

  func request() throws -> URLRequest {
    let urlString = "\(Router.baseURLString)\(self.path)"

    guard let url = URL(string: urlString) else {
      throw ErrorType.parseUrlFail
    }

    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    request.httpMethod = self.method.value
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    switch self {
    default: return request
    }
  }

  // MARK: Private

  private enum HTTPMethod {
    case get
    case post
    case put
    case delete

    var value: String {
      switch self {
      case .get: return "GET"
      case .post: return "POST"
      case .put: return "PUT"
      case .delete: return "DELETE"
      }
    }
  }

  private static let baseURLString = Configuration.baseURL

  private var method: HTTPMethod {
    switch self {
    case .movieList: return .get
    }
  }

  private var path: String {
    switch self {
    case .movieList: return "get_movie_avaiable"
    }
  }

}
