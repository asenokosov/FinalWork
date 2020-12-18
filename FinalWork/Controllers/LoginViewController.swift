//
//  UserViewController.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
	
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var errorLebel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		signUpElements()
	}
	
	func signUpElements() {
		errorLebel.alpha = 0
		Utilities.styleTextField(emailTextField)
		Utilities.styleFilledButton(loginButton)
		Utilities.styleTextField(passwordTextField)
	}
	
	@IBAction func loginButtonTapped(_ sender: Any) {
		let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
			if error != nil {
				self.errorLebel.text = error!.localizedDescription
				self.errorLebel.alpha = 1
			} else {
				let mainViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? MainViewController
				self.view.window?.rootViewController = mainViewController
				self.view.window?.makeKeyAndVisible()
			}
		}
	}
}
