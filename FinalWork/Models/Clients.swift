//
//  Clients.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//


import Foundation
import Firebase

struct Animal {
	let title: String
	let userID: String
	let ref: DatabaseReference?
	var completed: Bool
	
	init (title: String, userID: String) {
		self.title = title
		self.userID = userID
		self.ref = nil
		self.completed = false
	}

	init(snapshot: DataSnapshot) {
		let snapshotValue = snapshot.value as! [String: AnyObject]
		title = snapshotValue["title"] as! String
		userID = snapshotValue["userID"] as! String
		ref = snapshot.ref
		completed = snapshotValue["completed"] as! Bool
	}
}
