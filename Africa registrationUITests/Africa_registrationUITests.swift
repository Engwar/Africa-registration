//
//  Africa_registrationUITests.swift
//  Africa registrationUITests
//
//  Created by Igor Shelginskiy on 12/21/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import XCTest

class Africa_registrationUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		self.continueAfterFailure = false
		self.app = XCUIApplication()
		self.app.launch()
	}

	override func tearDown() {

		super.tearDown()
	}

	func testLabel() {
		print(app.debugDescription)
		let text1 = self.app.staticTexts["Adults"]
		let text2 = self.app.staticTexts["Children"]
		XCTAssertTrue(text1.exists)
		XCTAssertTrue(text2.exists)
	}

	func testStepper() {
		self.app.buttons["Increment"].firstMatch.tap()
		self.app.buttons["Increment"].firstMatch.tap()
		self.app.buttons["Increment"].firstMatch.tap()
		let text3 = self.app.staticTexts["adultsCount"]
		XCTAssertTrue(text3.label == "4")
	}
}
