//
//  SATScoreViewModel.swift
//  20180926-SaurabhAnand-NYCSchools
//
//  Created by Saurabh Anand on 9/27/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import Foundation
import UIKit

class SATScoreViewModel {
    
    var schoolSATScoreDetails : SATScoreModel?
    
    // MARK: - School SAT Score Api call
    /// Calls the Network Manager api to call web service and resturns the response
    /// This service will .
    /// Since SAT score doesn't change, it shold be called and mapped with dbn (unique id) of each school
    ///
    /// - parameter completionHandler:  call back to view controller.
    /// - parameter dbn:                to be passed to filter SAT Cores for particular school.
    ///
    /// - returns: The success and error message in completionHandler
    
    func fetchSchoolSATScore(dbn:String, completionHandler:@escaping (Bool, String?) -> Void) {
        
        let url = NetworkManager.SharedInstance.kBaseURL + "734v-jeq5.json?dbn=\(dbn)"

        NetworkManager.SharedInstance.fetchData(url: url, parameters: nil) { (responseJson, errorMsg) in
            
            var error = ""
            var success = true
            if let errorString = errorMsg {
                
                success = false
                error = errorString
            } else {
                
                if let result = responseJson {
                    
                    if let satScore = self.populateSchoolSATScore(schoolSATDetails:result) {
                        self.schoolSATScoreDetails = satScore
                    }
                    
                } else {
                    
                    success = false
                    error = "Issue with SAT Score Service"
                }
            }
            completionHandler(success, error)
        }
    }
    
    // MARK: - School SAT Score Population
    /// Populates the school SAT score to the  schoolSATScoreDetails with "dbn" value used for fetching the details
    ///
    /// - parameter schoolSATDetails: list of school SAT details
    ///
    
    func populateSchoolSATScore(schoolSATDetails : [[String:Any]]) -> SATScoreModel?{
        
        var satDetail : SATScoreModel?
        
        for item in schoolSATDetails {
            
            satDetail = SATScoreModel()
            
            if let dbn = item["dbn"]  as? String {
                satDetail!.dbn = dbn
            }
            
            if let schoolName = item["school_name"]  as? String {
                satDetail!.schoolName = schoolName
            }
            
            if let noOfTestTakers = item["num_of_sat_test_takers"]  as? String {
                satDetail!.numberOfSATTestTakers = noOfTestTakers
            }
            
            if let readingAvgScore = item["sat_critical_reading_avg_score"]  as? String {
                satDetail!.satCriticalReadingAvgScore = readingAvgScore
            }
            
            if let mathAvgScore = item["sat_math_avg_score"]  as? String {
                satDetail!.satMathAvgScore = mathAvgScore
            }
            
            if let writingAvgScore = item["sat_writing_avg_score"]  as? String {
                satDetail!.satWritingAvgScore = writingAvgScore
            }
        }
        return satDetail
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
