//
//  HomePresenterTest.swift
//  FactPOCTests
//
//  Created by User on 2/4/20.
//  Copyright © 2020 VK. All rights reserved.
//

import XCTest
@testable import FactPOC
class HomePresenterTest: XCTestCase {
    class FakeInteractor:HomePresenterToInteractorProtocol {
        var presenter: HomeInteractorToPresenterProtocol?
        func downloadHomeDetails() {
            presenter?.HomeDownloadSuccess(result: [], titleString: "")
        }
    }
    
    class FakeRouter : HomePresenterToRouterProtocol {
        static func createModule() -> UINavigationController {
            return UINavigationController()
        }
    }
    
    class FakeView :HomePresenterToViewProtocol {
        func HomeFetchSuccess(result: [Fact], factTitle: String) {
            XCTAssertNotNil(result)
            XCTAssertNotNil(factTitle)
        }
        
        func HomeFetchFailed(message: String) {
            XCTAssertNotNil(message)
        }
        
    }
    
    var homePresenter: HomePresenter!
    //MARK:- Test Create Detail Module
    override func setUp() {
        homePresenter = HomePresenter()
        homePresenter.interactor = FakeInteractor()
        homePresenter.view = FakeView()
        homePresenter.router = FakeRouter()
    }
    
    override func tearDown() {
        
    }
    
    func testStartDownloadHomeDetails() {
        homePresenter.startDownloadHomeDetails()
    }
}
