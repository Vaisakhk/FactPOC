//
//  HomeInteractor.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

class HomeInteractor: HomePresenterToInteractorProtocol {
    func getHomeDetails() {
        
    }
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var presenter: HomeInteractorToPresenterProtocol?
    
    //MARK:- Download Home Details
    func downloadHomeDetails() {
        if(!networkUnavalible() ){
            self.presenter?.HomeDownloadFailed(message: AlertConstants.networkErrorMessage)
            return
        }
        
        dataTask?.cancel()
        
        let url = URL(string: Constants.BASEURL + "s/2iodh4vg0eortkl/facts.json")
        dataTask =
            defaultSession.dataTask(with: url!) { [weak self] data, response, error1 in
                defer {
                    self?.dataTask = nil
                }
                if let _ = error1 {
                    DispatchQueue.main.async {
                        self?.presenter?.HomeDownloadFailed(message: AlertConstants.failureMessage)
                    }
                }else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let decoder = JSONDecoder.init()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                    guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                        self?.presenter?.HomeDownloadFailed(message: AlertConstants.unableToConvertData)//Since Api response is returing following error ---> Unable to convert data to string around character 2643." UserInfo={NSDebugDescription=Unable to convert data to string around character 2643
                        return
                    }
                    do {
                        let factList =  try decoder.decode(FactList.self, from: modifiedDataInUTF8Format)
                        self?.processResult(data: factList)
                        
                    } catch {
                        self?.presenter?.HomeDownloadFailed(message: AlertConstants.failureMessage)
                    }
                }
        }
        dataTask?.resume()
    }
    
   //MARK:- Process The result (Filtered response to avoid empty results)
   private func processResult(data:FactList) {
        let dataArray = data.rows?.filter({ (fact) -> Bool in
            var isValid = true
            if (fact.title == nil && fact.description == nil && fact.imageHref == nil) {
                isValid = false
            }else {
                if(fact.title?.count != 0 && fact.description?.count != 0 && fact.imageHref? .count != 0) {
                    isValid = true
                }else {
                    isValid = false
                }
            }
            return isValid
        });
        self.presenter?.HomeDownloadSuccess(result:dataArray ?? [], titleString: data.title ?? "")
    }
    
     //MARK:- Check Network Availability
    private func networkUnavalible() -> Bool{
        var isReachable:Bool = true;
        let reachability = Reachability ()
        if (reachability?.isReachable)! {
            if (reachability?.isReachableViaWiFi)! {
                isReachable = true;
            } else {
                isReachable = true;
            }
        } else {
            isReachable = false;
        }
        return isReachable;
    }
    
}
