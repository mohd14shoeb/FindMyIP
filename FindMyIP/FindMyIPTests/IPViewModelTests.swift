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
    
   
    
}
