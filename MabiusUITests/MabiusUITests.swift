//
//  MabiusUITests.swift
//  MabiusUITests
//
//  Created by Andrey Toropchin on 11.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import XCTest
import SwiftyUserDefaults

class MabiusUITests: XCTestCase
{
    let app = XCUIApplication()

    override func setUp()
    {
        super.setUp()
        
        continueAfterFailure = false

        app.launchEnvironment = ["testing": "1"]
        app.launch()

        sleep(1) // to be sure that app is ready
    }

    func _testLoginButtonVisibility()
    {
        let email = app.textFields["email"]
        let password = app.secureTextFields["password"]

        let be = { return self.app.buttons["login"].isEnabled }

        test("empty input -> button hidden").expect { email <-- ""; password <-- "" }.will(be, false)

        test("wrong email -> button hidden").expect { email <-- "qweqweqwewe"; password <-- "1df32323f23f23" }.will(be, false)

        test("valid email, short password -> button hidden").expect { email <-- "qwe@ya.ru"; password <-- "123" }.will(be, false)

        test("valid email, valid password -> button visible").expect { password <-- "122k3jh2kj34h3" }.will(be, true)
    }

    func _testPasswordRecovery()
    {
        let email = app.textFields["email"]

        let be = { return self.app.buttons["send"].isEnabled }

        // test screen navigation
        app.buttons["recovery"].tap() // go to Recovery screen
        XCTAssert(app.navigationBars["Восстановление пароля"].exists)

        test("empty input -> button hidden").expect { email <-- "" }.will(be, false)

        test("wrong email -> button hidden").expect { email <-- "qweqweqwewe" }.will(be, false)

        test("valid email -> button visible").expect { email <-- "qwe@ya.ru" }.will(be, true)
    }

    func _testRegistration()
    {
        // test screen navigation
        app.buttons["reg"].tap() // go to Registration screen
        XCTAssert(app.navigationBars["Регистрация"].exists)

        // buttons disabled by default
        app.tables.staticTexts["Зарегистрироваться"].tap();
        XCTAssert(self.app.navigationBars["Регистрация"].exists)

        let nameCell = app.cell("Имя", type: .textField)
        let familyCell = app.cell("Фамилия", type: .textField)
        let emailCell = app.cell("Email", type: .textField)
        let passwordCell = app.cell("Пароль", type: .secureTextField)
        let passwordConfirmCell = app.cell("Подтверждение", type: .secureTextField)
        let inviteCell = app.cell("Инвайт-код", type: .textField)
        let acceptCell = app.tables.switches["Cогласие с условиями использования"]

        let be = { return self.app.navigationBars.buttons["Готово"].isEnabled }

        test("check initial state").expect { /* nothing */ }.will(be, false)

        test("prefill table (not valid yet)").expect {
            nameCell <-- "John" // required
            familyCell <-- "Galt" // optional
            emailCell <-- "ya@ya.ru" // required
            passwordCell <-- "d2n32r" // required
            passwordConfirmCell <-- "fadf"; // required to be equal to passwordCell
            inviteCell <-- "test" // optional

        }.will(be, false)

        test("password mismatch -> fail").expect { acceptCell.tap() }.will(be, false)

        test("passwords equals -> ok").expect { passwordConfirmCell <-- "d2n32r" }.will(be, true)

        test("didn't accept offer -> fail").expect { acceptCell.tap() }.will(be, false)

        acceptCell.tap() // accept offer

        test("invalid email -> fail").expect { emailCell <-- "123" }.will(be, false)

        nameCell.tap() // hack to lose focus on email cell
        test("valid email -> ok").expect { emailCell <-- "test@ya.ru" }.will(be, true)

        test("empty name cell -> fail").expect { nameCell <-- "" }.will(be, false)

        nameCell <-- "John"
        test("empty email cell -> fail").expect { emailCell <-- "" }.will(be, false)
    }

    func _testFeed()
    {
        app.textFields["email"] <-- "test@ya.ru"
        app.secureTextFields["password"] <-- "testing"
        app.buttons["login"].tap() // go to Feed screen

        XCTAssert(app.navigationBars["CYL"].exists)
        
        app.navigationBars["CYL"].buttons["Карта"].tap()
    }
}
