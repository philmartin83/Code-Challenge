//
//  PMAPiRequestHandler.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMAPiRequestHandler{
    
    //MARK:- Constant
    let alert = PMAlertViewController()
    let alertTitle = "Error" //  set a constant here so its easier to change in one plaxe then hunting for it everywhere
    
    func getCreditInfo(viewcontroller: UIViewController, completion: @escaping ((BaseModel?, Error?)-> ())){
        // both items in this completion are optional so I can handle the errors in the viewcontroller
        
        URLSession.shared.dataTask(with: PMRequest().creditRequest()) { (data, response, error) in
            // here I cast the response and unwrap to check the status code
            if let httpResponse = response as? HTTPURLResponse {
                // check if the status code is less then 300 so 200 SUCCESS yay!
                if httpResponse.statusCode < 300{
                    // unwrap our data from the server
                    if let data = data{
                        //do catch to check for errors and present and alert
                        do{
                            // decode the json and return the base model object to the viewcontroller and update the view subclass
                            let base = try JSONDecoder().decode(BaseModel.self, from: data)
                            completion(base, nil)
                        }catch{
                            // catch the error and present the alert
                            self.alert.serverError(viewController: viewcontroller, body: error.localizedDescription, title: self.alertTitle)
                            completion(nil, error)
                        }
                       
                    }else{
                        // we end up here if the unwrapped data fails in other words its nil
                        let messge = "Inalid data from the server"
                        self.alert.serverError(viewController: viewcontroller, body: messge, title: self.alertTitle)
                        completion(nil, error)
                    }
                }else{
                    // we end up here if the response status code fromt eh server is a 400, 404 or any other status code SAD TIMEs :(
                    let messge = "\(error?.localizedDescription ?? "") \nStatus: \(httpResponse.statusCode)"
                    self.alert.serverError(viewController: viewcontroller, body: messge, title: self.alertTitle)
                    completion(nil, error)
                }
            }else{
                // we end up here if everything has gone totally wrong!!! in this instance maybe we should crash and report back using a tool like Crashlytics or Rollbar
                let message = "Invalid response code"
                self.alert.serverError(viewController: viewcontroller, body: message, title: self.alertTitle)
                completion(nil, error)
            }
        }.resume()
    }
}
