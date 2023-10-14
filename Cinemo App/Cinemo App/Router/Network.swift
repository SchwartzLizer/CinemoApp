//
//  Network.swift
//  Template Project
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

class Network {
    static let shared = Network()

    private let config: URLSessionConfiguration
    private let session: URLSession

    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    func request<T: Decodable>(router: Router, completion: @escaping (Result<T>) -> ()) {
        do {
            let task = try session.dataTask(with: router.request()) { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result<T>.failure(error: error))
                        return
                    }

                    guard let statusCode = urlResponse?.getStatusCode(), (200...299).contains(statusCode) else {
                        let errorType: ErrorType

                        switch urlResponse?.getStatusCode() {
                        case 404:
                            errorType = .notFound
                        case 422:
                            errorType = .validationError
                        case 500:
                            errorType = .serverError
                        default:
                            errorType = .defaultError
                        }

                        completion(Result<T>.failure(error: errorType))
                        return
                    }

                    guard let data = data else {
                        completion(Result<T>.failure(error: ErrorType.defaultError))
                        return
                    }

                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(Result.success(data: result))
                    } catch let error {
                        completion(Result.failure(error: error))
                    }
                }
            }
            task.resume()

        } catch let error {
            completion(Result<T>.failure(error: error))
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
