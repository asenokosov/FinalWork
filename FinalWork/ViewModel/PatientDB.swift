//
//  PatientDB.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import RealmSwift

class PatientDB: Object {
	@objc dynamic var nameMan = ""
	@objc dynamic var nameAnimal: String?
	@objc dynamic var imageAnimal: Data?
	@objc dynamic var ageAnimal: String?
	@objc dynamic var breedAnimal: String?
	//@objc dynamic var id = UUID().uuidString

	//let visit = List<VisitHistory>()

	convenience init(nameMan: String, nameAnimal: String?, imageAnimal: Data?, ageAnimal: String?, breedAnimal: String?) {
	self.init()
		self.nameMan = nameMan
		self.nameAnimal = nameAnimal
		self.imageAnimal = imageAnimal
		self.ageAnimal = ageAnimal
		self.breedAnimal = breedAnimal
	}
//	override static func primaryKey() -> String? {
//		return "id"
//	}
}


