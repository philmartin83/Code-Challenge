//
//  PMAlertViewController.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMAlertViewController: UIAlertController {
    
    // again in a normal app you may require multiple alerts and some may be custom so I put all alerts in its own class. Again I'm doing this code challenge based on how I would program a normal app
    func presentAlert(title: String, body: String) -> UIAlertController{
        // all pretty standard stuff here.
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
