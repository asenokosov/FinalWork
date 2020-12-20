//
//  HistoryViewController.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	private let realm = try! Realm()
	var visitList = [VisitHistory]()
	//var data = [PatientDB]()
	//var patient = PatientDB()

	//MARK: Outlet

	@IBOutlet weak var tableViewHistory: UITableView!

	//MARK: View did load

	override func viewDidLoad() {
		super.viewDidLoad()
		visitList = realm.objects(VisitHistory.self).map({$0})
		tableViewHistory.register(UITableViewCell.self, forCellReuseIdentifier: "VistCell")
		tableViewHistory.delegate = self
		tableViewHistory.dataSource = self
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return visitList.count
	}

	//MARK: Cell properties

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "VistCell", for: indexPath)
		cell.textLabel?.text = visitList[indexPath.row].name
		return cell
	}

	//MARK: Delete Row

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = visitList[indexPath.row]
		guard let vc = storyboard?.instantiateViewController(identifier: "view") as? DataViewController else { return }
		vc.item = item
		vc.deletionHandler = { [weak self] in
			self?.refresh()
		}
		vc.navigationItem.largeTitleDisplayMode = .never
		vc.title = item.name
		navigationController?.pushViewController(vc, animated: true)
		tableViewHistory.reloadData()
	}

	func refresh() {
		visitList = realm.objects(VisitHistory.self).map({$0})
		tableViewHistory.reloadData()
	}

	//MARK: IBAction's
	
	@IBAction func addButtonTapped() {
		guard  let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else { return }
		vc.complitionHandler = { [weak self] in
			self?.refresh()
		}
		vc.title = "Новый приём"
		vc.navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(vc, animated: true)
		tableViewHistory.reloadData()
	}
}
