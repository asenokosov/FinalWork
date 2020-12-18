//
//  SignUpViewController.swift
//  FinalWork
//
//  Created by Uzver on 18.12.2020.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextfield: UITextField!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var signUpButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		signUpElements()
	}

	func signUpElements() {
		errorLabel.alpha = 0
		Utilities.styleTextField(firstNameTextField)
		Utilities.styleTextField(lastNameTextField)
		Utilities.styleTextField(passwordTextField)
		Utilities.styleTextField(emailTextfield)
		Utilities.styleFilledButton(signUpButton)
	}

	func validateFields() -> String? {
		if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
			return "Заполните все поля."
		}
		let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

		if Utilities.isPasswordValid(cleanedPassword) == false {
			return "Нет специсимволов"
		}
		return nil
	}

	@IBAction func signUpTapped(_ sender: Any) {
		let error = validateFields()
		if error != nil {
			errorMassege(error!)
		} else {

			let userName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let userNickName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

			Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
				if err != nil {
					self.errorMassege("Error create")
				} else {
					let db = Firestore.firestore()
					db.collection("users").addDocument(data: ["userName": userName, "userNickName": userNickName, "uid": result!.user.uid]) { (error) in
						if error != nil {
							self.errorMassege("Какая-то ошибка при сохранении")
						}
					}
					self.trasitionToMain()
				}
			}
		}
	}

	func errorMassege(_ message: String) {
		errorLabel.text = message
		errorLabel.alpha = 1
	}

	func trasitionToMain() {
		let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? MainViewController
		view.window?.rootViewController = mainViewController
		view.window?.makeKeyAndVisible()
	}
}
