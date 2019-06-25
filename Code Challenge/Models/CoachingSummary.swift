//
//  CoachingSummary.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation

struct CoachingSummary : Codable {
	let activeTodo : Bool?
	let activeChat : Bool?
	let numberOfTodoItems : Int?
	let numberOfCompletedTodoItems : Int?
	let selected : Bool?
}
