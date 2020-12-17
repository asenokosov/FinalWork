//
//  UserViewController.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//
//
//import UIKit
//import RealmSwift
//
//class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//	var user: AnimalAndUserModel.Users!
//	var ref: DatabaseReference!
//	var animalAndUserModel = Array<AnimalAndUserModel.Animal>()
//
//	private var nameMan: Results<UserDB>!
//
//	@IBOutlet weak var tableView: UITableView!
//	
//	//MARK: View Did Load
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		nameMan = realm.objects(UserDB.self)
//
//		guard let currentUser = Auth.auth().currentUser else { return }
//		user = AnimalAndUserModel.Users(user: currentUser)
//		ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("animal")
//	}
//
//	//MARK: View Will Appear
//
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//
//		ref.observe(.value, with: { [weak self] (snapshot) in
//			var animals = Array<AnimalAndUserModel.Animal>()
//			for item in snapshot.children {
//				let animal = AnimalAndUserModel.Animal.init(snapshot: item as! DataSnapshot)
//				animals.append(animal)
//			}
//			self?.animalAndUserModel = animals
//			self?.tableView.reloadData()
//		})
//	}
//
//	override func viewWillDisappear(_ animated: Bool) {
//		super.viewWillDisappear(animated)
//		self.ref.removeAllObservers()
//	}
//
//	//MARK: Table View
//
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return animalAndUserModel.count
//	}
//
//	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//		return true
//	}
//
//	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//		if editingStyle == .delete {
//			let animal = animalAndUserModel[indexPath.row]
//			animal.ref?.removeValue()
//		}
//	}
//
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		guard let cell = tableView.cellForRow(at: indexPath) else { return }
//		let animal = animalAndUserModel[indexPath.row]
//		let complete = !animal.completed
//		toggleCompletion(cell, complete: complete)
//		animal.ref?.updateChildValues(["completed": complete])
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//		let animalTitle = animalAndUserModel[indexPath.row]
//		let animal = animalAndUserModel[indexPath.row]
//		let complete = animal.completed
//
//		cell.textLabel?.text = animalTitle.title
//		cell.backgroundColor = builder.setBackground
//		cell.textLabel?.textColor = builder.setText
//		toggleCompletion(cell, complete: complete)
//		return cell
//	}
//
//	func toggleCompletion(_ cell: UITableViewCell, complete: Bool) {
//		cell.accessoryType = complete ? .checkmark : .none
//	}
//
//	//MARK: Row
//
//	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//		tableView.deselectRow(at: indexPath, animated: true)
//	}
//
//	//MARK: Delete Row
//
//	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		var manList = UserDB()
//		let deleteMan = UIContextualAction(style: .normal, title: "Удалить") { (_, _, complete) in
//			SaveManager.deleteObject(manList)
//			tableView.deleteRows(at: [indexPath], with: .automatic)
//			tableView.reloadData()
//			complete(true)
//		}
//		deleteMan.backgroundColor = #colorLiteral(red: 1, green: 0.20458019, blue: 0.1013487829, alpha: 1)
//		let action = UISwipeActionsConfiguration(actions: [deleteMan])
//		return action
//	}
//
//	//MARK: IBActions
//
//	@IBAction func addButton(_ sender: UIBarButtonItem) {
//		let alert = UIAlertController(title: "Новая задача", message: "Добавьте новую задачу", preferredStyle: .alert)
//		alert.addTextField( )
//		let save = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
//			guard let textField = alert.textFields?.first, textField.text != "" else { return }
//			let animal = AnimalAndUserModel.Animal(title: textField.text!, userID: (self?.user.uid)!)
//			let animalRef = self?.ref.child(animal.title.lowercased())
//			animalRef?.setValue(["title": animal.title, "userID": animal.userID, "completed": animal.completed])
//		}
//		let cancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
//
//		alert.addAction(save)
//		alert.addAction(cancel)
//		present(alert, animated: true, completion: nil)
//	}
//
//	@IBAction func signOutButton(_ sender: UIBarButtonItem) {
//		do {
//			try Auth.auth().signOut()
//		} catch {
//			print(error.localizedDescription)
//		}
//		dismiss(animated: true, completion: nil)
//	}
//}
//
