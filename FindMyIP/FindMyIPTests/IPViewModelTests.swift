//
//  IPViewModelTests.swift
//  FindMyIPTests
//
//  Created by Shoeb Khan on 21/12/23.
//

import XCTest
@testable import FindMyIP

final class IPViewModelTests: XCTestCase {
    private var viewModel: IPViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
    }
    
    func testFetchIPAddressSuccess() {
        let expectedResult = "2402:e280:3d6e:1697:303b:210f:548c:13f4"
        
        self.viewModel = IPViewModel(networkManager:
                                        MockIPNetworkManager(failureCase: false))
        let expectation = self.expectation(description: "Fetch IP Address")
        self.viewModel?.fetchIPAddress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel?.ipAddress, expectedResult)
            XCTAssertEqual(self.viewModel?.isLoading, false)
            XCTAssertEqual(self.viewModel?.errorMessage, "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchIPAddressFailure() {
        let expectedResult = ""
        self.viewModel = IPViewModel(networkManager:
                                        MockIPNetworkManager(failureCase: true))
        let expectation = self.expectation(description: "Fetch IP Address Failure")
        self.viewModel?.fetchIPAddress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            XCTAssertEqual(self.viewModel?.ipAddress, expectedResult)
            XCTAssertEqual(self.viewModel?.isLoading, true)
            XCTAssertNotNil(self.viewModel?.errorMessage)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    
    func testFetchDynamicResponseModelSuccess() {
        let expectedResult = "2402:e280:3d6e:1697:303b:210f:548c:13f4"
        let expectation = self.expectation(description: "Fetch IP Address")
        
        let mockNetworkManager = MockIPNetworkManager(failureCase: false)
        self.viewModel = IPViewModel(networkManager: mockNetworkManager)
        
        let cancellable = self.viewModel?.fetchDynamicResponseModel(url: "https://ipapi.co/json/",
                                                                    responseModel: IPAddressResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error occurred: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                XCTAssertEqual(response.ipAddress, expectedResult)
            })
        wait(for: [expectation], timeout: 5.0)
        cancellable?.cancel()
    }
    
    func testfetchDynamicResponseModelFailure() {
        let expectedResult = ""
        self.viewModel = IPViewModel(networkManager:
                                        MockIPNetworkManager(failureCase: true))
        let expectation = self.expectation(description: "Fetch IP Address Failure")
        let cancellable = self.viewModel?.fetchDynamicResponseModel(url: "https://ipapi.co/json/",
                                                               responseModel: IPAddressResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(self.viewModel?.ipAddress, expectedResult)
                    XCTAssertEqual(self.viewModel?.isLoading, true)
                    XCTAssertNotNil(error.localizedDescription)
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Should not receive a value on failure.")
            })
        wait(for: [expectation], timeout: 5.0)
        cancellable?.cancel()
    }
    
    
}

