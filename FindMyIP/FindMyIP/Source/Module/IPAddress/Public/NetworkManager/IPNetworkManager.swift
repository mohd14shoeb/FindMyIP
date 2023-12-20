//
//  IPNetworkManager.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation

open class IPNetworkManager: IPNetworkManagerDelegate {
    private let internalNetworkManager: IPNetworkManagerDelegate
    
  public   init(internalNetworkManager: IPNetworkManagerDelegate = InternalNetworkManager()) {
        self.internalNetworkManager = internalNetworkManager
    }
    open func fetchIPAddress<T: Decodable>(url: String, 
                                           responseModel: T.Type,
                                           completion: @escaping (Result<T, Error>) -> Void) {
        internalNetworkManager.fetchIPAddress(url: url, 
                                              responseModel: responseModel,
                                              completion: completion)
    }
}

