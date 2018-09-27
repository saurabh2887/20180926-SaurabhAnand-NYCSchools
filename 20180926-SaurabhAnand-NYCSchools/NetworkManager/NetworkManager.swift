//
//  NetworkManager.swift
//  20180926-SaurabhAnand-NYCSchools
//
//  Created by Saurabh Anand on 9/26/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Properties
    /// Generated X-App token
    let httpHeaders : [String:String] = ["Content-Type" : "application/json",
                                         "Accept": "application/json",
                                         "X-App-Token":"ew4jYOqZ5nmprLC50rDlPYkGu"]
    
    // MARK: - Singleton
    /// Creates a Single ton class for network manager
    ///
    ///returns Single ton class of NetworkManager sharedInstance

    static let SharedInstance: NetworkManager = {
        let manager = NetworkManager()
        return manager
    }()
    
    // Should prevent it to create another instance
    private init() {}
    
    // base URL
    let kBaseURL = "https://data.cityofnewyork.us/resource/"

    
    // MARK: - Web Service Api Call
    /// Calls the service using ALamofire framework for web service api and returns the json response
    /// `method`, `parameters`, `encoding` and `headers`.
    ///
    /// - parameter url:                The URL.
    /// - parameter parameters:         The parameters. `nil` by default.
    /// - parameter completionHandler:  call back to viewModel.
    ///
    /// - returns: The responseJson and error message in completionHandler
    
    func fetchData(url: String, parameters:[String:Any]?, completionHandler:@escaping ([[String:Any]]?, String?) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if let result = response.result.value {
                if let reposneJson = result as? [[String:Any]] {
                    completionHandler(reposneJson,nil)
                } else {
                    completionHandler(nil,"Error in response.")
                }
            } else {
                completionHandler(nil,response.error?.localizedDescription)
            }
        }
    }
}
