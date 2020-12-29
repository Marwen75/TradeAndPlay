//
//  TradeAndPlayUITests.swift
//  TradeAndPlayUITests
//
//  Created by Marwen Haouacine on 29/11/2020.
//

import XCTest

class TradeAndPlayUITests: XCTestCase {

    // MARK: - Properties and setup
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testUiInSearchTab() {
        
        app.textFields["Enter your text here"].tap()
        
        app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
       
        eKey.tap()
        
        let vKey = app/*@START_MENU_TOKEN@*/.keys["v"]/*[[".keyboards.keys[\"v\"]",".keys[\"v\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        vKey.tap()
        
        iKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons.containing(.staticText, identifier:"Search").element.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Genres: Platform, Hack and slash/Beat 'em up, Adventure")/*[[".cells.containing(.staticText, identifier:\"First released: 2000-04-19\")",".cells.containing(.staticText, identifier:\"Genres: Platform, Hack and slash\/Beat 'em up, Adventure\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Tap to see details"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Summary"]/*[[".otherElements[\"Summary\"].staticTexts[\"Summary\"]",".staticTexts[\"Summary\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .faceUp
        tablesQuery.staticTexts["Add to owned"].tap()
        
        XCTAssertNotNil(tablesQuery)
    }
    
    func testUiInLibraryTab() {
        
        app.tabBars["Tab Bar"].buttons["Library"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Your research"]/*[[".segmentedControls.buttons[\"Your research\"]",".buttons[\"Your research\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Your trades"]/*[[".segmentedControls.buttons[\"Your trades\"]",".buttons[\"Your trades\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Trade&Play"].buttons["Item"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["You here?"]/*[[".cells.staticTexts[\"You here?\"]",".staticTexts[\"You here?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textViews.containing(.staticText, identifier:"Tap your text here.").element.tap()
        app/*@START_MENU_TOKEN@*/.keys["Y"]/*[[".keyboards.keys[\"Y\"]",".keys[\"Y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
    
        app/*@START_MENU_TOKEN@*/.staticTexts["Send"]/*[[".buttons[\"Send\"].staticTexts[\"Send\"]",".staticTexts[\"Send\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .faceUp
        
        XCTAssertNotNil(app.staticTexts["Send"])
    }
    
    func testUiForTradingAgame() {
        
        app.textFields["Enter your text here"].tap()
        
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["espace"]/*[[".keyboards.keys[\"espace\"]",".keys[\"espace\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        iKey.tap()
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        iKey.tap()
        sKey.tap()

        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons.containing(.staticText, identifier:"Search").element.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"First released: 1999-07-01")/*[[".cells.containing(.staticText, identifier:\"Rated: 77\/100\")",".cells.containing(.staticText, identifier:\"First released: 1999-07-01\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Tap to see details"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Screenshots"]/*[[".otherElements[\"Screenshots\"].staticTexts[\"Screenshots\"]",".staticTexts[\"Screenshots\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.staticTexts["Add to owned"].tap()
        app.alerts["Done!"].scrollViews.otherElements.buttons["OK"].tap()
        
        app.tabBars["Tab Bar"].buttons["Library"].tap()
        
        let tablesQuery2 = app.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Declare a Trade!"]/*[[".cells",".buttons[\"Declare a Trade!\"].staticTexts[\"Declare a Trade!\"]",".staticTexts[\"Declare a Trade!\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Enter your text here"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards",".buttons[\"majuscule\"]",".buttons[\"shift\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["I"]/*[[".keyboards.keys[\"I\"]",".keys[\"I\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        oKey.tap()
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Confirm Trade"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Your trades"]/*[[".segmentedControls.buttons[\"Your trades\"]",".buttons[\"Your trades\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Trade Over ?"]/*[[".cells.buttons[\"Trade Over ?\"]",".buttons[\"Trade Over ?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Done"].scrollViews.otherElements.buttons["OK"].tap()
        XCUIDevice.shared.orientation = .faceUp
        
        XCTAssertNotNil(tablesQuery2)
    }
    
    func testUiForFindingAPlayer() {
        
        app.textFields["Enter your text here"].tap()
        
        app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        eKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["v"]/*[[".keyboards.keys[\"v\"]",".keys[\"v\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        iKey.tap()
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
        app.buttons.containing(.staticText, identifier:"Search").element.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Genres: Platform, Hack and slash/Beat 'em up, Adventure")/*[[".cells.containing(.staticText, identifier:\"First released: 2000-04-19\")",".cells.containing(.staticText, identifier:\"Genres: Platform, Hack and slash\/Beat 'em up, Adventure\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Tap to see details"].tap()

        let tablesQuery = app.tables
        //tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Summary"]/*[[".otherElements[\"Summary\"].staticTexts[\"Summary\"]",".staticTexts[\"Summary\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["who has it?"]/*[[".cells",".buttons[\"who has it?\"].staticTexts[\"who has it?\"]",".staticTexts[\"who has it?\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Contact?"]/*[[".cells.buttons[\"Contact?\"]",".buttons[\"Contact?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textViews.staticTexts["Tap your text here."].tap()
        app/*@START_MENU_TOKEN@*/.keys["H"]/*[[".keyboards.keys[\"H\"]",".keys[\"H\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        eKey.tap()
        lKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        oKey.tap()
        doneButton.tap()
        app.buttons["Send"].tap()
        
        XCTAssertNotNil(app.buttons["Send"])
    }
    
    func testUiForSearchGame() {
        
        app.textFields["Enter your text here"].tap()
        XCUIDevice.shared.orientation = .faceUp
        
        app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
    
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons.containing(.staticText, identifier:"Search").element.tap()
        XCUIDevice.shared.orientation = .portrait
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tap to see details"]/*[[".cells.staticTexts[\"Tap to see details\"]",".staticTexts[\"Tap to see details\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Screenshots"]/*[[".otherElements[\"Screenshots\"].staticTexts[\"Screenshots\"]",".staticTexts[\"Screenshots\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .faceUp
        tablesQuery.staticTexts["Add to search"].tap()
        app.alerts["Done!"].scrollViews.otherElements.buttons["OK"].tap()
        app.tabBars["Tab Bar"].buttons["Library"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Your research"]/*[[".segmentedControls.buttons[\"Your research\"]",".buttons[\"Your research\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotNil(tablesQuery)
    }
}
