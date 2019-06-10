//
//  PMActivity.swift
//  Code Challenge
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PMActivity: UIView{
    
    //MARK:- Properties
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    var messageLabel: UILabel = {
        let message = UILabel()
        message.font = boldFont
        message.numberOfLines = 0
        message.textAlignment = .center
        return message
    }()
    
    var viewcontroller: UIViewController?

    //MARK:- Initaliser
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(white: 0, alpha: 0.6)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup View
    func setupView(txt: String){
        // create a holder view that will hold our activity indicator and label
        let holderView = UIView()
        holderView.layer.cornerRadius = 15
        holderView.backgroundColor = .white
        self.addSubview(holderView)
        holderView.width(200)
        holderView.height(200)
        holderView.centerX(to: self)
        holderView.centerY(to: self)

        holderView.addSubview(activityIndicator)
        // center and drop 30 from the top of the holder view
        activityIndicator.centerX(to: holderView)
        activityIndicator.centerY(to: holderView, offset: -20)
        activityIndicator.startAnimating()
        
        holderView.addSubview(messageLabel)
        messageLabel.centerX(to: holderView)
        messageLabel.centerY(to: holderView, offset: 30)
        messageLabel.width(to: holderView)
        messageLabel.height(40)
        messageLabel.text = txt
       
    }

    //MARK:- Helper
    func stopActivity() {
        // call this to stop
        activityIndicator.stopAnimating()
    }
}

