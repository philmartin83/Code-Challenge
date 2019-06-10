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

	enum CodingKeys: String, CodingKey {

		case activeTodo = "activeTodo"
		case activeChat = "activeChat"
		case numberOfTodoItems = "numberOfTodoItems"
		case numberOfCompletedTodoItems = "numberOfCompletedTodoItems"
		case selected = "selected"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		activeTodo = try values.decodeIfPresent(Bool.self, forKey: .activeTodo)
		activeChat = try values.decodeIfPresent(Bool.self, forKey: .activeChat)
		numberOfTodoItems = try values.decodeIfPresent(Int.self, forKey: .numberOfTodoItems)
		numberOfCompletedTodoItems = try values.decodeIfPresent(Int.self, forKey: .numberOfCompletedTodoItems)
		selected = try values.decodeIfPresent(Bool.self, forKey: .selected)
	}

}
