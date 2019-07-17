//
//  HomePresenter.swift
//  Code Challenge
//
//  Created by Philip Martin on 09/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter{
    
    weak var controller: ViewController?

    //MARK:- Properties
    let shapeLayer = CAShapeLayer()
    var progress: Float?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = boldFont
        label.text = "Your credit score is"
        label.textColor = .black
        label.numberOfLines = 0 // set this to 0 just incase small devices reqire multiple lines
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var creditScore: PMCountingLabel = {
        let label = PMCountingLabel()
        label.textColor = #colorLiteral(red: 1, green: 0.7277173941, blue: 0.009976259177, alpha: 1)
        label.font = lightFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var creditPossibleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = boldFont
        label.numberOfLines = 0 // again handle the size of he text for this label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        
        guard let controller = controller else {return}
        // set up title label
        controller.view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor, constant: -65).isActive = true
        
        // set up credit score label
        controller.view.addSubview(creditScore)
        creditScore.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        creditScore.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        // set up possible total score
        controller.view.addSubview(creditPossibleLabel)
        creditPossibleLabel.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        creditPossibleLabel.topAnchor.constraint(equalTo: creditScore.bottomAnchor, constant: 20).isActive = true
    
        // setup UI update listener
        updateUIOnResponse()
        
        
        // present activity view
        guard let nav = controller.navigationController else {return}
        controller.navigationController!.view.addSubview(controller.activity)
        controller.activity.translatesAutoresizingMaskIntoConstraints = false
        controller.activity.leadingAnchor.constraint(equalTo: nav.view.leadingAnchor).isActive = true
        controller.activity.trailingAnchor.constraint(equalTo: nav.view.trailingAnchor).isActive = true
        controller.activity.bottomAnchor.constraint(equalTo: nav.view.bottomAnchor).isActive = true
        controller.activity.topAnchor.constraint(equalTo: nav.view.topAnchor).isActive = true
        controller.activity.setupView(txt: "Loading")
    

    }
    
    func circleProgress(value: Float){
        
        guard let controller = controller else {return}
        // set the progress based on the value passed into this function
        progress = value
        
        // find the center of our custom view by using the midX and midY properties
        let center = CGPoint(x: controller.view.bounds.midX, y: controller.view.bounds.midY)

        // create a bezier path
        let circularPath = UIBezierPath(arcCenter: center, radius: 140, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat(value), clockwise: true)
        
        // set it to our shap layer
        shapeLayer.path = circularPath.cgPath
        
        // style the line and background colour of our shape
        shapeLayer.strokeColor = creditScoreTextColour.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        shapeLayer.strokeEnd = 0
        // add our sublayer and get animating!
        controller.view.layer.addSublayer(shapeLayer)
        animateCircleBasedOnCreditScore()
    }
    
    func updateUIOnResponse(){
        guard let controller = controller else {return}
        
        controller.networking.updateUI = { [weak self] (data, error) in
            if let weakSelf = self{
                controller.activity.dismissActivityView()
                if error != nil{
                    // present the relevant alert
                    controller.alert.serverError(viewController: controller, body: error?.localizedDescription, title: errorAlertTitle)
                    return
                }
                
                guard let data = data else{
                    // get back to the main thread to present our alert
                    controller.alert.serverError(viewController: controller, body: error?.localizedDescription, title: errorAlertTitle)
                    return
                }
                guard let mainCreditScore = data.creditReportInfo?.score, let maxScore = data.creditReportInfo?.maxScoreValue else{
                    controller.alert.serverError(viewController: controller, body: errorFetchingFromServer, title: errorAlertTitle)
                    return
                }
                let castScoreToFloat = Float(mainCreditScore)
                
                // call the count function on the custom label to increment the counter to the given value from the API
                weakSelf.creditScore.count(fromValue: 1, to: castScoreToFloat, withDuration: TimeInterval(animationDuration), withAnimationType: .EaseOut, withCounterType: .Int)
                
                // now to add our progress indicator values
                let progressIndicator =  maxScore / mainCreditScore
                weakSelf.circleProgress(value: Float(progressIndicator))
                
                // set the total value from the credit score
                weakSelf.creditPossibleLabel.text = "out of \(maxScore)"
            }
        }
    }
    
    fileprivate func animateCircleBasedOnCreditScore() {
        // create our keypath set our keypath
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = progress
        basicAnimation.duration = CFTimeInterval(animationDuration)
        // set the ease out to match the number incremetation
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}


