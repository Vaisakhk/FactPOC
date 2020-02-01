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
        presenter?.HomeDownloadStarted()
        dataTask?.cancel()
        
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        dataTask =
            defaultSession.dataTask(with: url!) { [weak self] data, response, error1 in
                defer {
                    self?.dataTask = nil
                }
                if let error = error1 {
                    DispatchQueue.main.async {
                        self?.presenter?.HomeDownloadFailed(message: error.localizedDescription)
                    }
                }else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let decoder = JSONDecoder.init()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                    guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                        self?.presenter?.HomeDownloadFailed(message: "could not convert data to UTF-8 format")//Since Api response is returing following error ---> Unable to convert data to string around character 2643." UserInfo={NSDebugDescription=Unable to convert data to string around character 2643
                        return
                    }
                    do {
                        let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                        let factList =  try decoder.decode(FactList.self, from: modifiedDataInUTF8Format)
                        self?.presenter?.HomeDownloadSuccess(result:factList.rows ?? [], titleString: factList.title ?? "")
                        print(responseJSONDict)
                    } catch {
                        print(error)
                    }
                }
        }
        dataTask?.resume()
    }
    

}
