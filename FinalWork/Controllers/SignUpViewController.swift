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
	
	//MARK: Outlet
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextfield: UITextField!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var signUpButton: UIButton!
	
	//MARK: View did load
	
	override func viewDidLoad() {
		super.viewDidLoad()
		signUpElements()
	}
	
	//MARK: Button Appearance
	
	func signUpElements() {
		errorLabel.alpha = 0
		Utilities.styleTextField(firstNameTextField)
		Utilities.styleTextField(lastNameTextField)
		Utilities.styleTextField(passwordTextField)
		Utilities.styleTextField(emailTextfield)
		Utilities.styleFilledButton(signUpButton)
	}
	
	//MARK: Text Fields Validate
	
	func validateFields() -> String? {
		if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
			return "Все поля обязательны к заполнению"
		}
		let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if Utilities.isPasswordValid(cleanedPassword) == false {
			return "Пожалуйста, используйте спец.символы"
		}
		return nil
	}
	
	func errorMassege(_ message: String) {
		errorLabel.text = message
		errorLabel.alpha = 1
	}
	
	func trasitionToMain() {
		let mainViewController = storyboard?.instantiateViewController(identifier: "MainVC") as? UINavigationController
		view.window?.rootViewController = mainViewController
		view.window?.makeKeyAndVisible()
	}
	
	//MARK: IBAction's
	
	@IBAction func signUpTapped(_ sender: UIButton) {
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
					self.errorMassege("Ошибка создания пользователя. Возможно вы опечатались")
				} else {
					let db = Firestore.firestore()
					db.collection("users").addDocument(data: ["userName": userName, "userNickName": userNickName, "uid": result!.user.uid]) { (error) in
						if error != nil {
							self.errorMassege("Ошибка при сохранении, возможно, пользователь уже существует")
						}
					}
					self.trasitionToMain()
				}
			}
			sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
			
			UIView.animate(withDuration: 2.0,
						   delay: 0,
						   usingSpringWithDamping: CGFloat(0.20),
						   initialSpringVelocity: CGFloat(6.0),
						   options: UIView.AnimationOptions.allowUserInteraction,
						   animations: {
							sender.transform = CGAffineTransform.identity
						   },
						   completion: { Void in()  }
			)
		}
	}
	
	@IBAction func signOut(_ sender: Any) {
		let mainViewController = self.storyboard?.instantiateViewController(identifier: "firstNavigationController") as? UINavigationController
		self.view.window?.rootViewController = mainViewController
		self.view.window?.makeKeyAndVisible()
	}
}
