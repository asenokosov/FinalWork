//
//  EntryViewController.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var textField: UITextField!
	@IBOutlet var dataPicker: UIDatePicker!

    //private let realm = SaveManager()
    private let realm = try! Realm()
	public var complitionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
		dataPicker.setDate(Date(), animated: true)
		textField.becomeFirstResponder()
		textField.delegate = self
    }

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	@IBAction func saveButtonTapped() {
		if let text = textField.text, !text.isEmpty {
			let date = dataPicker.date
            let owner1 = UserDB()
			realm.beginWrite()

			let newItem = VisitHistory()
			newItem.date = date
			newItem.name = text
			newItem.owner = owner1
			realm.add(newItem)
			try! realm.commitWrite()
			complitionHandler?()
			navigationController?.popViewController(animated: true)
		} else {
			print("Something")
	}
}
}
