//
//  NewManTableViewController.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import UIKit

class NewManTableViewController: UITableViewController {
	
	//MARK: Outlet/Action

	var imageIsChanged = false
	var currentUser: UserDB?

	@IBOutlet weak var saveButton: UIBarButtonItem!

	@IBOutlet weak var nameManField: UITextField!
	@IBOutlet weak var nameAnimalField: UITextField!
	@IBOutlet weak var ageAnimalField: UITextField!
	@IBOutlet weak var breedField: UITextField!
	@IBOutlet weak var historyButton: UIButton!
	@IBOutlet weak var imageAnimal: UIImageView!

	//MARK: View did load

	override func viewDidLoad() {
		super.viewDidLoad()

		saveButton.isEnabled = false

		nameManField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		nameAnimalField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		ageAnimalField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		breedField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		editCell()
	}

	//MARK: Action Sheet

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 4 {
			let photoIcon = #imageLiteral(resourceName: "photo")
			let cameraIcon = #imageLiteral(resourceName: "camera")

			let chooseAction = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

			let choosePhoto = UIAlertAction(title: "Photo", style: .default) { _ in
				self.chooseImage(source: .photoLibrary)
			}
			choosePhoto.setValue(photoIcon, forKey: "image")

			let chooseCamera = UIAlertAction(title: "Camera", style: .default) {_ in
				self.chooseImage(source: .camera)
			}
			chooseCamera.setValue(cameraIcon, forKey: "image")

			let chooseCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

			chooseAction.addAction(choosePhoto)
			chooseAction.addAction(chooseCamera)
			chooseAction.addAction(chooseCancel)

			present(chooseAction, animated: true)
		} else {
			tableView.endEditing(true)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}

	//MARK: Save New Object

	func saveMan() {
		var image: UIImage?

		if imageIsChanged {
			image = imageAnimal.image
		} else {
			image = #imageLiteral(resourceName: "Photo")
		}
		let imageAnimal = image?.pngData()
		let newPatient = UserDB(nameMan: nameManField.text!, nameAnimal: nameAnimalField.text, imageAnimal: imageAnimal, ageAnimal: ageAnimalField.text, breedAnimal: breedField.text)

		if currentUser != nil {
			try! realm.write() {
				currentUser?.nameMan = newPatient.nameMan
				currentUser?.nameAnimal = newPatient.nameAnimal
				currentUser?.imageAnimal = newPatient.imageAnimal
				currentUser?.breedAnimal = newPatient.breedAnimal
				currentUser?.ageAnimal = newPatient.ageAnimal
			}
		} else {
			SaveManagerUser.saveObject(newPatient)
		}
	}

	private func editCell() {
		if currentUser != nil {
			editNavigationBar()
			imageIsChanged = true
			guard let data = currentUser?.imageAnimal, let image = UIImage(data: data) else { return }
			imageAnimal.image = image
			nameManField.text = currentUser?.nameMan
			ageAnimalField.text = currentUser?.ageAnimal
			breedField.text = currentUser?.breedAnimal
			nameAnimalField.text = currentUser?.nameAnimal
		}
	}

	//MARK: Navigation Bar

	private func editNavigationBar() {
		if let topItem = navigationController?.navigationBar.topItem{
			topItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
		}
		navigationItem.leftBarButtonItem = nil
		title = currentUser?.nameMan
		saveButton.isEnabled = true
	}

	@IBAction func cancelAction(_ sender: Any) {
		dismiss(animated: true)
	}

	@IBAction func openHistoryTable(_ sender: Any) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "History") as? HistoryViewController else { return }
		vc.navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(vc, animated: true)
	}
}

//MARK: Extension Image

extension NewManTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func chooseImage(source: UIImagePickerController.SourceType) {
		if UIImagePickerController.isSourceTypeAvailable(source) {
			let imagePicker = UIImagePickerController()
			imagePicker.allowsEditing = true
			imagePicker.delegate = self
			imagePicker.sourceType = source
			present(imagePicker, animated: true)
		}
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		imageAnimal.image = info[.editedImage] as? UIImage
		imageAnimal.clipsToBounds = true
		imageIsChanged = true

		dismiss(animated: true)
	}
}

//MARK: Extension textField

extension NewManTableViewController: UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	@objc func textFieldDidChange () {
		if nameManField.text?.isEmpty == true ||
			ageAnimalField.text?.isEmpty == true ||
			nameAnimalField.text?.isEmpty == true {
			saveButton.isEnabled = false
		} else {
			saveButton.isEnabled = true
		}
	}
}
