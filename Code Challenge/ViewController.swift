//
//  ViewController.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {
    
    let mainViewHolder = PMDataHolderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(mainViewHolder)
        mainViewHolder.centerX(to: view)
        mainViewHolder.centerY(to: view)
        mainViewHolder.creditScore.text = "200"
        mainViewHolder.creditPossibleLabel.text = "out of 700"
        
        PMAPiRequestHandler().getCreditInfo(viewcontroller: self) { [weak self] (base, error) in
            
            // handle retain cycles
            if let weakSelf = self{
                print(base)
            }
        }
    }
}

