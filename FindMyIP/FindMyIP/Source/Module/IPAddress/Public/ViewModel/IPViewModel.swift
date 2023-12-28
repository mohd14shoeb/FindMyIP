//
//  IPViewModel.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import Foundation
import Alamofire
import Combine

public class IPViewModel: ObservableObject {
    // MARK: Published Property
    @Published public var ipAddress: String = ""
    @Published public var isLoading: Bool = true
    @Published public var errorMessage: String = ""
    public var cancellables = Set<AnyCancellable>()
    private var networkManager: IPNetworkManagerDelegate
    
    // MARK: Initilize Property
    public init(networkManager: IPNetworkManagerDelegate = IPNetworkManager()) {
        self.networkManager = networkManager
    }
    
    public func fetchIPAddress() {
        self.errorMessage = ""
        self.networkManager.fetchIPAddress(url: "https://ipapi.co/json/",
                                           responseModel: IPAddressResponse.self)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = ErrorHandlingUtils.parseURLError(error as? AFError)
            }
        }, receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.ipAddress = response.ipAddressValue
        })
        .store(in: &cancellables)
    }
    
    
    
    // MARK: fetch  IPAddress with User defined Model and URL
    public func fetchDynamicResponseModel<T: Decodable>(url: String,
                                                        responseModel: T.Type) -> AnyPublisher<T, Error>  {
        return networkManager.fetchIPAddress(url: url,
                                             responseModel: responseModel)
    }
}

