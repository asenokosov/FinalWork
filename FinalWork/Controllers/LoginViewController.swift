//
//  LoginViewController.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
	
	//MARK: Outlet
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var errorLebel: UILabel!
	
	//MARK: View did load
	
	override func viewDidLoad() {
		super.viewDidLoad()
		signUpElements()
	}
	
	//MARK: Button Appearance
	
	func signUpElements() {
		errorLebel.alpha = 0
		Utilities.styleTextField(emailTextField)
		Utilities.styleFilledButton(loginButton)
		Utilities.styleTextField(passwordTextField)
	}
	
	//MARK: IBAction's
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
			if error != nil {
				self.errorLebel.text = error!.localizedDescription
				self.errorLebel.alpha = 1
			} else {
				let mainViewController = self.storyboard?.instantiateViewController(identifier: "MainVC") as? UINavigationController
				self.view.window?.rootViewController = mainViewController
				self.view.window?.makeKeyAndVisible()
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
	
	@IBAction func signOut(_ sender: Any) {
		let mainViewController = self.storyboard?.instantiateViewController(identifier: "firstNavigationController") as? UINavigationController
		self.view.window?.rootViewController = mainViewController
		self.view.window?.makeKeyAndVisible()
	}
}
