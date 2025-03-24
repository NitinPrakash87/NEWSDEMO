//
//  MyNewspaperApplicationTests.swift
//  MyNewspaperApplicationTests
//
//  Created by Nitin Prakash on 24/03/25.
//

import XCTest
@testable import MyNewspaperApplication

final class MyNewspaperApplicationTests: XCTestCase {
    let testViewModel = ArticleDetailsViewModel(apiManager: MockArticleDetailsApiManager())
    let testBundle = Bundle(for: MyNewspaperApplicationTests.self)

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNumberOfLikes() {
        let expectation = expectation(description: "Waiting for API call to complete")
        testViewModel.getNumberOfLikesAndComments {
            expectation.fulfill()
        }
        
        let likesString = "12 Likes"
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(likesString, self.testViewModel.numberOfLikes())

    }
    
    func testNumberOfComments() {
        let expectation = expectation(description: "Waiting for API call to complete")
        testViewModel.getNumberOfLikesAndComments {
            expectation.fulfill()
        }
        
        let likesString = "88 Comments"
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(likesString, self.testViewModel.numberOfComments())
    }

}
