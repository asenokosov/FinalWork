//
//  VisitDB.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import Foundation
import RealmSwift

class VisitHistory: Object {
	
	@objc dynamic var name: String = ""
	@objc dynamic var date: Date = Date()
//	@objc dynamic var accountID = UUID().uuidString
//
//	let userAnimal = LinkingObjects(fromType: PatientDB.self, property: "visit")
//
//	override static func primaryKey() -> String? {
//		return "accountID"
//	}
}


