//
//  User.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import Foundation
import Firebase

struct Users {
	let uid: String
	let email: String
	
	init(user: User) {
		self.uid = user.uid
		self.email = user.email!
	}
}
