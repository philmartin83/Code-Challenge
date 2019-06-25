//
//  CreditReportInfo.swift
//  Code Challenge
//
//  Created by Philip Martin on 07/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import Foundation

// for this demo not all the properties are needed
struct CreditReportInfo : Codable {
	let score : Int?
	let scoreBand : Int?
	let clientRef : String?
	let status : String?
	let maxScoreValue : Int?
	let minScoreValue : Int?
	let monthsSinceLastDefaulted : Int?
	let hasEverDefaulted : Bool?
	let monthsSinceLastDelinquent : Int?
	let hasEverBeenDelinquent : Bool?
	let percentageCreditUsed : Int?
	let percentageCreditUsedDirectionFlag : Int?
	let changedScore : Int?
	let currentShortTermDebt : Int?
	let currentShortTermNonPromotionalDebt : Int?
	let currentShortTermCreditLimit : Int?
	let currentShortTermCreditUtilisation : Int?
	let changeInShortTermDebt : Int?
	let currentLongTermDebt : Int?
	let currentLongTermNonPromotionalDebt : Int?
	let currentLongTermCreditLimit : String?
	let currentLongTermCreditUtilisation : String?
	let changeInLongTermDebt : Int?
	let numPositiveScoreFactors : Int?
	let numNegativeScoreFactors : Int?
	let equifaxScoreBand : Int?
	let equifaxScoreBandDescription : String?
	let daysUntilNextReport : Int?

}
