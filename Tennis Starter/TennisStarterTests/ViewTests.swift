//
//  ViewTests.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 23/04/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

import XCTest

class ViewTests: XCTestCase {
    var view: ViewController!
    var mirror: Mirror!
    
    var tennis: TennisMain!
    var tennisMirror: Mirror!
    override func setUp() {
        view = ViewController()
        mirror = Mirror(reflecting: view!)
        tennis = TennisMain()
        tennisMirror = Mirror(reflecting: tennis!)
        
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        tennis.SetInstance.addGameToPlayer1()
        view.playerTextLabelsSet()
        var check = view.p1GamesLabel.text
        XCTAssertEqual("0", check)
    }



}
