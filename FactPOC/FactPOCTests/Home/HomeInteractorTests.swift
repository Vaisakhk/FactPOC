//
//  HomeInteractorTests.swift
//  FactPOCTests
//
//  Created by User on 2/4/20.
//  Copyright © 2020 VK. All rights reserved.
//

import XCTest
@testable import FactPOC
class HomeInteractorTests: XCTestCase {
    class FakeHomeInteractionToPresenter: HomeInteractorToPresenterProtocol {
        func HomeDownloadSuccess(result: [Fact], titleString: String) {
            XCTAssertNotNil(result)
            XCTAssertNotNil(titleString)
        }
        
        func HomeDownloadFailed(message: String) {
            XCTAssertNotNil(message)
        }
    }
    
    var presenter:HomeInteractorToPresenterProtocol?
    var interactor:HomeInteractor?
    
    override func setUp() {
        presenter = FakeHomeInteractionToPresenter()
        interactor = HomeInteractor()
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
    }
    
    //MARK:- Test recent Movie Data
    func testGetRecentMovieData () {
        interactor?.downloadHomeDetails()
    }
    
}
