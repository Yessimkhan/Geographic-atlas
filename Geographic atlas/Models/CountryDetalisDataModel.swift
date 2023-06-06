//
//  CountryDetalisDataModel.swift
//  Geographic atlas
//
//  Created by Yessimkhan Zhumash on 17.05.2023.
//

import Foundation

// MARK: - CountryDetail
struct CountryDetail: Decodable {
    var name: Name
    var currencies: [String: Currency]?
    var capital: [String]
    var subregion: String
    var area: Double
    var population: Int
    var timezones: [String]
    var flags: Flags?
    var capitalInfo: CapitalInfo
}

// MARK: - CapitalInfo
struct CapitalInfo: Decodable {
    var latlng: [Double]
}

typealias CountryDetails = [CountryDetail]
