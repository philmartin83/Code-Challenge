//
//  PMDataLayer.swift
//  Code Challenge
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMDataLayer {
    
    //MARK:- Properties
    var viewController: ViewController?

    //MARK:- Helper
    func bindDataToView(){
        
        // only add the activity if we can unwrap the navigation controller else just continue.
        if let navigation =  viewController?.navigationController{
            // create our activity indicator and add to the subview of our viewcontroller.
            viewController?.activity.setupView(txt: "Loading")
            // viewController property should already be set
            navigation.view.addSubview(viewController!.activity)
            viewController?.activity.edgesToSuperview()
        }
       
        // make our request to the get the credit info
        viewController?.request.getCreditInfo() { [weak self] (base, error) in
            
            // handle retain cycles
            if let weakSelf = self{
                if error != nil{
                    DispatchQueue.main.async {
                        // present the relevant alert
                        weakSelf.viewController?.alert.serverError(viewController: weakSelf.viewController, body: error?.localizedDescription, title: errorAlertTitle)
                        // clean up the activity view
                        weakSelf.viewController?.activity.dismissActivityView()
                    }
                    return
                }
                if let base = base{
                    // get back to the main thread to update our label progress bar and incrementing label
                    DispatchQueue.main.async {
                        // cast the score to float to handle my counter function
                        if let mainCreditScore = base.creditReportInfo?.score, let maxScore = base.creditReportInfo?.maxScoreValue{
                            let castScoreToFloat = Float(mainCreditScore)
                            
                            // call the count function on the custom label to increment the counter to the given value from the API
                            weakSelf.viewController?.mainViewHolder.creditScore.count(fromValue: 1, to: castScoreToFloat, withDuration: TimeInterval(animationDuration), withAnimationType: .EaseOut, withCounterType: .Int)
                            
                            // now to add our progress indicator values
                            let progressIndicator =  maxScore / mainCreditScore
                            weakSelf.viewController?.mainViewHolder.circleProgress(value: Float(progressIndicator))
                            
                            // set the total value from the credit score
                            weakSelf.viewController?.mainViewHolder.creditPossibleLabel.text = "out of \(maxScore)"
                            
                        }else{
                           weakSelf.viewController?.alert.serverError(viewController: weakSelf.viewController, body: errorFetchingFromServer, title: errorAlertTitle)
                        }
                    }
                    
                }else{
                    // get back to the main thread to present our alert
                    DispatchQueue.main.async { 
                        weakSelf.viewController?.alert.serverError(viewController: weakSelf.viewController, body: error?.localizedDescription, title: errorAlertTitle)
                    }
                }
                
                // return to the main thread to clean up the activity inidicator
                DispatchQueue.main.async {
                    // clean up the activity view
                    weakSelf.viewController?.activity.dismissActivityView()
                }
            }
        }
    }
}
