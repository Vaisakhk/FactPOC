//
//  HomePresenter.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
      func startDownloadHomeDetails() {
        interactor?.downloadHomeDetails()
    }
    
    func getSavedHomeDetails() {
        interactor?.getHomeDetails()
    }
}

//MARK:- Home Interactor To Presenter Protocol
extension HomePresenter : HomeInteractorToPresenterProtocol {
    func HomeDownloadStarted() {
        
    }
    
    func HomeDownloadSuccess(result: [Fact]) {
        DispatchQueue.main.async {[weak self] in
        self?.view?.HomeFetchSuccess(result: result)
        }
    }
    func HomeDownloadFailed(message: String) {
        DispatchQueue.main.async {[weak self] in
        self?.view?.HomeFetchFailed(message: message)
        }
    }
}
