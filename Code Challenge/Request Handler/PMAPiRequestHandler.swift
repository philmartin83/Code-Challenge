//
//  PMAPiRequestHandler.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
import UIKit

class PMAPiRequestHandler: RequestProtocol{
    
    //MARK:- Constant
    var viewcontroller: ViewController?
    
    func getCreditInfo(completion: @escaping ((BaseModel?, Error?)-> ())){
        // both items in this completion are optional so I can handle the errors in the viewcontroller
        // you can just use the dataTask(with: <url>) here but most requests need stuff added to the body or heades for security so I always use (with: URLRequest)
        URLSession.shared.dataTask(with: PMRequest().creditRequest()) { [weak self] (data, response, error) in
            // handle strong ref
            if let weakSelf = self{
                // here I cast the response and unwrap to check the status code
                if let httpResponse = response as? HTTPURLResponse {
                    // check if the status code is less then 300 so 200 SUCCESS yay!
                    if httpResponse.statusCode < 300{
                        // unwrap our data from the server
                        guard let data = data else{
                            // we end up here if the unwrapped data fails in other words its nil
                            let messge = "Inalid data from the server."
                            weakSelf.viewcontroller?.alert.serverError(viewController: weakSelf.viewcontroller, body: messge, title: errorAlertTitle)
                            completion(nil, error)
                            return
                        }
                        //do catch to check for errors and present and alert
                        do{
                            // decode the json and return the base model object to the viewcontroller and update the view subclass
                            let base = try JSONDecoder().decode(BaseModel.self, from: data)
                            completion(base, nil)
                        }catch{
                            // catch the error and present the alert
                            weakSelf.viewcontroller?.alert.serverError(viewController: weakSelf.viewcontroller, body: error.localizedDescription, title: errorAlertTitle)
                            completion(nil, error)
                        }
                    }else{
                        // we end up here if the response status code fromt eh server is a 400, 404 or any other status code SAD TIMEs :(
                        let messge = "\(error?.localizedDescription ?? "") \nStatus: \(httpResponse.statusCode)"
                        weakSelf.viewcontroller?.alert.serverError(viewController: weakSelf.viewcontroller, body: messge, title: errorAlertTitle)
                        completion(nil, error)
                    }
                }else{
                    // we end up here if everything has gone totally wrong!!! in this instance maybe we should crash and report back using a tool like Crashlytics or Rollbar
                    weakSelf.viewcontroller?.alert.serverError(viewController: weakSelf.viewcontroller, body: error?.localizedDescription, title: errorAlertTitle)
                    completion(nil, error)
                }
            }
           
        }.resume()
    }
}
