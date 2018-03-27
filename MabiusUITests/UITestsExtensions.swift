//
//  UITestsExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 13.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import XCTest

extension XCUIElement
{
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String) -> Void
    {
        guard let stringValue = self.value as? String else
        {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        var deleteString: String = ""
        for _ in stringValue.characters { deleteString += "\u{8}" }
        self.typeText(deleteString)

        self.typeText(text)
    }
}

extension XCUIApplication
{
    func cell(_ id: String, type: XCUIElementType) -> XCUIElement
    {
        return self.tables.cells.containing(.staticText, identifier:id).children(matching: type).element
    }
}

extension XCTestCase
{
    func test(_ description: String) -> String
    {
        return description
    }
}

extension String
{
    func expect(action: () -> ()) -> String
    {
        action()
        return self
    }

    func will(_ check: () -> Bool, _ result : Bool)
    {
        XCTAssert(check() == result, self)
    }
}

infix operator <--
func <-- (left: XCUIElement, right: String) { left.clearAndEnterText(right) }
