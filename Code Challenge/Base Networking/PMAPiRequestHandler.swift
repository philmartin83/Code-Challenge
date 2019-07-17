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
    func getCreditInfo(completion: @escaping ((BaseModel?, Error?)-> ())){
        // both items in this completion are optional so I can handle the errors in the viewcontroller
        // you can just use the dataTask(with: <url>) here but most requests need stuff added to the body or heades for security so I always use (with: URLRequest)
        URLSession.shared.dataTask(with: PMRequest().creditRequest()) { (data, response, error) in
            // here I cast the response and unwrap to check the status code
            if let httpResponse = response as? HTTPURLResponse {
                // check if the status code is less then 300 so 200 SUCCESS yay!
                if httpResponse.statusCode < 300{
                    // unwrap our data from the server if the data is nil we should return an error
                    guard let data = data else{
                        completion(nil, error)
                        return
                    }
                    //do catch to check for errors and present and alert
                    do{
                        // decode the json and return the base model object to the viewcontroller and update the view subclass
                        let base = try JSONDecoder().decode(BaseModel.self, from: data)
                        completion(base, nil)
                    }catch{
                        // pass back the error to the UI
                        completion(nil, error)
                    }
                }else{
                    completion(nil, error)
                }
            }else{
                completion(nil, error)
            }
           
        }.resume()
    }
}
