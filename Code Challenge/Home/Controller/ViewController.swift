//
//  ViewController.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainViewHolder = HomePresenter()
    let alert = PMAlertView()
    let request = PMAPiRequestHandler()
    var activity = PMActivity()
    let networking = HomeNetworking()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Dashboard"
        // set the status bar to light so the status bar doesn't clash with our black nav bar!
        navigationController?.navigationBar.barStyle = .black
        mainViewHolder.controller = self
        mainViewHolder.setupView()
        
        networking.controller = self
        networking.bindDataToView()
    }
}

