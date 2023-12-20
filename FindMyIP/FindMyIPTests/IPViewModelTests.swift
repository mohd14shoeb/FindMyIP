//
//  IPViewModelTests.swift
//  FindMyIPTests
//
//  Created by Shoeb Khan on 21/12/23.
//

import XCTest
@testable import FindMyIP

final class IPViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchIPAddressFailure() {
        let expectedResult = "Error"
        let viewModel = IPViewModel(networkManager:
                                        MockIPNetworkManager(failureCase: true))
        let expectation = self.expectation(description: "Fetch IP Address Failure")
        viewModel.fetchIPAddress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
    
            XCTAssertEqual(viewModel.ipAddress, "")
            XCTAssertEqual(viewModel.isLoading, true)
            XCTAssertNotNil(viewModel.errorMessage)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchIPAddressSuccess() {
        let expectedResult = "2402:e280:3d6e:1697:303b:210f:548c:13f4"
        
        let viewModel = IPViewModel(networkManager:
                                        MockIPNetworkManager(failureCase: false))
        let expectation = self.expectation(description: "Fetch IP Address")
        viewModel.fetchIPAddress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.ipAddress, expectedResult)
            XCTAssertEqual(viewModel.isLoading, false)
            XCTAssertEqual(viewModel.errorMessage, "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
}
