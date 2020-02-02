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
}

//MARK:- Home Interactor To Presenter Protocol
extension HomePresenter : HomeInteractorToPresenterProtocol {

    func HomeDownloadSuccess(result: [Fact],titleString: String) {
        DispatchQueue.main.async {[weak self] in
            self?.view?.HomeFetchSuccess(result: result, factTitle: titleString)
        }
    }
    func HomeDownloadFailed(message: String) {
        DispatchQueue.main.async {[weak self] in
            self?.view?.HomeFetchFailed(message: message)
        }
    }
}
