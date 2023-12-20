//
//  MockIPNetworkManager.swift
//  FindMyIPTests
//
//  Created by Shoeb Khan on 21/12/23.
//

import Foundation
@testable import FindMyIP

class MockIPNetworkManager: IPNetworkManagerDelegate {
    
    let failureCase: Bool
    init(failureCase: Bool = false) {
        self.failureCase = failureCase
    }
    func fetchIPAddress<T: Decodable>(url: String, 
                                      responseModel: T.Type,
                                      completion: @escaping (Result<T, Error>) -> Void) {
       if failureCase {
           completion(.failure(NSError(domain: "MockErrorDomain", 
                                       code: 500, userInfo: nil)))
       } else {
           if let response = self.getmockData() as? T {
               completion(.success(response))
           } else {
               let error = NSError(domain: "Domain",
                                   code: 0,
                                   userInfo: [NSLocalizedDescriptionKey: "Failed to cast mock data"])
               completion(.failure(error))
           }
       }
        
    }

    func getmockData() -> IPAddressResponse? {
        let mockData = IPAddressResponse(
            ipAddress: "2402:e280:3d6e:1697:303b:210f:548c:13f4",
            network: "2402:e280:3d40::/42",
            version: "IPv6",
            city: "Mumbai",
            region: "Maharashtra",
            regionCode: "MH",
            country: "IN",
            countryName: "India",
            countryCode: "IN",
            countryCodeIso3: "IND",
            countryCapital: "New Delhi",
            countryTLD: ".in",
            continentCode: "AS",
            inEu: false,
            postal: "400070",
            latitude: 19.0748,
            longitude: 72.8856,
            timezone: "Asia/Kolkata",
            utcOffset: "+0530",
            countryCallingCode: "+91",
            currency: "INR",
            currencyName: "Rupee",
            languages: "en-IN,hi,bn,te,mr,ta,ur,gu,kn,ml,or,pa,as,bh,sat,ks,ne,sd,kok,doi,mni,sit,sa,fr,lus,inc",
            countryArea: 3287590,
            countryPopulation: 1352617328,
            asn: "AS134674",
            org: "TATA PLAY BROADBAND PRIVATE LIMITED"
        )
        return mockData
    }

}
