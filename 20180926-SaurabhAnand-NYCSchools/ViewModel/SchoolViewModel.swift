//
//  SchoolViewModel.swift
//  20180926-SaurabhAnand-NYCSchools
//
//  Created by Saurabh Anand on 9/26/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import Foundation
import UIKit

class SchoolViewModel {
        
    var schoolDetailList = [SchoolDetailModel]()
        
    // MARK: - School List Api call
    /// Calls the Network Manager api to call web service and resturns the response
    ///
    /// - parameter completionHandler:  call back to view controller.
    ///
    /// - returns: The success and error message in completionHandler
    
    func fetchSchoolList(completionHandler:@escaping (Bool, String?) -> Void) {
        
        let url = NetworkManager.SharedInstance.kBaseURL + "97mf-9njv.json"
        
        NetworkManager.SharedInstance.fetchData(url: url, parameters: nil) { (responseJson, errorMsg) in
            
            var error = ""
            var success = true
            if let errorString = errorMsg {
                
                success = false
                error = errorString
            } else {
                
                if let result = responseJson {
                    self.schoolDetailList = self.populateSchoolDetailList(schoolDetails:result)
                } else {
                    success = false
                    error = "Issue with School List Service"
                }
            }
            completionHandler(success, error)
        }
    }
    
    // MARK: - School List Population
    /// Populates the school data to the array schoolDetailList
    ///
    /// - parameter schoolDetailList: list of school details
    ///
    
    func populateSchoolDetailList (schoolDetails : [[String:Any]]) -> [SchoolDetailModel] {
        
        var schoolArray = [SchoolDetailModel]()
        
        for item in schoolDetails{
            let schoolDetail = SchoolDetailModel()
            
            if let dbn = item["dbn"]  as? String {
                schoolDetail.dbn = dbn
            }
            
            if let schoolName = item["school_name"]  as? String {
                schoolDetail.schoolName = schoolName
            }
            
            if let schoolEmail = item["school_email"]  as? String {
                schoolDetail.schoolEmail = schoolEmail
            }
            
            if let addressLine1 = item["primary_address_line_1"]  as? String {
                schoolDetail.addressLine1 = addressLine1
            }
            
            if let city = item["city"]  as? String {
                schoolDetail.city = city
            }
            
            if let phoneNumber = item["phone_number"]  as? String {
                schoolDetail.phoneNumber = phoneNumber
            }
            
            if let totalStudents = item["total_students"]  as? Int {
                schoolDetail.totalStudents = totalStudents
            }
            schoolArray.append(schoolDetail)
        }
        
        return schoolArray
    }
    
    // MARK: - Alert handler
    /// Handles the alert, if any service error or no results
    ///
    /// - parameter errorMsg:       Error Message string
    ///
    
    func showAlert(errorMsg: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        return alert
    }
}
