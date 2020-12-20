//
//  EntryViewController.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
	
	private let realm = try! Realm()
	public var complitionHandler: (() -> Void)?
	
	//MARK: Outlet
	
	@IBOutlet var textField: UITextField!
	@IBOutlet var dataPicker: UIDatePicker!
	
	//MARK: View did load
	
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
	
	//MARK: IBAction's
	
	@IBAction func saveButtonTapped() {
		if let text = textField.text, !text.isEmpty {
			let date = dataPicker.date
			//			let patients = realm.objects(PatientDB.self).first
			//			guard let visitsHistorys = realm.objects(VisitHistory.self).first else { return }
			//			try! realm.write {
			//
			//			patients?.visit.append(visitsHistorys)
			//			}
			realm.beginWrite()
			
			let newItem = VisitHistory()
			newItem.date = date
			newItem.name = text
			//	let newMan = PatientDB()
			//	newMan.visit.append(newItem)
			realm.add(newItem)
			//	realm.add(newMan)
			try! realm.commitWrite()
			complitionHandler?()
			navigationController?.popViewController(animated: true)
		} else {
			print("Something")
		}
	}
}
