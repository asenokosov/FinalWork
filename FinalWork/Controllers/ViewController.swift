//
//  ViewController.swift
//  FinalWork
//
//  Created by Uzver on 18.12.2020.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
	@IBOutlet weak var loginButton: UIButton!

	override func viewDidLoad() {
        super.viewDidLoad()
		signUpElements()
    }

	func signUpElements() {
		Utilities.styleFilledButton(signUpButton)
		Utilities.styleHollowButton(loginButton)
	}
}
