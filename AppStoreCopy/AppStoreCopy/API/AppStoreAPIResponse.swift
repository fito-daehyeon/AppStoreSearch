//
//  AppStoreAPIResponse.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import Foundation

struct ResponseBase<T: Codable>: Codable {
    let resultCount: Int
    let results: T?
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.resultCount = try values.decode(Int.self, forKey: .resultCount)
        self.results = try values.decode(T.self, forKey: .results)
    }
}



struct AppDataInfo: Codable,Identifiable{
    var id = UUID()
    let screenshotUrls, ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let artworkUrl60, artworkUrl512: String?
    let artworkUrl100, artistViewURL: String?
    let supportedDevices: [String]?
    let advisories: [String]?
    let isGameCenterEnabled: Bool?
    let kind: String?
    let features: [String]?
    let trackCensoredName: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes, sellerURL, contentAdvisoryRating: String?
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    let averageUserRating: Double?
    let trackViewURL, trackContentRating: String?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let minimumOSVersion: String?
    let trackID: Int?
    let trackName, releaseDate, primaryGenreName: String?
    let genreIDS: [String]?
    let formattedPrice, currentVersionReleaseDate: String?
    let releaseNotes: String?
    let primaryGenreID: Int?
    let sellerName, currency, wrapperType: String?
    let version: String? //this is what we need
    let artistID: Int?
    let artistName: String?
    let genres: [String]?
    let price: Double?
    let description, bundleID: String?
    let userRatingCount: Int?
    enum CodingKeys: String, CodingKey {
        case screenshotUrls, ipadScreenshotUrls
        case appletvScreenshotUrls, artworkUrl60
        case artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case supportedDevices, advisories
        case isGameCenterEnabled, kind
        case features, trackCensoredName
        case languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case contentAdvisoryRating
        case averageUserRatingForCurrentVersion
        case userRatingCountForCurrentVersion
        case averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating
        case isVppDeviceBasedLicensingEnabled
        case minimumOSVersion = "minimumOsVersion"
        case trackID = "trackId"
        case trackName, releaseDate, primaryGenreName
        case genreIDS = "genreIds"
        case formattedPrice, currentVersionReleaseDate
        case releaseNotes
        case primaryGenreID = "primaryGenreId"
        case sellerName, currency, version, wrapperType
        case artistID = "artistId"
        case artistName, genres, price, description
        case bundleID = "bundleId"
        case userRatingCount
    }
    
   
}
