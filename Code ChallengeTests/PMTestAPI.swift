//
//  PMTestAPI.swift
//  Code ChallengeTests
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import XCTest
@testable import Code_Challenge

class PMTestAPI: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testModels(){
        do{
            let baseModel = try JSONDecoder().decode(BaseModel.self, from: allData)
            XCTAssertEqual(baseModel.accountIDVStatus, "PASS")
            XCTAssertEqual(baseModel.creditReportInfo?.score, 514)
            XCTAssertEqual(baseModel.creditReportInfo?.scoreBand, 4)
            
            XCTAssertEqual(baseModel.creditReportInfo?.clientRef, "CS-SED-655426-708782")
            XCTAssertEqual(baseModel.creditReportInfo?.status, "MATCH")
            XCTAssertEqual(baseModel.creditReportInfo?.maxScoreValue, 700)
            
            XCTAssertEqual(baseModel.creditReportInfo?.minScoreValue, 0)
            XCTAssertEqual(baseModel.creditReportInfo?.monthsSinceLastDefaulted, -1)
            XCTAssertFalse((baseModel.creditReportInfo?.hasEverDefaulted)!) // unwrap here has we have a default value provided
            
            XCTAssertEqual(baseModel.creditReportInfo?.monthsSinceLastDelinquent, 1)
            XCTAssertTrue((baseModel.creditReportInfo?.hasEverBeenDelinquent)!)
            XCTAssertEqual(baseModel.creditReportInfo?.percentageCreditUsed, 44)
            
            XCTAssertEqual(baseModel.creditReportInfo?.percentageCreditUsedDirectionFlag, 1)
            XCTAssertEqual(baseModel.creditReportInfo?.changedScore, 0)
            XCTAssertEqual(baseModel.creditReportInfo?.currentShortTermDebt, 13758)
            
            XCTAssertEqual(baseModel.coachingSummary?.numberOfTodoItems, 0)
            
            XCTAssertTrue((baseModel.coachingSummary?.activeChat)!)
            XCTAssertFalse((baseModel.coachingSummary?.activeTodo)!) // unwrap here has we have a default value provided
    
        }catch{
            XCTFail("failed to parse the json")
        }
       
    }
    
    // I would also normally create a set of 'bad data' to test, but because of time contraints I haven't here
    private let allData = Data("""
    {
    "accountIDVStatus": "PASS",
    "creditReportInfo": {
        "score": 514,
        "scoreBand": 4,
        "clientRef": "CS-SED-655426-708782",
        "status": "MATCH",
        "maxScoreValue": 700,
        "minScoreValue": 0,
        "monthsSinceLastDefaulted": -1,
        "hasEverDefaulted": false,
        "monthsSinceLastDelinquent": 1,
        "hasEverBeenDelinquent": true,
        "percentageCreditUsed": 44,
        "percentageCreditUsedDirectionFlag": 1,
        "changedScore": 0,
        "currentShortTermDebt": 13758,
        "currentShortTermNonPromotionalDebt": 13758,
        "currentShortTermCreditLimit": 30600,
        "currentShortTermCreditUtilisation": 44,
        "changeInShortTermDebt": 549,
        "currentLongTermDebt": 24682,
        "currentLongTermNonPromotionalDebt": 24682,
        "currentLongTermCreditLimit": null,
        "currentLongTermCreditUtilisation": null,
        "changeInLongTermDebt": -327,
        "numPositiveScoreFactors": 9,
        "numNegativeScoreFactors": 0,
        "equifaxScoreBand": 4,
        "equifaxScoreBandDescription": "Excellent",
        "daysUntilNextReport": 9
    },
    "dashboardStatus": "PASS",
    "personaType": "INEXPERIENCED",
    "coachingSummary": {
        "activeTodo": false,
        "activeChat": true,
        "numberOfTodoItems": 0,
        "numberOfCompletedTodoItems": 0,
        "selected": true
    },
    "augmentedCreditScore": null
    }
    """.utf8)


}
