//
//  IPAddressResponse.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation


struct IPAddressResponse: Codable {
    let ipAddress, network, version, city: String?
    let region, regionCode, country, countryName: String?
    let countryCode, countryCodeIso3, countryCapital, countryTLD: String?
    let continentCode: String?
    let inEu: Bool?
    let postal: String?
    let latitude, longitude: Double?
    let timezone, utcOffset, countryCallingCode, currency: String?
    let currencyName, languages: String?
    let countryArea, countryPopulation: Int?
    let asn, org: String?

    var ipAddressValue: String {
        guard let ip = self.ipAddress else { return "" }
        return ip
    }
    
    enum CodingKeys: String, CodingKey {
        case network, version, city, region
        case ipAddress = "ip"
        case regionCode = "region_code"
        case country
        case countryName = "country_name"
        case countryCode = "country_code"
        case countryCodeIso3 = "country_code_iso3"
        case countryCapital = "country_capital"
        case countryTLD = "country_tld"
        case continentCode = "continent_code"
        case inEu = "in_eu"
        case postal, latitude, longitude, timezone
        case utcOffset = "utc_offset"
        case countryCallingCode = "country_calling_code"
        case currency
        case currencyName = "currency_name"
        case languages
        case countryArea = "country_area"
        case countryPopulation = "country_population"
        case asn, org
    }
}
