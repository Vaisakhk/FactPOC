//
//  HomeRouter.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    //MARK:- Create Home Module
    static func createModule() -> UINavigationController {
        let view = ViewController()//mainstoryboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router:HomePresenterToRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view as HomePresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return UINavigationController(rootViewController: view)
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
