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
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.text = "You're credit score is"
        label.textColor = .black
        label.numberOfLines = 0 // set this to 0 just incase small devices reqire multiple lines
        label.textAlignment = .center
        return label
    }()
    
    var creditScore: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 0.7277173941, blue: 0.009976259177, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Light", size: 70)
        label.textAlignment = .center
        return label
    }()
    
    var creditPossibleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
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
    
    //MARK:= View Setup
    func setupBackgroundView()  {
        self.height(300)
        self.width(300)
        self.layer.cornerRadius = 300 / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        setupView()
    }
    
    func setupView(){
        self.addSubview(titleLabel)
        titleLabel.top(to: self, offset: 70)
        titleLabel.centerX(to: self)
        titleLabel.height(50)
        titleLabel.width(280)
        
        self.addSubview(creditScore)
        creditScore.topToBottom(of: titleLabel, offset: -20)//(to: titleLabel, offset: 100)
        creditScore.centerX(to: self)
        creditScore.width(300)
        creditScore.height(130)
        
        self.addSubview(creditPossibleLabel)
        creditPossibleLabel.topToBottom(of: creditScore, offset: -20)
        creditPossibleLabel.centerX(to: self)
        creditPossibleLabel.width(150)
        creditPossibleLabel.height(50)
    
    }
    
    func circleProgress(){
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: self.center, radius: 100, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        self.layer.addSublayer(shapeLAyer)
        
    }
}


