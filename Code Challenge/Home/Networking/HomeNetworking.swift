//
//  HomeNetworking.swift
//  Code Challenge
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class HomeNetworking {
    
    //MARK:- Properties
    weak var controller: ViewController?
    var updateUI: ((BaseModel?, Error?)-> Void)?

    //MARK:- Helper
    func bindDataToView(){
        // make our request to the get the credit info
        guard let controller = controller else {return}
        controller.request.getCreditInfo() { [weak self] (base, error) in
            // handle retain cycles
            if let weakSelf = self{
                // return to the main thread to clean up the activity inidicator
                DispatchQueue.main.async {
                    weakSelf.updateUI?(base, error)
                }
            }
        }
    }
}
