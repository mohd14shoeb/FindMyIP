//
//  IPViewModel.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation

open class IPViewModel: ObservableObject {
    // MARK: Published Property
    @Published var ipAddress: String = ""
    @Published var isLoading: Bool = true
    @Published var errorMessage: String = ""
    private var networkManager: IPNetworkManagerDelegate
    
    // MARK: Initilize Property
   public  init(networkManager: IPNetworkManagerDelegate = IPNetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: fetch  IPAddress with hard coded Model and URL
    public func fetchIPAddress() {
        self.errorMessage = ""
        self.fetchDynamicResponseModel(url: "https://ipapi.co/json/", 
                                       responseModel: IPAddressResponse.self) { result in
            switch result {
            case .success(let response):
                self.isLoading = false
                self.ipAddress = response.ipAddressValue
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    // MARK: fetch  IPAddress with User defined Model and URL
    public  func fetchDynamicResponseModel<T: Decodable>(url: String, 
                                                         responseModel:T.Type,
                                                         completionHandler: @escaping (Result<T, Error>) -> Void) {
        networkManager.fetchIPAddress(url: url, 
                                      responseModel: responseModel) { result in
            completionHandler(result)
        }
    }
    
}
