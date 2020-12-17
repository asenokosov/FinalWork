//
//  CellTheme.swift
//  FinalWork
//
//  Created by Uzver on 15.12.2020.
//

import UIKit

protocol ThemeBuilderProtocol {
	var setBackground: UIColor { get set }
	var setText: UIColor { get set }
}

class CellThemeBuilder: ThemeBuilderProtocol {
	var setBackground: UIColor
	var setText: UIColor

	init(setBackground: UIColor, setText: UIColor) {
		self.setBackground = setBackground
		self.setText = setText
	}
	private var backgroundColor: UIColor?
	private var textColor: UIColor?
}

let builder = CellThemeBuilder(setBackground: .clear, setText: .white)
