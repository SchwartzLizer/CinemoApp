//
//  RouterEnumeration.swift
//  Template Project
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

enum ErrorType: LocalizedError {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError

    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        }
    }
}

enum Result<T> {
    case success(data: T)
    case failure(error: Error)
}

