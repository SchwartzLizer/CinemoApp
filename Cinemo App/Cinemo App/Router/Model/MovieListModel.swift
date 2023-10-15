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

    init(movies: [Movie]?) {
        self.movies = movies
    }
}

// MARK: - Movie

struct Movie: Codable,Hashable {

    // MARK: Lifecycle

    init(
        id: Int?,
        movieCode: [String]?,
        titleEn: String?,
        titleTh: String?,
        rating: String?,
        ratingID: Int?,
        duration: Int?,
        releaseDate: String?,
        sneakDate: String?,
        synopsisTh: String?,
        synopsisEn: String?,
        director: String?,
        actor: String?,
        genre: String?,
        posterOri: String?,
        posterURL: String?,
        trailer: String?,
        trIos: String?,
        trHD: String?,
        trSD: String?,
        trMp4: String?,
        priority: String?,
        nowShowing: String?,
        advanceTicket: String?,
        dateUpdate: String?,
        showBuyticket: String?,
        trailerCMSID: String?,
        trailerIvxKey: String?)
    {
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

    // MARK: Internal

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

    let uuid = UUID()
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

}

extension Movie {
    static var placeholderError: Movie {
        return Movie(
            id: nil,
            movieCode: nil,
            titleEn: nil,
            titleTh: nil,
            rating: nil,
            ratingID: nil,
            duration: nil,
            releaseDate: nil,
            sneakDate: nil,
            synopsisTh: nil,
            synopsisEn: nil,
            director: nil,
            actor: nil,
            genre: nil,
            posterOri: nil,
            posterURL: nil,
            trailer: nil,
            trIos: nil,
            trHD: nil,
            trSD: nil,
            trMp4: nil,
            priority: nil,
            nowShowing: nil,
            advanceTicket: nil,
            dateUpdate: nil,
            showBuyticket: nil,
            trailerCMSID: nil,
            trailerIvxKey: nil)
    }
}

extension Movie {
    static var mockUp1: Movie {
        return Movie(
            id: 2095,
            movieCode: ["HO00004673"],
            titleEn: "TAYLOR SWIFT THE ERAS TOUR",
            titleTh: "TAYLOR SWIFT THE ERAS TOUR",
            rating: "ทป.",
            ratingID: 0,
            duration: 168,
            releaseDate: "2023-10-13",
            sneakDate: "2023-09-26",
            synopsisTh: "ปรากฏการณ์แห่งวัฒนธรรมเพลงครั้งสำคัญ วันนี้พร้อมแล้วที่จะเดินทางมาให้คุณรับชมบนหน้าจอขนาดใหญ่! ประสบการณ์ครั้งหนึ่งในชีวิตที่พลาดไม่ได้ ...",
            synopsisEn: "Experience the breathtaking Eras Tour concert, performed by the one and only Taylor Swift.",
            director: "Sam Wrench",
            actor: "Taylor Swift",
            genre: "Musical",
            posterOri: "/uploads/movie/3966/thumb_3966.jpg",
            posterURL: "https://cdn.majorcineplex.com/uploads/movie/3966/thumb_3966.jpg?v=202310131714",
            trailer: "https://cdn.majorcineplex.com/embed/7878",
            trIos: "http://27.254.80.209:1935/media/_definst_/mp4:major/trailer/7878/7878_720.mp4/playlist.m3u8",
            trHD: "rtsp://27.254.80.209:1935/media/_definst_/mp4:major/trailer/7878/7878_720.mp4",
            trSD: "rtsp://27.254.80.209:1935/media/_definst_/mp4:major/trailer/7878/7878_360.mp4",
            trMp4: "https://cdn.majorcineplex.com/uploads/trailer/rawvideo/7878/7878.mp4",
            priority: "79999",
            nowShowing: "1",
            advanceTicket: "0",
            dateUpdate: "2023-10-12 18:00:22",
            showBuyticket: "1",
            trailerCMSID: "7878",
            trailerIvxKey: "2820123")
    }

    static var mockUp2: Movie {
        return Movie(
            id: 3852,
            movieCode: nil,
            titleEn: "The Pattaya Heat",
            titleTh: "ปิดเมืองล่า",
            rating: "",
            ratingID: 0,
            duration: 117,
            releaseDate: "2024-02-08 00:00:00",
            sneakDate: "2023-05-29",
            synopsisTh: "ยังไม่มีการเปิดเผยเนื้อหาของภาพยนตร์เรื่องนี้\r\n",
            synopsisEn: "Plot under wraps.\r\n",
            director: "Yang Shu Peng",
            actor: "Ananda Everingham/Chermarn Boonyasak/Jirayu Tantrakul/Krissada Sukosol Clapp",
            genre: "Action",
            posterOri: "/uploads/movie/3852/thumb_3852.jpg",
            posterURL: "https://cdn.majorcineplex.com/uploads/movie/3852/thumb_3852.jpg?v=202310131714",
            trailer: "https://www-cms.majorcineplex.com/embed/7650",
            trIos: "https://cdn.majorcineplex.com/uploads/trailer/rawvideo/7650/7650.mp4",
            trHD: "https://cdn.majorcineplex.com/uploads/trailer/rawvideo/7650/7650.mp4",
            trSD: "https://cdn.majorcineplex.com/uploads/trailer/rawvideo/7650/7650.mp4",
            trMp4: "https://cdn.majorcineplex.com/uploads/trailer/rawvideo/7650/7650.mp4",
            priority: nil,
            nowShowing: nil,
            advanceTicket: nil,
            dateUpdate: "2023-10-03 14:18:57",
            showBuyticket: nil,
            trailerCMSID: "7650",
            trailerIvxKey: "2695088")
    }

}
