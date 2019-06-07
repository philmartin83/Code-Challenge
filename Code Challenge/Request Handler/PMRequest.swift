//
//  PMRequest.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation

class PMRequest{
    
    // Most app's have multiple request to ,make so I normally crreat my own class to handle these
    // I'm doing this challenge the same way I would write a normal app.
    let endpoint = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    let timeout: TimeInterval = 10 // for the timeout
    
    func creditRequest() -> URLRequest {
        // create the reqesut
        let url = URL(string: endpoint)
        // I force unwrap here becasue if the URL is wrong then get out! the url should never be in the wrong format...
        return URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: timeout)
    }
    
}
