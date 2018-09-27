//
//  SchoolSATScoreViewController.swift
//  20180926-SaurabhAnand-NYCSchools
//
//  Created by Saurabh Anand on 9/26/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import UIKit

class SchoolSATScoreViewController: UIViewController {

    @IBOutlet weak var schoolNamelabel: UILabel!
    
    @IBOutlet weak var totalNoOfStudentsLabel: UILabel!
    
    @IBOutlet weak var criticalReadingAvgScoreLabel: UILabel!
    
    @IBOutlet weak var mathAvgScoreLabel: UILabel!
    
    @IBOutlet weak var writingAvgScoreLabel: UILabel!
    
    @IBOutlet weak var activityInProgress: UIActivityIndicatorView!
    
    var dbn : String?
    var schoolName: String = ""
    
    let viewModel : SATScoreViewModel = SATScoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //default should be hidden
        activityInProgress.isHidden = true

        // load SAT score view
        fetchSATScores()
    }
    
    // MARK: - Fetch SAT Scores
    ///  fetch the SAT score data by passing dbn value of selected school
    /// If error, then show error else load the score view
    ///
    func fetchSATScores() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            if let strongSelf = self {
                
                if let uniqueDbn = strongSelf.dbn {
                    
                    DispatchQueue.main.async {
                        strongSelf.activityInProgress.isHidden = false
                        strongSelf.activityInProgress.startAnimating()
                    }

                    strongSelf.viewModel.fetchSchoolSATScore(dbn: uniqueDbn,completionHandler: { (success, errorMsg) in
                        
                        DispatchQueue.main.async {
                            
                            strongSelf.activityInProgress.isHidden = true
                            strongSelf.activityInProgress.stopAnimating()

                            if success == false {
                                
                                let alert = strongSelf.viewModel.showAlert(errorMsg: errorMsg ?? "")
                                strongSelf.present(alert, animated: true, completion: nil)
                            } else {
                                
                                strongSelf.loadSATScore()
                            }
                        }
                    })
                } else {
                    print("dbn should exist")
                }
            }
        }
    }
    
    
    // MARK: - Load SAT Scores
    /// If SAT score data, the set each component respectively
    /// If information is not available then show the same message
    ///
    func loadSATScore() {
        if let satScoreModel = viewModel.schoolSATScoreDetails {
            
            schoolNamelabel.text = satScoreModel.schoolName ?? schoolName
            totalNoOfStudentsLabel.text = satScoreModel.numberOfSATTestTakers ?? "Not Available"
            criticalReadingAvgScoreLabel.text = satScoreModel.satCriticalReadingAvgScore ?? "Not Available"
            mathAvgScoreLabel.text = satScoreModel.satMathAvgScore ?? "Not Available"
            writingAvgScoreLabel.text = satScoreModel.satWritingAvgScore ?? "Not Available"
        } else {
            
            schoolNamelabel.text = schoolName
            totalNoOfStudentsLabel.text = "Not Available"
            criticalReadingAvgScoreLabel.text = "No Scores Available"
            mathAvgScoreLabel.text = "No Scores Available"
            writingAvgScoreLabel.text = "No Scores Available"

        }
    }
}

