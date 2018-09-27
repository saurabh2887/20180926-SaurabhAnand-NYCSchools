//
//  SchoolListTableViewController.swift
//  20180926-SaurabhAnand-NYCSchools
//
//  Created by Saurabh Anand on 9/26/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import UIKit

class SchoolListTableViewController: UITableViewController {

    @IBOutlet weak var searchField: UISearchBar!
    
    let viewModel : SchoolViewModel = SchoolViewModel()
    
    var schoolList = [SchoolDetailModel]()
    
    var selectedSchoolUniqueId : String? //dbn
    
    var schoolName : String = ""
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        activityIndicator.center = self.view.center

        // Load school list
        fetchSchoolList()
    }
    
    
    // MARK: - Fetch School list
    /// Fetch School List data and refresh table view.
    /// If there is any error, then show the error.
    ///
    func fetchSchoolList() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let strongSelf = self {
                
                DispatchQueue.main.async {
                    strongSelf.view.addSubview(strongSelf.activityIndicator)
                    strongSelf.activityIndicator.startAnimating()
                }
                
                strongSelf.viewModel.fetchSchoolList(completionHandler: { (success, errorMsg) in
                    DispatchQueue.main.async {
                        
                        strongSelf.activityIndicator.stopAnimating()
                        strongSelf.activityIndicator.removeFromSuperview()
                        
                        if success == false {
                            
                            let alert = strongSelf.viewModel.showAlert(errorMsg: errorMsg ?? "")
                            strongSelf.present(alert, animated: true, completion: nil)
                        } else {
                            
                            strongSelf.schoolList = strongSelf.viewModel.schoolDetailList
                        }
                        strongSelf.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolList.count
    }

    // sets up the school details from schoolDetailList
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolListCell", for: indexPath)

        // Configure the cell...
        if let schoolName = schoolList[indexPath.row].schoolName {
            cell.textLabel?.text = schoolName
        } else {
            cell.textLabel?.text = "No School Name"
        }
        
        return cell
    }
    
    // navigate it to SAT Score view, first set dbn value to filter the SAT Score Details list
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let dbn = schoolList[indexPath.row].dbn {
            selectedSchoolUniqueId = dbn
        }
        
        if let name = schoolList[indexPath.row].schoolName {
            schoolName = name
        } else  {
            schoolName = "No School Name"
        }
        
        performSegue(withIdentifier: "satScoreView", sender: self)
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected dbn to the new view controller.
        
        if segue.identifier == "satScoreView" {
            
            let destinationVC = segue.destination as! SchoolSATScoreViewController
            destinationVC.dbn = selectedSchoolUniqueId
            destinationVC.schoolName = schoolName
        }
    }
 }

// MARK: - Search Field Delegates

extension SchoolListTableViewController : UISearchBarDelegate {
    
    // When search string is entered, schoolDetailList is filtered based on school name
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            let filteredArray = viewModel.schoolDetailList.filter { (schoolDetail) -> Bool in
                if let schoolName = schoolDetail.schoolName {
                    if schoolName.contains(searchText) {
                        return true
                    }
                }
                return false
            }
            
            schoolList = filteredArray
        } else {
            schoolList = viewModel.schoolDetailList
            searchBar.resignFirstResponder()
        }
        tableView.reloadData()
    }
}
