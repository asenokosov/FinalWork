//
//  LoginViewController.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import UIKit
import RealmSwift
import Firebase

class MainViewController: UITableViewController, UISearchResultsUpdating {

	//MARK: Properties

	private var userDataBase: Results<UserDB>!
	private var filteredUser: Results<UserDB>!

	let searchController = UISearchController(searchResultsController: nil)
	var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}

	var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}

	@IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
		guard let newManVC = segue.source as? NewManTableViewController else { return }
		newManVC.saveMan()
		tableView.reloadData()
	}

	//MARK: View did load

	override func viewDidLoad() {
		super.viewDidLoad()
		userDataBase = realm.objects(UserDB.self)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Тут найдешь ты искомое"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}

	//MARK: SearchBar

	func updateSearchResults(for searchController: UISearchController) {
		filteredCars(searchController.searchBar.text!)
		tableView.reloadData()
	}

	private func filteredCars(_ searchText: String) {
		filteredUser = userDataBase.filter("nameMan CONTAINS[c] %@ OR nameAnimal CONTAINS[c] %@", searchText , searchText)
		tableView.reloadData()
	}

	//MARK: Row

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return filteredUser.count
		}
		return userDataBase.isEmpty ? 0 : userDataBase.count
	}

	//MARK: Delete Row

	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		var manList = UserDB()

		if isFiltering {
			manList = filteredUser[indexPath.row]
		} else {
			manList = userDataBase[indexPath.row]
		}
		let deleteMan = UIContextualAction(style: .normal, title: "Удалить") {_, _, complete in
			SaveManagerUser.deleteObject(manList)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			tableView.reloadData()
			complete(true)
		}
		deleteMan.backgroundColor = #colorLiteral(red: 1, green: 0.20458019, blue: 0.1013487829, alpha: 1)
		let action = UISwipeActionsConfiguration(actions: [deleteMan])
		return action
	}

	//MARK: Cell properties

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
		let newManAdd = isFiltering ? filteredUser[indexPath.row] : userDataBase[indexPath.row]

		cell.nameLabel.text = newManAdd.nameMan
		cell.animalLabel.text = newManAdd.breedAnimal
		cell.fotoAnimal.image = UIImage(data: newManAdd.imageAnimal!)
		cell.fotoAnimal.layer.cornerRadius = cell.fotoAnimal.frame.size.height / 2.5
		cell.fotoAnimal.clipsToBounds = true

		return cell
	}

	//MARK: Segue

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			let man = isFiltering ? filteredUser[indexPath.row] : userDataBase[indexPath.row]
			let newManVC = segue.destination as! NewManTableViewController
			newManVC.currentUser = man
		}
	}

	@IBAction func signOut(_ sender: UIBarButtonItem) {
		do {
			try Auth.auth().signOut()
		} catch {
			print(error.localizedDescription)
		}
		dismiss(animated: true, completion: nil)
	}
}

//MARK: Extension Search Bar

extension MainViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		if searchBar.text == "" {
			navigationController?.hidesBarsOnSwipe = false
		}
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		navigationController?.hidesBarsOnSwipe = true
	}
}

