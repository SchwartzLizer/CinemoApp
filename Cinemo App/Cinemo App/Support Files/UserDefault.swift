//
//  UserDefault.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

let defaults = UserDefaults.standard


// MARK: - UserDefault

class UserDefault {

    func getFavorite() -> [Movie] {
        do {
            let list = try defaults.getObject(forKey: Constants.UserDefaultKey.favouriteKey, castTo: [Movie].self)
            return list
        }
        catch {
            print(error.localizedDescription)
            return []
        }
    }

    func addFavorite(data: Movie) {
        var dataFavorite = self.getFavorite()
        dataFavorite.insert(data, at: 0)
        do {
            try defaults.setObject(dataFavorite, forKey: Constants.UserDefaultKey.favouriteKey)
        }
        catch {
            print(error.localizedDescription)
        }
    }

    func removeFavorite(data: Movie) {
        var dataFavorite = self.getFavorite()
        dataFavorite.removeAll { movie in
            movie.id == data.id
        }
        do {
            try defaults.setObject(dataFavorite, forKey: Constants.UserDefaultKey.favouriteKey)
        }
        catch {
            print(error.localizedDescription)
        }
    }

}

extension Constants {
    enum UserDefaultKey {
        static let favouriteKey = "favouriteKey"
    }
}

// MARK: - ObjectSavable

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}


// MARK: - UserDefaults + ObjectSavable

extension UserDefaults: ObjectSavable {
    func setObject(_ object: some Encodable, forKey: String) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        }
        catch {
            throw ObjectSavableError.unableToEncode
        }
    }

    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        }
        catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

// MARK: - ObjectSavableError

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"

    var errorDescription: String? {
        rawValue
    }
}
