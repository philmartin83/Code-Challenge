//
//  Code_ChallengeTests.swift
//  Code ChallengeTests
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import XCTest
@testable import Code_Challenge

class Code_ChallengeTests: XCTestCase {
    let alert = PMAlertViewController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFunctionalAlert(){
        let result = alert.presentAlert(title: "Error", body: "message body")
    
        XCTAssertEqual(result.title, "Error")
        XCTAssertEqual(result.message, "message body")
        
        // check to make sure the optional can handle nil and won't crash
        let badResult = alert.presentAlert(title: "Error", body: nil)
        XCTAssertEqual(badResult.message, nil)
        
    }
    
    func testBindingOfData(){
        let holderView = PMDataHolderView()
        let vc = UIViewController()
        let dataBind = PMDataLayer()
        dataBind.bindDataToView(viewController: vc, mainViewHolder: holderView)
        XCTAssertNotNil(holderView.titleLabel)
    }
    
    func testCustomLabel(){
        let customLabel = PMCountingLabel()
        customLabel.count(fromValue: 10, to: 100, withDuration: 10, withAnimationType: .EaseIn, withCounterType: .Int)
        customLabel.updateText(value: 20.4)
        
        XCTAssertEqual(customLabel.startNumber, 10)
        XCTAssertEqual(customLabel.endNumber, 100)
        XCTAssertEqual(customLabel.duration, 10)
        XCTAssertEqual(customLabel.animationType, PMCountingLabel.PMCounterAnimationType.EaseIn)
        XCTAssertEqual(customLabel.counterType, PMCountingLabel.PMCounterType.Int)
    }
    
    func testRequest(){
        let viewController = UIViewController()
        let expectation = XCTestExpectation.init(description: "Successful Response")
        PMAPiRequestHandler().getCreditInfo(viewcontroller: viewController) { (base, error) in
            
            if error != nil{
                XCTFail("Test failed")
            }else{
               expectation.fulfill()
            }
            
        }
    }
   
}
