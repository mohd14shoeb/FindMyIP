//
//  IPNetworkManager.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation


public class IPNetworkManager {
    private let internalNetworkManager = InternalNetworkManager()
    public init() {}
    public func fetchIPAddress<T: Decodable>(url: String, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        internalNetworkManager.fetchIPAddress(url: url, responseModel: responseModel, completion: completion)
    }
}

