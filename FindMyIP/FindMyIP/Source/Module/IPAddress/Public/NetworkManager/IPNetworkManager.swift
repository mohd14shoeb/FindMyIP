//
//  IPNetworkManager.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation
import Alamofire
import Combine

// MARK: protocol NetworkManagerDelegate
public protocol IPNetworkManagerDelegate: AnyObject {
    func fetchIPAddress<T: Decodable>(url: String, 
                                      responseModel: T.Type) -> AnyPublisher<T, Error>
}

public class IPNetworkManager: IPNetworkManagerDelegate {
    public init() {}
    
    public func fetchIPAddress<T: Decodable>(url: String, responseModel: T.Type) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let decodedResponse):
                        promise(.success(decodedResponse))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
