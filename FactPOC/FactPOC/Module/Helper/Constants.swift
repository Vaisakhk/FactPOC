//
//  Constants.swift
//  FactPOC
//
//  Created by User on 2/2/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit

struct Constants {
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    static let BASEURL =  "https://dl.dropboxusercontent.com/"
}

struct AlertConstants {
    static let noDataMessage = "No Data found."
    static let networkErrorMessage = "No internet Access"
    static let unableToConvertData = "could not convert data to UTF-8 format"
    static let failureMessage = "Something unexpected happened. Please try again later."
}

struct UserDefaultConstants {
    static let ImageBaseURL = "ImageBaseURL"
}
