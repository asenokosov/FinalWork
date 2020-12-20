//
//  SaveManager.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//


import RealmSwift

let realm = try! Realm()

class SaveManagerUser {
	static func saveObject (_ UserDB: PatientDB) {
		try! realm.write {
			realm.add(UserDB)
		}
	}
	static func deleteObject (_ UserDB: PatientDB) {
		try! realm.write {
			realm.delete(UserDB)
		}
	}
}
