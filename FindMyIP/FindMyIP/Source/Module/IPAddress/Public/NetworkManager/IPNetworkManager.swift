//
//  IPNetworkManager.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation
import Alamofire

// MARK: protocol NetworkManagerDelegate
public protocol IPNetworkManagerDelegate: AnyObject {
    func fetchIPAddress<T: Decodable>(url: String,
                                      responseModel: T.Type,
                                      completion: @escaping (Result<T, Error>) -> Void)
}

public class IPNetworkManager: IPNetworkManagerDelegate {
    public  init(){}
     public func fetchIPAddress<T: Decodable>(url: String,
                                        responseModel: T.Type,
                                        completion: @escaping (Result<T, Error>) -> Void) {
         AF.request(url)
             .validate()
             .responseDecodable(of: T.self) { response in
                 switch response.result {
                 case .success(let decodedResponse):
                     completion(.success(decodedResponse))
                 case .failure(let error):
                     completion(.failure(error))
                 }
             }
     }
 }

