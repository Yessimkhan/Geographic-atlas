import Foundation

// MARK: - CountryElement
struct CountryElement: Decodable {
    var name: Name
    var capital: [String]?
    var flags: Flags?
    var continents: [String]
    var isExpanded: Bool?
    var population: Int
    var currencies: [String: Currency]?
    var area: Double
    var cca2: String
}

// MARK: - Name
struct Name: Decodable {
    var common, official: String
}

// MARK: - Flags
struct Flags: Decodable {
    var png: String
}

// MARK: - Currencies
struct Currency: Codable {
    var name: String?
    var symbol: String?
}

typealias Country = [CountryElement]
