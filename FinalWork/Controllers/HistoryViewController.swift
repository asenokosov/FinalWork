//
//  HistoryViewController.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableViewHistory: UITableView!

	private let realm = try! Realm()
	private var data = [VisitHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()
		data = realm.objects(VisitHistory.self).map({ $0 })
		tableViewHistory.register(UITableViewCell.self, forCellReuseIdentifier: "VistCell")
		tableViewHistory.delegate = self
		tableViewHistory.dataSource = self
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "VistCell", for: indexPath)
		cell.textLabel?.text = data[indexPath.row].name
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let item = data[indexPath.row]
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

	func refresh() {
		data = realm.objects(VisitHistory.self).map({ $0 })
		tableViewHistory.reloadData()
	}
}
