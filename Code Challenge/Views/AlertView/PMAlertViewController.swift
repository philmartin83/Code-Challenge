//
//  PMAlertViewController.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMAlertViewController {

    // again in a normal app you may require multiple alerts and some may be custom so I put all alerts in its own class. Again I'm doing this code challenge based on how I would program a normal app
    internal func presentAlert(title: String, body: String?) -> UIAlertController{
        // all pretty standard stuff here.
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonAlertTitle, style: .cancel, handler: nil))
        return alert
    }
    
    // MARK:- Helper
    func serverError(viewController: UIViewController?, body: String?, title: String){
        // one place to present the alert again put here so ew don't have to hun for it.
        // could probably be placed in the PMAlertViewController class for consistency
        viewController?.present(presentAlert(title: title, body: body), animated: true, completion: nil)
    }
}
