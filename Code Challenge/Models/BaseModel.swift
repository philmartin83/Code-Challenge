//
//  BaseModel.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation
struct BaseModel : Codable {
	let accountIDVStatus : String?
	let creditReportInfo : CreditReportInfo?
	let dashboardStatus : String?
	let personaType : String?
	let coachingSummary : CoachingSummary?
	let augmentedCreditScore : String?
}
