//
//  _0180926_SaurabhAnand_NYCSchoolsTests.swift
//  20180926-SaurabhAnand-NYCSchoolsTests
//
//  Created by Saurabh Anand on 9/26/18.
//  Copyright © 2018 Saurabh Anand. All rights reserved.
//

import XCTest
@testable import _0180926_SaurabhAnand_NYCSchools

class _0180926_SaurabhAnand_NYCSchoolsTests: XCTestCase {

    var testViewModel: SchoolViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testViewModel = SchoolViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testViewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_fetchSchoolList(){
        
        var isFetched = false
        let expectation = self.expectation(description: "Location")
        
        testViewModel.fetchSchoolList(completionHandler: { (isSuccess, errorMsg) in
            if isSuccess{
                isFetched = true
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(isFetched)
    }
    
    func test_populateSchoolDetailList(){
        
        let response = [["academicopportunities1": "Free college courses at neighboring universities",
                         "academicopportunities2": "International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language",
                         "admissionspriority11": "Priority to continuing 8th graders",
                         "admissionspriority21": "Then to Manhattan students or residents",
                         "admissionspriority31": "Then to New York City residents",
                         "attendance_rate": "0.970000029",
                         "bbl": "1008420034",
                         "bin": "1089902",
                         "boro": "M",
                         "borough": "MANHATTAN",
                         "building_code": "M868",
                         "bus": "BM1, BM2, BM3, BM4, BxM10, BxM6, BxM7, BxM8, BxM9, M1, M101, M102, M103, M14A, M14D, M15, M15-SBS, M2, M20, M23, M3, M5, M7, M8, QM21, X1, X10, X10B, X12, X14, X17, X2, X27, X28, X37, X38, X42, X5, X63, X64, X68, X7, X9",
                         "census_tract": "52",
                         "city": "Manhattan",
                         "code1": "M64A",
                         "community_board": "5",
                         "council_district": "2",
                         "dbn": "02M260",
                         "directions1": "See theclintonschool.net for more information.",
                         "ell_programs": "English as a New Language",
                         "extracurricular_activities": "CUNY College Now, Technology, Model UN, Student Government, School Leadership Team, Music, School Musical, National Honor Society, The Clinton Post (School Newspaper), Clinton Soup (Literary Magazine), GLSEN, Glee",
                         "fax_number": "212-524-4365",
                         "finalgrades": "6-12",
                         "grade9geapplicants1": "1515",
                         "grade9geapplicantsperseat1": "19",
                         "grade9gefilledflag1": "Y",
                         "grade9swdapplicants1": "138",
                         "grade9swdapplicantsperseat1": "9",
                         "grade9swdfilledflag1": "Y",
                         "grades2018": "6-11",
                         "interest1": "Humanities & Interdisciplinary",
                         "latitude": "40.73653",
                         "location": "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)",
                         "longitude": "-73.9927",
                         "method1": "Screened",
                         "neighborhood": "Chelsea-Union Sq",
                         "nta": "Hudson Yards-Chelsea-Flatiron-Union Square                                 ",
                         "offer_rate1": "Â—57% of offers went to this group",
                         "overview_paragraph": "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
                         "pct_stu_enough_variety": "0.899999976",
                         "pct_stu_safe": "0.970000029",
                         "phone_number": "212-524-4360",
                         "primary_address_line_1": "10 East 15th Street",
                         "program1": "M.S. 260 Clinton School Writers & Artists",
                         "requirement1_1": "Course Grades: English (87-100), Math (83-100), Social Studies (90-100), Science (88-100)",
                         "requirement2_1": "Standardized Test Scores: English Language Arts (2.8-4.5), Math (2.8-4.5)",
                         "requirement3_1": "Attendance and Punctuality",
                         "requirement4_1": "Writing Exercise",
                         "requirement5_1": "Group Interview (On-Site)",
                         "school_10th_seats": "1",
                         "school_accessibility_description": "1",
                         "school_email": "admissions@theclintonschool.net",
                         "school_name": "Clinton School Writers & Artists, M.S. 260",
                         "school_sports": "Cross Country, Track and Field, Soccer, Flag Football, Basketball",
                         "seats101": "YesÂ–9",
                         "seats9ge1": "80",
                         "seats9swd1": "16",
                         "state_code": "NY",
                         "subway": "1, 2, 3, F, M to 14th St - 6th Ave; 4, 5, L, Q to 14th St-Union Square; 6, N, R to 23rd St",
                         "total_students": "376",
                         "website": "www.theclintonschool.net",
                         "zip": "10003"]]
        
        let schoolDetailList = testViewModel.populateSchoolDetailList(schoolDetails:response )
        
        XCTAssertFalse(schoolDetailList.count == 0)
    }

}

class SATScoreViewModelTests: XCTestCase {
    
    var testViewModel: SATScoreViewModel!
    
    override func setUp() {
        testViewModel = SATScoreViewModel()
        
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testViewModel = nil
        super.tearDown()
    }
    
    func test_fetchSchoolSATScore(){
        
        var isFetched = false
        let expectation = self.expectation(description: "Location")
        
        testViewModel.fetchSchoolSATScore(dbn: "02M260", completionHandler: { (isSuccess, errorMsg) in
            if isSuccess{
                isFetched = true
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(isFetched)
    }
    
    func test_populateSchoolDetailList(){
        
        let response = [[ "dbn": "01M292",
                          "num_of_sat_test_takers": "29",
                          "sat_critical_reading_avg_score": "355",
                          "sat_math_avg_score": "404",
                          "sat_writing_avg_score": "363",
                          "school_name": "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES"]]
        
        let schoolSATScoreDetails = testViewModel.populateSchoolSATScore(schoolSATDetails: response)
        
        XCTAssertFalse(schoolSATScoreDetails == nil)
    }
    
}

class NetworkManagerTests: XCTestCase {
    
    let manager = NetworkManager.SharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_fetchServiceApi(){

        
        let url = manager.kBaseURL + "97mf-9njv.json"
        
        let expectation = self.expectation(description: "Service")
        
        var isFetched = false
        
        manager.fetchData(url: url, parameters: nil) { (response, errorMsg) in
            
            if response != nil{
                isFetched = true
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(isFetched)
        
    }
}
