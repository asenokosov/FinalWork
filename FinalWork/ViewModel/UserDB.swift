//
//  UserDB.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import RealmSwift

class UserDB: Object {
	@objc dynamic var nameMan = ""
	@objc dynamic var nameAnimal: String?
	@objc dynamic var imageAnimal: Data?
	@objc dynamic var ageAnimal: String?
	@objc dynamic var breedAnimal: String?

	convenience init(nameMan: String, nameAnimal: String?, imageAnimal: Data?, ageAnimal: String?, breedAnimal: String?) {
	self.init()
		self.nameMan = nameMan
		self.nameAnimal = nameAnimal
		self.imageAnimal = imageAnimal
		self.ageAnimal = ageAnimal
		self.breedAnimal = breedAnimal
	}
}


