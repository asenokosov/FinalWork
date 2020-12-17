//
//  DataViewController.swift
//  FinalWork
//
//  Created by Uzver on 17.12.2020.
//

import RealmSwift
import UIKit

class DataViewController: UIViewController {

	public var item: VisitHistory?
	public var deletionHandler: (() -> Void)?
	private let realm = try! Realm()

	@IBOutlet var itemLabel: UILabel!
	@IBOutlet var dataLabel: UILabel!

	static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		return dateFormatter
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		itemLabel.text = item?.name
		dataLabel.text = Self.dateFormatter.string(from: item!.date)

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    

	@objc private func didTapDelete() {
		guard let oldItem = self.item else { return }
		realm.beginWrite()

		realm.delete(oldItem)

		try! realm.commitWrite()
		deletionHandler?()
		navigationController?.popViewController(animated: true)
	}
}
