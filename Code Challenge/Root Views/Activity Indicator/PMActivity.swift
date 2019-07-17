//
//  PMActivity.swift
//  Code Challenge
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMActivity: UIView, ViewProtocol{
    
    //MARK:- Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var messageLabel: UILabel = {
        let message = UILabel()
        message.font = boldFont
        message.numberOfLines = 0
        message.textAlignment = .center
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
    
    lazy var holderView: UIView = {
        let holderView = UIView()
        holderView.layer.cornerRadius = 15
        holderView.backgroundColor = .white
        holderView.translatesAutoresizingMaskIntoConstraints = false
        return holderView
    }()
    
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

        self.addSubview(holderView)
        holderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        holderView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        holderView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        holderView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        holderView.addSubview(activityIndicator)
        // center and drop 30 from the top of the holder view
        activityIndicator.centerXAnchor.constraint(equalTo: holderView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: holderView.centerYAnchor, constant: -20).isActive = true
        activityIndicator.startAnimating()
        
        holderView.addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: holderView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: holderView.centerYAnchor, constant: 30).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10).isActive = true
        messageLabel.text = txt
       
    }

    //MARK:- Helper
    func stopActivity() {
        // call this to stop
        activityIndicator.stopAnimating()
    }
    
    //MARK:- Dismiss
    func dismissActivityView() {
        stopActivity()
        self.removeFromSuperview()
    }
}

