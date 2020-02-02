//
//  HomeProtocol.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

protocol HomeViewToPresenterProtocol: class{
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func startDownloadHomeDetails()
}

protocol HomePresenterToViewProtocol: class{
    func HomeFetchSuccess(result:[Fact],factTitle:String)
    func HomeFetchFailed(message:String)
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule()-> UINavigationController
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func downloadHomeDetails()
}

protocol HomeInteractorToPresenterProtocol: class {
    func HomeDownloadSuccess(result:[Fact],titleString:String)
    func HomeDownloadFailed(message:String)

}
