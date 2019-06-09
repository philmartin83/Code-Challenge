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
    
    init(){
        super.init(frame: .zero)
        setupBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundView()  {
        self.height(220)
        self.width(220)
//       itleLabel.top(to: self, offset: 10) self.layer.cornerRadius = 300 / 2
        self.clipsToBounds = true
        setupView()
    }
    
    func setupView(){
        self.addSubview(titleLabel)
        titleLabel.top(to: self, offset: 10)
        titleLabel.centerX(to: self)
        titleLabel.height(50)
        titleLabel.width(280)
        
        self.addSubview(creditScore)
        creditScore.bottom(to: titleLabel, offset: 150)
        creditScore.centerX(to: self)
        creditScore.width(300)
        creditScore.height(130)
        
        self.addSubview(creditPossibleLabel)
        creditPossibleLabel.bottom(to: creditScore, offset: 50)
        creditPossibleLabel.centerX(to: self)
        titleLabel.top(to:
            creditPossibleLabel, offset: 10)
        creditPossibleLabel.width(150)
        creditPossibleLabel.height(50)
    
    }
}


