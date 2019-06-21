//
//  RequestProtocol.swift
//  Code Challenge
//
//  Created by Phil Martin on 21/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation

protocol RequestProtocol{
    func getCreditInfo(completion: @escaping ((BaseModel?, Error?)-> ()))
}
