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
    let alert = PMAlertViewController()
    var activity = PMActivity()
    func bindDataToView(viewController: UIViewController, mainViewHolder: PMDataHolderView){
        
        // only add the activity if we can unwrap the navigation controller else just continue.
        if let navigation =  viewController.navigationController{
            // create our activity indicator and add to the subview of our viewcontroller.
            activity.setupView(txt: "Loading")
            activity.viewcontroller = viewController
            navigation.view.addSubview(activity)
            activity.edgesToSuperview()
        }
       
        // make our request to the get the credit info
        PMAPiRequestHandler().getCreditInfo(viewcontroller: viewController) { [weak self] (base, error) in
            
            // handle retain cycles
            if let weakSelf = self{
                if error != nil{
                    DispatchQueue.main.async {
                        viewController.present(weakSelf.alert.presentAlert(title: errorAlertTitle, body: error?.localizedDescription), animated: true, completion: nil)
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
                            mainViewHolder.creditScore.count(fromValue: 1, to: castScoreToFloat, withDuration: TimeInterval(animationDuration), withAnimationType: .EaseOut, withCounterType: .Int)
                            
                            // now to add our progress indicator
                            
                            let progressIndicator =  maxScore / mainCreditScore
                            mainViewHolder.circleProgress(value: Float(progressIndicator))
                            
                            // set the total value from the credit score
                            mainViewHolder.creditPossibleLabel.text = "out of \(maxScore)"
                        }else{
                           viewController.present(weakSelf.alert.presentAlert(title: errorAlertTitle, body: "Error fetching data from server"), animated: true, completion: nil)
                        }
                        
                    }
                    
                }else{
                    // get back to the main thread to present our alert
                    DispatchQueue.main.async { 
                        viewController.present(weakSelf.alert.presentAlert(title: errorAlertTitle, body: error?.localizedDescription), animated: true, completion: nil)
                    }
                }
                
                // return to the main thread to clean up the activity inidicator
                DispatchQueue.main.async {
                    // stop the acitvity indicator spinning
                    weakSelf.activity.stopActivity()
                    // remove our acitivty inidcator
                    weakSelf.activity.removeFromSuperview()
                }
            }
        }
    }
}
