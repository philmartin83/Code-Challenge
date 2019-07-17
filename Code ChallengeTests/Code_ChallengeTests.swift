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
    let alert = PMAlertView()
    
    func testFunctionalAlert(){
        let result = alert.presentAlert(title: "Error", body: "message body")
    
        XCTAssertEqual(result.title, "Error")
        XCTAssertEqual(result.message, "message body")
        
        // check to make sure the optional can handle nil and won't crash
        let badResult = alert.presentAlert(title: "Error", body: nil)
        XCTAssertEqual(badResult.message, nil)
        
    }
    
    func testDataHolderViewTitleClosure(){
        let presenter = HomePresenter()
        let vc = ViewController()
        presenter.controller = vc
        XCTAssertEqual(presenter.titleLabel.text, "Your credit score is")
        presenter.circleProgress(value: 20)
        XCTAssertEqual(presenter.progress, 20)
    }
    
    func testBindingOfData(){
        let vc = ViewController()
        let holderView = HomePresenter()
        let dataBind = HomeNetworking()
        dataBind.controller = vc
        holderView.controller = vc
        dataBind.bindDataToView()
        XCTAssertNotNil(holderView.titleLabel)
    }
    
    func testActivty(){
        let activity = PMActivity()
        activity.setupView(txt: "value")
        activity.dismissActivityView()
        XCTAssertEqual(activity.messageLabel.text, "value")
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
        let expectation = XCTestExpectation.init(description: "Successful Response")
        PMAPiRequestHandler().getCreditInfo() { (base, error) in
            
            if error != nil{
                XCTFail("Test failed")
            }else{
               expectation.fulfill()
            }
            
        }
    }
   
}
