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
    let alert = PMAlertView()
    let request = PMAPiRequestHandler()
    var activity = PMActivity()
    let dataLayer = PMDataLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Dashboard"
        // set the status bar to light so the status bar doesn't clash with our black nav bar!
        navigationController?.navigationBar.barStyle = .black
        view.addSubview(mainViewHolder)
        mainViewHolder.centerX(to: view)
        mainViewHolder.centerY(to: view)
        
        dataLayer.viewController = self
        dataLayer.bindDataToView()
    }
}

