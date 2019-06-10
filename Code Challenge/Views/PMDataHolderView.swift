//
//  PMDataHolderView.swift
//  Code Challenge
//
//  Created by Philip Martin on 09/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PMDataHolderView: UIView{

    //MARK:- Properties
    let shapeLayer = CAShapeLayer()
    var progress: Float?

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = boldFont
        label.text = "Your credit score is"
        label.textColor = .black
        label.numberOfLines = 0 // set this to 0 just incase small devices reqire multiple lines
        label.textAlignment = .center
        return label
    }()
    
    var creditScore: PMCountingLabel = {
        let label = PMCountingLabel()
        label.textColor = #colorLiteral(red: 1, green: 0.7277173941, blue: 0.009976259177, alpha: 1)
        label.font = lightFont
        label.textAlignment = .center
        return label
    }()
    
    var creditPossibleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = boldFont
        label.numberOfLines = 0 // again handle the size of he text for this label
        return label
    }()
    
    //MARK:- Initalisers
    init(){
        super.init(frame: .zero)
        setupBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View Setup
    fileprivate func setupBackgroundView()  {
        self.height(300)
        self.width(300)
        self.layer.cornerRadius = 300 / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        setupView()
    }
    
   fileprivate func setupView(){
        
        // set up title label using TinyConstraints
        self.addSubview(titleLabel)
        titleLabel.top(to: self, offset: 70)
        titleLabel.centerX(to: self)
        titleLabel.height(50)
        titleLabel.width(280)
        
        // set up credit score label using TinyConstraints
        self.addSubview(creditScore)
        creditScore.topToBottom(of: titleLabel, offset: -20)//(to: titleLabel, offset: 100)
        creditScore.centerX(to: self)
        creditScore.width(300)
        creditScore.height(130)
        
        // set up possible total score label using TinyConstraints
        self.addSubview(creditPossibleLabel)
        creditPossibleLabel.topToBottom(of: creditScore, offset: -20)
        creditPossibleLabel.centerX(to: self)
        creditPossibleLabel.width(150)
        creditPossibleLabel.height(50)
        
    }
    
    func circleProgress(value: Float){
        
        // set the progress based on the value passed into this function
        progress = value
        
        // find the center of our custom view by using the midX and midY properties
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

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
        self.layer.addSublayer(shapeLayer)
        animateCircleBasedOnCreditScore()
        
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


