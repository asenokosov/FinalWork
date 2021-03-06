//
//  Utilities.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import UIKit

class Utilities {
	
	static func styleTextField(_ textfield:UITextField) {
		
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
		bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 173/255, blue: 74/255, alpha: 1).cgColor
		textfield.borderStyle = .none
		textfield.layer.addSublayer(bottomLine)
	}
	
	static func styleFilledButton(_ button:UIButton) {
		
		button.backgroundColor = UIColor.init(red: 255/255, green: 133/255, blue: 57/255, alpha: 1)
		button.layer.cornerRadius = 25.0
		button.tintColor = UIColor.white
	}
	
	static func styleHollowButton(_ button:UIButton) {
		
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor.init(red: 255/255, green: 157/255, blue: 74/255, alpha: 1).cgColor
		button.layer.cornerRadius = 25.0
		button.tintColor = UIColor.white
	}
	
	static func isPasswordValid(_ password : String) -> Bool {
		
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
		return passwordTest.evaluate(with: password)
	}
}
