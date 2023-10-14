//
//  MovieListModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

// MARK: - MovieListModel
struct MovieListModel: Codable,Hashable {
    let movies: [Movie]?
}

// MARK: - Movie
struct Movie: Codable,Hashable {
    init(id: Int?, movieCode: [String]?, titleEn: String?, titleTh: String?, rating: String?, ratingID: Int?, duration: Int?, releaseDate: String?, sneakDate: String?, synopsisTh: String?, synopsisEn: String?, director: String?, actor: String?, genre: String?, posterOri: String?, posterURL: String?, trailer: String?, trIos: String?, trHD: String?, trSD: String?, trMp4: String?, priority: String?, nowShowing: String?, advanceTicket: String?, dateUpdate: String?, showBuyticket: String?, trailerCMSID: String?, trailerIvxKey: String?) {
        self.id = id
        self.movieCode = movieCode
        self.titleEn = titleEn
        self.titleTh = titleTh
        self.rating = rating
        self.ratingID = ratingID
        self.duration = duration
        self.releaseDate = releaseDate
        self.sneakDate = sneakDate
        self.synopsisTh = synopsisTh
        self.synopsisEn = synopsisEn
        self.director = director
        self.actor = actor
        self.genre = genre
        self.posterOri = posterOri
        self.posterURL = posterURL
        self.trailer = trailer
        self.trIos = trIos
        self.trHD = trHD
        self.trSD = trSD
        self.trMp4 = trMp4
        self.priority = priority
        self.nowShowing = nowShowing
        self.advanceTicket = advanceTicket
        self.dateUpdate = dateUpdate
        self.showBuyticket = showBuyticket
        self.trailerCMSID = trailerCMSID
        self.trailerIvxKey = trailerIvxKey
    }

    let uuid: UUID = UUID()
    let id: Int?
    let movieCode: [String]?
    let titleEn, titleTh: String?
    let rating: String?
    let ratingID, duration: Int?
    let releaseDate, sneakDate, synopsisTh, synopsisEn: String?
    let director, actor, genre, posterOri: String?
    let posterURL: String?
    let trailer: String?
    let trIos: String?
    let trHD, trSD: String?
    let trMp4: String?
    let priority, nowShowing, advanceTicket, dateUpdate: String?
    let showBuyticket, trailerCMSID: String?
    let trailerIvxKey: String?

    enum CodingKeys: String, CodingKey {
        case id, movieCode
        case titleEn = "title_en"
        case titleTh = "title_th"
        case rating
        case ratingID = "rating_id"
        case duration
        case releaseDate = "release_date"
        case sneakDate = "sneak_date"
        case synopsisTh = "synopsis_th"
        case synopsisEn = "synopsis_en"
        case director, actor, genre
        case posterOri = "poster_ori"
        case posterURL = "poster_url"
        case trailer
        case trIos = "tr_ios"
        case trHD = "tr_hd"
        case trSD = "tr_sd"
        case trMp4 = "tr_mp4"
        case priority
        case nowShowing = "now_showing"
        case advanceTicket = "advance_ticket"
        case dateUpdate = "date_update"
        case showBuyticket = "show_buyticket"
        case trailerCMSID = "trailer_cms_id"
        case trailerIvxKey = "trailer_ivx_key"
    }
}

extension Movie {
    static var placeholderError: Movie {
        return Movie(id: nil, movieCode: nil, titleEn: nil, titleTh: nil, rating: nil, ratingID: nil, duration: nil, releaseDate: nil, sneakDate: nil, synopsisTh: nil, synopsisEn: nil, director: nil, actor: nil, genre: nil, posterOri: nil, posterURL: nil, trailer: nil, trIos: nil, trHD: nil, trSD: nil, trMp4: nil, priority: nil, nowShowing: nil, advanceTicket: nil, dateUpdate: nil, showBuyticket: nil, trailerCMSID: nil, trailerIvxKey: nil)
    }
}
