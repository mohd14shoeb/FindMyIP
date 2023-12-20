//
//  FindMyIPTests.swift
//  FindMyIPTests
//
//  Created by Shoeb Khan on 19/12/23.
//

import XCTest
@testable import FindMyIP

final class FindMyIPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    func testFetchIPAddressSuccess() {
        let expectedResult = "2402:e280:3d6e:1697:303b:210f:548c:13f4"
       // let mockData = getmockData()
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
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
